-- =============================================================================
-- IBD 2026/27 — Entrega 3 — Clínica Veterinária
-- data_export.sql : exporta o registo clínico do PostgreSQL em JSON, com um
--                   documento por episódio, na estrutura da coleção
--                   "episodios" (mongo/model.js).
--
-- Este ficheiro foi integralmente gerado pelo assistente de inteligência
-- artificial Claude, da Anthropic.
--
-- Execução: normalmente através de migrate.sh (macOS/Linux) ou migrate.bat
-- (Windows), que recriam a coleção (mongo/model.js), correm este ficheiro e
-- importam o resultado. Para o correr à mão (um documento JSON por linha):
--     psql -q -At -v ON_ERROR_STOP=1 -d clinica_vet -f data_export.sql -o episodios.json
--     mongoimport --uri "mongodb://localhost:27017/clinica_vet" -c episodios --file episodios.json
--
-- DECISÕES DE IMPLEMENTAÇÃO
-- -----------------------------------------------------------------------------
-- - row_to_json(t) converte uma linha num objeto JSON, com uma propriedade por
--   coluna. Os objetos embedded (animal, internamento, colaborador, ...) são
--   subqueries com row_to_json.
-- - json_agg(...) agrega várias linhas num array JSON (como COUNT ou SUM, mas
--   junta as linhas): observações, atos, anexos, pedidos e análises pedidas.
--   Sem linhas devolve NULL, por isso o array fica ausente (ver abaixo).
-- - json_strip_nulls(...) remove os campos com valor NULL: no MongoDB os campos
--   sem valor são omitidos (ex.: episódio aberto sem data_hora_fim).
-- - Datas: row_to_json escreve um TIMESTAMP como texto, que o mongoimport
--   guardaria como string (e o validador rejeitaria). A função fn_data_mongo
--   escreve {"$date": "AAAA-MM-DDTHH:MI:SSZ"}, que o mongoimport converte no
--   tipo date. Os TIMESTAMP (sem fuso horário) são tratados como UTC.
-- - Números: os NUMERIC saem com casas decimais (ex.: 38.0) e o mongoimport
--   guarda-os como double; os INT saem sem casas e ficam int. Por isso a
--   importação é feita com o mongoimport.
-- - psql -At em vez de COPY ... TO STDOUT: o COPY (formato de texto) duplica as
--   barras invertidas, e um texto com aspas ("Dor \"aguda\"") ficaria com um
--   JSON inválido. -A tira o alinhamento, -t os cabeçalhos e -q as mensagens.
-- - Os arrays são ordenados pelo id (ordem de registo).
-- =============================================================================

