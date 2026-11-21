-- Q01. Animais com mais de três episódios clínicos nos últimos 12 meses e
-- respetivos clientes.
SELECT an.id_animal, an.nome AS animal, an.especie,
       pc.nome AS cliente, pc.telefone,
       COUNT(*) AS n_episodios
  FROM episodio AS e
  JOIN animal   AS an ON e.id_animal = an.id_animal
  JOIN pessoa   AS pc ON an.id_cliente = pc.id_pessoa
 WHERE e.data_hora_inicio >= CURRENT_TIMESTAMP - INTERVAL '12 months'
 GROUP BY an.id_animal, an.nome, an.especie, pc.nome, pc.telefone
HAVING COUNT(*) > 3
 ORDER BY n_episodios DESC, an.nome;

-- Q02. Veterinários que realizaram mais consultas em cada mês (últimos 12
-- meses), com o número de consultas com marcação e de urgências sem marcação.
-- O WITH calcula o total por mês e veterinário.
WITH por_mes AS (
    SELECT EXTRACT(YEAR FROM a.data_hora)  AS ano,
           EXTRACT(MONTH FROM a.data_hora) AS mes,
           p.nome AS veterinario,
           COUNT(*) AS total,
           SUM(CASE WHEN a.id_marcacao IS NOT NULL THEN 1 ELSE 0 END) AS com_marcacao,
           SUM(CASE WHEN a.id_marcacao IS NULL THEN 1 ELSE 0 END)     AS urgencias
      FROM ato_clinico AS a
      JOIN servico     AS s ON a.id_servico = s.id_servico
      JOIN pessoa      AS p ON a.id_colaborador = p.id_pessoa
     WHERE s.designacao = 'Consulta'
       AND a.data_hora >= CURRENT_TIMESTAMP - INTERVAL '12 months'
     GROUP BY EXTRACT(YEAR FROM a.data_hora), EXTRACT(MONTH FROM a.data_hora),
              a.id_colaborador, p.nome
)
SELECT ano, mes, veterinario, total, com_marcacao, urgencias
  FROM por_mes AS pm
 WHERE pm.total = (SELECT MAX(x.total)
                     FROM por_mes AS x
                    WHERE x.ano = pm.ano AND x.mes = pm.mes)
 ORDER BY ano, mes, veterinario;

