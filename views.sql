-- V1. Clientes e respetivos animais (RF01, RF02, RF03), com os contactos do
-- cliente. LEFT JOIN para incluir os clientes que ainda não têm animais.
CREATE OR REPLACE VIEW vw_clientes_animais AS
    SELECT c.id_pessoa AS id_cliente, pc.nome AS cliente, pc.nif, pc.telefone,
           pc.email, pc.morada, c.ativo AS cliente_ativo,
           an.id_animal, an.nome AS animal, an.especie, an.raca, an.sexo,
           an.data_nascimento, an.microchip
      FROM cliente     AS c
      JOIN pessoa      AS pc ON c.id_pessoa = pc.id_pessoa
      LEFT JOIN animal AS an ON an.id_cliente = c.id_pessoa;

-- V2. Agenda de marcações a partir do dia atual (RF09, RF10).
CREATE OR REPLACE VIEW vw_agenda AS
    SELECT m.id_marcacao, m.id_veterinario, pv.nome AS veterinario,
           m.data_hora_inicio, m.data_hora_fim,
           an.id_animal, an.nome AS animal, an.especie,
           pc.nome AS cliente, pc.telefone,
           pr.nome AS registada_por,
           CASE
               WHEN EXISTS (SELECT * FROM ato_clinico AS a WHERE a.id_marcacao = m.id_marcacao)
                   THEN 'Realizada'
               ELSE 'Agendada'
           END AS estado
      FROM marcacao AS m
      JOIN animal   AS an ON m.id_animal = an.id_animal
      JOIN pessoa   AS pc ON an.id_cliente = pc.id_pessoa
      JOIN pessoa   AS pv ON m.id_veterinario = pv.id_pessoa
      JOIN pessoa   AS pr ON m.id_registo = pr.id_pessoa
     WHERE m.data_hora_inicio >= CURRENT_DATE;

-- V3. Episódios abertos (RF13), com o tempo decorrido e a indicação de
-- internamento ativo. LEFT JOIN para manter os episódios sem internamento.
CREATE OR REPLACE VIEW vw_episodios_abertos AS
    SELECT e.id_episodio, e.data_hora_inicio,
           CURRENT_TIMESTAMP - e.data_hora_inicio AS tempo_aberto,
           an.id_animal, an.nome AS animal, an.especie,
           pc.nome AS cliente, pc.telefone,
           i.data_hora_inicio AS inicio_internamento,
           CASE WHEN i.id_internamento IS NOT NULL AND i.data_hora_fim IS NULL
                THEN TRUE ELSE FALSE END AS internado
      FROM episodio          AS e
      JOIN animal            AS an ON e.id_animal = an.id_animal
      JOIN pessoa            AS pc ON an.id_cliente = pc.id_pessoa
      LEFT JOIN internamento AS i  ON i.id_episodio = e.id_episodio
     WHERE e.data_hora_fim IS NULL;

-- V4. Análises pedidas ainda sem resultado (RF23): linhas de pedido para as
-- quais não existe resultado (NOT EXISTS).
CREATE OR REPLACE VIEW vw_analises_pendentes AS
    SELECT pl.id_pedido, pl.data_hora_pedido,
           CURRENT_TIMESTAMP - pl.data_hora_pedido AS tempo_espera,
           al.id_analise, al.nome AS analise,
           an.nome AS animal, an.especie,
           pv.nome AS veterinario, pl.id_episodio
      FROM linha_pedido        AS lp
      JOIN pedido_laboratorial AS pl ON lp.id_pedido = pl.id_pedido
      JOIN analise             AS al ON lp.id_analise = al.id_analise
      JOIN episodio            AS e  ON pl.id_episodio = e.id_episodio
      JOIN animal              AS an ON e.id_animal = an.id_animal
      JOIN pessoa              AS pv ON pl.id_veterinario = pv.id_pessoa
     WHERE NOT EXISTS (SELECT *
                         FROM resultado AS r
                        WHERE r.id_pedido = lp.id_pedido
                          AND r.id_analise = lp.id_analise);

-- V5. Internamentos com espécie, duração e número de atos realizados durante
-- o internamento (subquery correlacionada). A duração é NULL enquanto o animal
-- não tem alta.
CREATE OR REPLACE VIEW vw_internamentos AS
    SELECT i.id_internamento, i.id_episodio, i.data_hora_inicio, i.data_hora_fim,
           i.data_hora_fim - i.data_hora_inicio AS duracao,
           an.id_animal, an.nome AS animal, an.especie,
           (SELECT COUNT(*)
              FROM ato_clinico AS a
             WHERE a.id_episodio = i.id_episodio
               AND a.data_hora >= i.data_hora_inicio
               AND (i.data_hora_fim IS NULL OR a.data_hora <= i.data_hora_fim)) AS n_atos
      FROM internamento AS i
      JOIN episodio     AS e  ON i.id_episodio = e.id_episodio
      JOIN animal       AS an ON e.id_animal = an.id_animal;
