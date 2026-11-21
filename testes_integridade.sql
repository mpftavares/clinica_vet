-- =============================================================================
-- IBD 2026/27 — Entrega 2 — Clínica Veterinária
-- testes_integridade.sql : demonstração das restrições de integridade e dos
--                          triggers (casos que as regras de negócio rejeitam)
--
-- Execução (depois de schema.sql e data.sql), SEM parar no primeiro erro:
--     psql -d <base_de_dados> -f testes_integridade.sql
--
-- Cada teste corre numa transação própria: a operação inválida dá erro e o
-- ROLLBACK seguinte termina a transação, sem alterar os dados. A regra
-- testada está indicada no comentário de cada teste.
-- =============================================================================

-- T01. RN14 — marcação sobreposta para o mesmo veterinário.
BEGIN;
INSERT INTO marcacao (id_marcacao, id_animal, id_veterinario, id_registo, data_hora_inicio, data_hora_fim)
SELECT 9999, id_animal, id_veterinario, id_registo,
       data_hora_inicio + INTERVAL '10 minutes', data_hora_fim + INTERVAL '10 minutes'
  FROM marcacao WHERE id_marcacao = 1;
ROLLBACK;

-- T02. RN13 — marcação com fim anterior ao início.
BEGIN;
INSERT INTO marcacao VALUES (9999, 1, 1, 15, TIMESTAMP '2027-01-04 10:00', TIMESTAMP '2027-01-04 09:30');
ROLLBACK;

-- T03. RN08 — marcação atribuída a um veterinário desativado.
BEGIN;
INSERT INTO marcacao
SELECT 9999, 1, c.id_pessoa, 15, TIMESTAMP '2027-01-04 08:00', TIMESTAMP '2027-01-04 08:30'
  FROM colaborador AS c JOIN veterinario AS v ON v.id_pessoa = c.id_pessoa
 WHERE NOT c.ativo;
ROLLBACK;

-- T04. RN15 — eliminar uma marcação que já originou uma consulta.
BEGIN;
DELETE FROM marcacao WHERE id_marcacao = (SELECT MIN(id_marcacao) FROM ato_clinico);
ROLLBACK;

-- T05. RN24 / RN25 — consulta registada por um enfermeiro.
BEGIN;
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, data_hora)
SELECT 9999, e.id_episodio, 1, 7, e.data_hora_inicio + INTERVAL '1 hour'
  FROM episodio AS e
 WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
ROLLBACK;

-- T06. RN17 — consulta associada a uma marcação de outro animal.
BEGIN;
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora)
SELECT 9999, e.id_episodio, 1, 1,
       (SELECT MIN(m.id_marcacao) FROM marcacao AS m
         WHERE m.id_animal <> e.id_animal
           AND NOT EXISTS (SELECT * FROM ato_clinico AS a WHERE a.id_marcacao = m.id_marcacao)),
       e.data_hora_inicio + INTERVAL '1 hour'
  FROM episodio AS e
 WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
ROLLBACK;

-- T07. RN22 — observação num episódio encerrado.
BEGIN;
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, temperatura)
SELECT 9999, e.id_episodio, 7, e.data_hora_fim, 38.5
  FROM episodio AS e WHERE e.id_episodio = 1;
ROLLBACK;

-- T08. RN27 — observação com data anterior ao início do episódio.
BEGIN;
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, temperatura)
SELECT 9999, e.id_episodio, 7, e.data_hora_inicio - INTERVAL '1 day', 38.5
  FROM episodio AS e
 WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
ROLLBACK;

-- T09. RN26 — observação registada por um técnico de laboratório.
BEGIN;
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, temperatura)
SELECT 9999, e.id_episodio, 12, e.data_hora_inicio + INTERVAL '1 hour', 38.5
  FROM episodio AS e
 WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
ROLLBACK;

-- T10. Observação sem nenhum valor registado.
BEGIN;
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora)
SELECT 9999, e.id_episodio, 7, e.data_hora_inicio + INTERVAL '1 hour'
  FROM episodio AS e
 WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
ROLLBACK;