-- Função auxiliar: converte um TIMESTAMP para o formato de data do mongoimport.
-- Devolve NULL para um TIMESTAMP NULL (o campo é depois removido por
-- json_strip_nulls).
-- A função fica na base de dados (não é apagada no fim do script), para que o
-- SELECT possa ser executado sozinho num editor SQL (para inspecionar o JSON).
-- CREATE OR REPLACE permite reexecutar o script.
CREATE OR REPLACE FUNCTION fn_data_mongo(p_data TIMESTAMP)
RETURNS JSON AS $$
BEGIN
    IF p_data IS NULL THEN
        RETURN NULL;
    END IF;
    RETURN (SELECT row_to_json(d)
              FROM (SELECT to_char(p_data, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') AS "$date") AS d);
END;
$$ LANGUAGE plpgsql;

SELECT json_strip_nulls(row_to_json(ep))
  FROM (SELECT e.id_episodio AS _id,

               -- Animal: referência + cópia de nome, espécie e cliente
               (SELECT row_to_json(x)
                  FROM (SELECT an.id_animal, an.nome, an.especie, an.id_cliente) AS x) AS animal,

               fn_data_mongo(e.data_hora_inicio) AS data_hora_inicio,
               fn_data_mongo(e.data_hora_fim)    AS data_hora_fim,

               -- Internamento (1:1): subdocumento; NULL se não houve
               (SELECT row_to_json(x)
                  FROM (SELECT i.id_internamento,
                               fn_data_mongo(i.data_hora_inicio) AS data_hora_inicio,
                               fn_data_mongo(i.data_hora_fim)    AS data_hora_fim
                          FROM internamento AS i
                         WHERE i.id_episodio = e.id_episodio) AS x) AS internamento,

               -- Observações
               (SELECT json_agg(row_to_json(x) ORDER BY x.id_observacao)
                  FROM (SELECT o.id_observacao,
                               fn_data_mongo(o.data_hora) AS data_hora,
                               (SELECT row_to_json(c)
                                  FROM (SELECT p.id_pessoa AS id_colaborador, p.nome) AS c) AS colaborador,
                               o.peso, o.temperatura, o.freq_cardiaca, o.freq_respiratoria, o.notas
                          FROM observacao AS o
                          JOIN pessoa     AS p ON o.id_colaborador = p.id_pessoa
                         WHERE o.id_episodio = e.id_episodio) AS x) AS observacoes,

               -- Atos clínicos, cada um com os seus anexos
               (SELECT json_agg(row_to_json(x) ORDER BY x.id_ato)
                  FROM (SELECT a.id_ato,
                               fn_data_mongo(a.data_hora) AS data_hora,
                               (SELECT row_to_json(s)
                                  FROM (SELECT sv.id_servico, sv.designacao) AS s) AS servico,
                               (SELECT row_to_json(c)
                                  FROM (SELECT p.id_pessoa AS id_colaborador, p.nome) AS c) AS colaborador,
                               a.id_marcacao,
                               a.notas,
                               (SELECT json_agg(row_to_json(y) ORDER BY y.id_anexo)
                                  FROM (SELECT ax.id_anexo, ax.nome, ax.tipo_mime, ax.tamanho_bytes,
                                               ax.caminho,
                                               fn_data_mongo(ax.data_hora_upload) AS data_hora_upload,
                                               ax.descricao, ax.id_colaborador
                                          FROM anexo AS ax
                                         WHERE ax.id_ato = a.id_ato) AS y) AS anexos
                          FROM ato_clinico AS a
                          JOIN servico     AS sv ON a.id_servico = sv.id_servico
                          JOIN pessoa      AS p  ON a.id_colaborador = p.id_pessoa
                         WHERE a.id_episodio = e.id_episodio) AS x) AS atos,

               -- Pedidos laboratoriais -> análises pedidas (linha_pedido) -> resultado
               (SELECT json_agg(row_to_json(x) ORDER BY x.id_pedido)
                  FROM (SELECT pl.id_pedido,
                               fn_data_mongo(pl.data_hora_pedido) AS data_hora_pedido,
                               (SELECT row_to_json(v)
                                  FROM (SELECT pv.id_pessoa AS id_veterinario, pv.nome) AS v) AS veterinario,
                               pl.notas,
                               -- Análise: referência + cópia de nome, unidade e
                               -- valores de referência (congelados à data do pedido)
                               (SELECT json_agg(row_to_json(y) ORDER BY y.id_analise)
                                  FROM (SELECT al.id_analise, al.nome, al.unidade_medida,
                                               al.valor_ref_min, al.valor_ref_max,
                                               -- Resultado (0..1 por linha); NULL se pendente
                                               (SELECT row_to_json(z)
                                                  FROM (SELECT r.id_resultado,
                                                               (SELECT row_to_json(c)
                                                                  FROM (SELECT pt.id_pessoa AS id_colaborador,
                                                                               pt.nome) AS c) AS tecnico,
                                                               r.valor_obtido,
                                                               fn_data_mongo(r.data_hora_realizacao) AS data_hora_realizacao,
                                                               fn_data_mongo(r.data_hora_registo)    AS data_hora_registo,
                                                               r.notas
                                                          FROM resultado AS r
                                                          JOIN pessoa    AS pt ON r.id_colaborador = pt.id_pessoa
                                                         WHERE r.id_pedido  = lp.id_pedido
                                                           AND r.id_analise = lp.id_analise) AS z) AS resultado
                                          FROM linha_pedido AS lp
                                          JOIN analise      AS al ON lp.id_analise = al.id_analise
                                         WHERE lp.id_pedido = pl.id_pedido) AS y) AS analises
                          FROM pedido_laboratorial AS pl
                          JOIN pessoa              AS pv ON pl.id_veterinario = pv.id_pessoa
                         WHERE pl.id_episodio = e.id_episodio) AS x) AS pedidos

          FROM episodio AS e
          JOIN animal   AS an ON e.id_animal = an.id_animal) AS ep
 ORDER BY ep._id;