-- Q03. Colaboradores que registaram mais marcações nos últimos seis meses e
-- percentagem dessas marcações que não originou um ato clínico.
-- LEFT JOIN para manter as marcações sem ato.
SELECT pr.nome AS colaborador, f.designacao AS funcao,
       COUNT(*) AS marcacoes,
       SUM(CASE WHEN a.id_ato IS NULL THEN 1 ELSE 0 END) AS sem_ato,
       ROUND(100.0 * SUM(CASE WHEN a.id_ato IS NULL THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_sem_ato
  FROM marcacao         AS m
  JOIN colaborador      AS c  ON m.id_registo = c.id_pessoa
  JOIN funcao           AS f  ON c.id_funcao = f.id_funcao
  JOIN pessoa           AS pr ON c.id_pessoa = pr.id_pessoa
  LEFT JOIN ato_clinico AS a  ON a.id_marcacao = m.id_marcacao
 WHERE m.data_hora_inicio >= CURRENT_TIMESTAMP - INTERVAL '6 months'
   AND m.data_hora_inicio <  CURRENT_TIMESTAMP
 GROUP BY pr.id_pessoa, pr.nome, f.designacao
 ORDER BY marcacoes DESC, pct_sem_ato DESC;

-- Q04. Serviços mais realizados por enfermeiros durante os internamentos
-- (ato entre o início do internamento e a alta, ou ainda sem alta).
SELECT s.designacao AS servico, COUNT(*) AS n_atos
  FROM ato_clinico  AS a
  JOIN servico      AS s ON a.id_servico = s.id_servico
  JOIN colaborador  AS c ON a.id_colaborador = c.id_pessoa
  JOIN funcao       AS f ON c.id_funcao = f.id_funcao
  JOIN internamento AS i ON i.id_episodio = a.id_episodio
 WHERE f.designacao = 'Enfermeiro'
   AND a.data_hora >= i.data_hora_inicio
   AND (i.data_hora_fim IS NULL OR a.data_hora <= i.data_hora_fim)
 GROUP BY s.designacao
 ORDER BY n_atos DESC;

-- Q05. Animais que, durante o internamento, tiveram observações com
-- temperatura acima de 40 ºC, e análises pedidas nesses episódios.
-- LEFT JOIN para listar também os episódios sem pedidos (análise a NULL).
SELECT DISTINCT an.id_animal, an.nome AS animal, an.especie, e.id_episodio,
       (SELECT MAX(o.temperatura)
          FROM observacao AS o
         WHERE o.id_episodio = e.id_episodio) AS temp_maxima,
       al.nome AS analise_pedida
  FROM internamento             AS i
  JOIN episodio                 AS e  ON i.id_episodio = e.id_episodio
  JOIN animal                   AS an ON e.id_animal = an.id_animal
  LEFT JOIN pedido_laboratorial AS pl ON pl.id_episodio = e.id_episodio
  LEFT JOIN linha_pedido        AS lp ON lp.id_pedido = pl.id_pedido
  LEFT JOIN analise             AS al ON lp.id_analise = al.id_analise
 WHERE EXISTS (SELECT *
                 FROM observacao AS o
                WHERE o.id_episodio = e.id_episodio
                  AND o.temperatura > 40
                  AND o.data_hora >= i.data_hora_inicio
                  AND (i.data_hora_fim IS NULL OR o.data_hora <= i.data_hora_fim))
 ORDER BY an.nome, e.id_episodio, al.nome;

-- Q06. Serviços com mais anexos nos últimos seis meses e espaço ocupado, por
-- tipo de anexo. A subquery no SELECT dá o total do serviço, usado para
-- ordenar os serviços pelo número total de anexos.
SELECT s.designacao AS servico, x.tipo_mime,
       COUNT(*) AS n_anexos,
       ROUND(SUM(x.tamanho_bytes) / 1048576.0, 2) AS espaco_mb,
       (SELECT COUNT(*)
          FROM anexo       AS x2
          JOIN ato_clinico AS a2 ON x2.id_ato = a2.id_ato
         WHERE a2.id_servico = s.id_servico
           AND x2.data_hora_upload >= CURRENT_TIMESTAMP - INTERVAL '6 months') AS total_servico
  FROM anexo       AS x
  JOIN ato_clinico AS a ON x.id_ato = a.id_ato
  JOIN servico     AS s ON a.id_servico = s.id_servico
 WHERE x.data_hora_upload >= CURRENT_TIMESTAMP - INTERVAL '6 months'
 GROUP BY s.id_servico, s.designacao, x.tipo_mime
 ORDER BY total_servico DESC, s.designacao, n_anexos DESC;

-- Q07. Percentagem de resultados fora dos valores de referência, por análise,
-- nos últimos seis meses. Quando um limite de referência é NULL, a comparação
-- com esse limite dá "unknown" e só conta o outro limite.
SELECT al.nome AS analise, al.unidade_medida,
       COUNT(*) AS n_resultados,
       SUM(CASE WHEN r.valor_obtido < al.valor_ref_min OR r.valor_obtido > al.valor_ref_max
                THEN 1 ELSE 0 END) AS fora_referencia,
       ROUND(100.0 * SUM(CASE WHEN r.valor_obtido < al.valor_ref_min OR r.valor_obtido > al.valor_ref_max
                              THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_fora
  FROM resultado AS r
  JOIN analise   AS al ON r.id_analise = al.id_analise
 WHERE r.data_hora_registo >= CURRENT_TIMESTAMP - INTERVAL '6 months'
 GROUP BY al.id_analise, al.nome, al.unidade_medida
 ORDER BY pct_fora DESC, al.nome;

-- Q08. Técnicos de laboratório com mais resultados registados nos últimos seis
-- meses e tempo médio entre o pedido e o registo (média de intervalos).
SELECT p.nome AS tecnico,
       COUNT(*) AS n_resultados,
       AVG(r.data_hora_registo - pl.data_hora_pedido) AS tempo_medio_resposta
  FROM resultado           AS r
  JOIN pedido_laboratorial AS pl ON r.id_pedido = pl.id_pedido
  JOIN pessoa              AS p  ON r.id_colaborador = p.id_pessoa
 WHERE r.data_hora_registo >= CURRENT_TIMESTAMP - INTERVAL '6 months'
 GROUP BY p.id_pessoa, p.nome
 ORDER BY n_resultados DESC;

-- Q09. Episódios abertos há mais de 24 horas, com animal e cliente. Usa a
-- função fn_episodios_abertos com o limite de horas como parâmetro.
SELECT *
  FROM fn_episodios_abertos(24);

-- Q10. Duração média dos internamentos terminados nos últimos 12 meses, por
-- espécie, e número médio de atos realizados durante cada internamento.
SELECT especie,
       COUNT(*)            AS n_internamentos,
       AVG(duracao)        AS duracao_media,
       ROUND(AVG(n_atos), 1) AS media_atos
  FROM vw_internamentos
 WHERE data_hora_fim >= CURRENT_TIMESTAMP - INTERVAL '12 months'
 GROUP BY especie
 ORDER BY duracao_media DESC;

-- Q11. Histórico clínico de um animal, por ordem cronológica (RF04): atos
-- clínicos, observações e resultados laboratoriais de todos os episódios.
SELECT e.id_episodio, a.data_hora, 'Ato clínico' AS tipo,
       s.designacao AS descricao, p.nome AS responsavel
  FROM episodio    AS e
  JOIN ato_clinico AS a ON a.id_episodio = e.id_episodio
  JOIN servico     AS s ON a.id_servico = s.id_servico
  JOIN pessoa      AS p ON a.id_colaborador = p.id_pessoa
 WHERE e.id_animal = 1
UNION ALL
SELECT e.id_episodio, o.data_hora, 'Observação',
       CASE WHEN o.temperatura IS NULL THEN o.notas
            ELSE 'Temperatura ' || CAST(o.temperatura AS VARCHAR) || ' ºC' END,
       p.nome
  FROM episodio   AS e
  JOIN observacao AS o ON o.id_episodio = e.id_episodio
  JOIN pessoa     AS p ON o.id_colaborador = p.id_pessoa
 WHERE e.id_animal = 1
UNION ALL
SELECT e.id_episodio, r.data_hora_realizacao, 'Resultado laboratorial',
       al.nome || ': ' || CAST(r.valor_obtido AS VARCHAR) || ' ' || al.unidade_medida,
       p.nome
  FROM episodio            AS e
  JOIN pedido_laboratorial AS pl ON pl.id_episodio = e.id_episodio
  JOIN resultado           AS r  ON r.id_pedido = pl.id_pedido
  JOIN analise             AS al ON r.id_analise = al.id_analise
  JOIN pessoa              AS p  ON r.id_colaborador = p.id_pessoa
 WHERE e.id_animal = 1
 ORDER BY data_hora, tipo;

-- Q12. Agenda de um veterinário para os próximos 60 dias (RF10).
SELECT data_hora_inicio, data_hora_fim, animal, especie, cliente, telefone, estado
  FROM vw_agenda
 WHERE id_veterinario = 4
   AND data_hora_inicio < CURRENT_DATE + 60
 ORDER BY data_hora_inicio;

-- Q13. Animais atualmente internados (RF13), com as horas de internamento.
SELECT v.animal, v.especie, v.cliente, v.telefone, v.inicio_internamento,
       CURRENT_TIMESTAMP - v.inicio_internamento AS tempo_internado
  FROM vw_episodios_abertos AS v
 WHERE v.internado
 ORDER BY v.inicio_internamento;

-- Q14. Pedidos laboratoriais com análises ainda sem resultado (RF23), do mais
-- antigo para o mais recente.
SELECT id_pedido, data_hora_pedido, animal, especie, veterinario,
       COUNT(*) AS analises_pendentes, MAX(tempo_espera) AS tempo_espera
  FROM vw_analises_pendentes
 GROUP BY id_pedido, data_hora_pedido, animal, especie, veterinario
 ORDER BY data_hora_pedido;

-- Q15. Pesquisa de clientes e animais por nome, NIF, telefone ou microchip
-- (RF03), sobre a view vw_clientes_animais.
SELECT cliente, nif, telefone, animal, especie, microchip
  FROM vw_clientes_animais
 WHERE cliente LIKE '%Costa%'
    OR nif = '123456789'
    OR telefone = '912345678'
    OR microchip = '620268393600478'
 ORDER BY cliente, animal;

-- Q16. Atividade por espécie dos animais com episódios: animais e episódios.
SELECT an.especie,
       COUNT(DISTINCT an.id_animal)  AS animais,
       COUNT(DISTINCT e.id_episodio) AS episodios
  FROM animal   AS an
  JOIN episodio AS e ON e.id_animal = an.id_animal
 GROUP BY an.especie
 ORDER BY episodios DESC;

-- Q17. Clientes ativos, com animais, sem nenhum episódio nos últimos 12 meses
-- com a data do último episódio.
SELECT pc.nome AS cliente, pc.telefone, pc.email,
       (SELECT MAX(e.data_hora_inicio)
          FROM episodio AS e
          JOIN animal   AS an ON e.id_animal = an.id_animal
         WHERE an.id_cliente = c.id_pessoa) AS ultimo_episodio
  FROM cliente AS c
  JOIN pessoa  AS pc ON c.id_pessoa = pc.id_pessoa
 WHERE c.ativo
   AND EXISTS (SELECT * FROM animal AS an WHERE an.id_cliente = c.id_pessoa)
   AND NOT EXISTS (SELECT *
                     FROM episodio AS e
                     JOIN animal   AS an ON e.id_animal = an.id_animal
                    WHERE an.id_cliente = c.id_pessoa
                      AND e.data_hora_inicio >= CURRENT_TIMESTAMP - INTERVAL '12 months')
 ORDER BY ultimo_episodio;

-- Q18. CREATE — Registar uma marcação para um animal.
-- Os ids não são automáticos: o novo id é o maior existente mais um.
INSERT INTO marcacao (id_marcacao, id_animal, id_veterinario, id_registo,
                      data_hora_inicio, data_hora_fim)
SELECT (SELECT MAX(id_marcacao) + 1 FROM marcacao),
       an.id_animal, 1, 15,
       CURRENT_DATE + 30 + INTERVAL '8 hours',
       CURRENT_DATE + 30 + INTERVAL '8 hours 30 minutes'
  FROM animal AS an
 WHERE an.microchip = '620268393600478';

SELECT id_marcacao, veterinario, data_hora_inicio, data_hora_fim, animal, cliente, estado
  FROM vw_agenda
 WHERE id_marcacao = (SELECT MAX(id_marcacao) FROM marcacao);

-- Q19. UPDATE — Adiar a marcação para o dia seguinte, à mesma hora, desde que
-- o veterinário não tenha outra marcação nesse horário (NOT EXISTS).
UPDATE marcacao AS m
   SET data_hora_inicio = m.data_hora_inicio + INTERVAL '1 day',
       data_hora_fim    = m.data_hora_fim    + INTERVAL '1 day'
 WHERE m.id_marcacao = (SELECT MAX(id_marcacao) FROM marcacao)
   AND NOT EXISTS (SELECT *
                     FROM marcacao AS o
                    WHERE o.id_veterinario = m.id_veterinario
                      AND o.data_hora_inicio < m.data_hora_fim    + INTERVAL '1 day'
                      AND o.data_hora_fim    > m.data_hora_inicio + INTERVAL '1 day');

SELECT id_marcacao, veterinario, data_hora_inicio, data_hora_fim, animal, cliente, estado
  FROM vw_agenda
 WHERE id_marcacao = (SELECT MAX(id_marcacao) FROM marcacao);

-- Q20. DELETE — Eliminar a marcação, desde que ainda não tenha originado uma consulta.
DELETE FROM marcacao AS m
 WHERE m.id_marcacao = (SELECT MAX(id_marcacao) FROM marcacao)
   AND NOT EXISTS (SELECT * FROM ato_clinico AS a WHERE a.id_marcacao = m.id_marcacao);

SELECT COUNT(*) AS total_marcacoes FROM marcacao;