-- T11. RN29 — anexo carregado antes da realização do ato.
BEGIN;
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload)
SELECT 9999, a.id_ato, 7, 'teste.pdf', 'application/pdf', 1000, '/anexos/teste.pdf', a.data_hora - INTERVAL '1 hour'
  FROM ato_clinico AS a
 WHERE a.id_ato = (SELECT MAX(id_ato) FROM ato_clinico);
ROLLBACK;

-- T12. RN34 — resultado registado por quem não é técnico de laboratório
-- (numa análise pendente de um episódio aberto).
BEGIN;
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido,
                       data_hora_realizacao, data_hora_registo)
SELECT 9999, p.id_pedido, MIN(p.id_analise), 7, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
  FROM vw_analises_pendentes AS p
 WHERE p.id_pedido = (SELECT MIN(v.id_pedido)
                        FROM vw_analises_pendentes AS v
                        JOIN episodio AS e ON v.id_episodio = e.id_episodio
                       WHERE e.data_hora_fim IS NULL)
 GROUP BY p.id_pedido;
ROLLBACK;

-- T13. RN33 — resultado de uma análise que não consta do pedido (pedido de um
-- episódio aberto).
BEGIN;
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido,
                       data_hora_realizacao, data_hora_registo)
SELECT 9999, pl.id_pedido, al.id_analise, 12, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
  FROM pedido_laboratorial AS pl, analise AS al
 WHERE pl.id_pedido = (SELECT MIN(p2.id_pedido)
                         FROM pedido_laboratorial AS p2
                         JOIN episodio AS e ON p2.id_episodio = e.id_episodio
                        WHERE e.data_hora_fim IS NULL)
   AND al.id_analise = (SELECT MIN(a2.id_analise) FROM analise AS a2
                         WHERE NOT EXISTS (SELECT * FROM linha_pedido AS lp
                                            WHERE lp.id_pedido = pl.id_pedido
                                              AND lp.id_analise = a2.id_analise));
ROLLBACK;

-- T14. RN21 — segundo episódio aberto para o mesmo animal.
BEGIN;
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio)
SELECT 9999, e.id_animal, CURRENT_TIMESTAMP
  FROM episodio AS e
 WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
ROLLBACK;

-- T15. RN19 — encerrar um episódio sem consulta.
BEGIN;
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio)
SELECT 9999, MIN(an.id_animal), CURRENT_TIMESTAMP
  FROM animal AS an
 WHERE NOT EXISTS (SELECT * FROM episodio AS e WHERE e.id_animal = an.id_animal);
UPDATE episodio SET data_hora_fim = CURRENT_TIMESTAMP WHERE id_episodio = 9999;
ROLLBACK;

-- T16. RN20 — encerrar um episódio com internamento sem alta.
BEGIN;
UPDATE episodio SET data_hora_fim = CURRENT_TIMESTAMP
 WHERE id_episodio = (SELECT MIN(id_episodio) FROM internamento WHERE data_hora_fim IS NULL);
ROLLBACK;

-- T17. RN04 — novo animal para um cliente desativado.
BEGIN;
INSERT INTO animal (id_animal, id_cliente, nome, especie, sexo)
SELECT 9999, MIN(id_pessoa), 'Teste', 'Gato', 'F' FROM cliente WHERE NOT ativo;
ROLLBACK;

-- T18. Espécie fora da lista de espécies aceites.
BEGIN;
INSERT INTO animal (id_animal, id_cliente, nome, especie, sexo)
SELECT 9999, MIN(id_pessoa), 'Teste', 'Dinossauro', 'F' FROM cliente WHERE ativo;
ROLLBACK;

-- T19. RN07 — registar como veterinário um colaborador com outra função.
BEGIN;
INSERT INTO veterinario VALUES (7, 'OMV9999');
ROLLBACK;

-- T20. RN02 — pessoa com um NIF já registado.
BEGIN;
INSERT INTO pessoa (id_pessoa, nome, nif, telefone)
SELECT 9999, 'Teste', nif, '912000000' FROM pessoa WHERE id_pessoa = 1;
ROLLBACK;

-- T21. RN01 / RN05 — eliminar um cliente com animais.
BEGIN;
DELETE FROM cliente WHERE id_pessoa = (SELECT MIN(id_cliente) FROM animal);
ROLLBACK;
