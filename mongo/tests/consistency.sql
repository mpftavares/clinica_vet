-- =============================================================================
-- IBD 2026/27 — Entrega 3 — Clínica Veterinária
-- consistency.sql : contagens de verificação da migração, do lado do
--                   PostgreSQL. As mesmas contagens são feitas no MongoDB por
--                   consistency.js; os dois resultados têm de ser iguais.
--
-- Este ficheiro foi integralmente gerado pelo assistente de inteligência
-- artificial Claude, da Anthropic.
--
-- Execução (uma linha "teste|valor" por teste, pela mesma ordem do .js):
--     psql -q -At -d clinica_vet -f consistency.sql
-- Corre no passo 4 de mongo/migrate/migrate.sh, que o compara com o
-- resultado de consistency.js: as linhas têm de ser iguais.
--
-- O que se verifica:
--   - Contagens por entidade: cada tabela do registo clínico passa a ser um
--     documento, um subdocumento ou um array embedded; o número de linhas
--     de cada tabela tem de ser igual ao número de elementos no MongoDB.
--   - Contagens de casos-limite: valores NULL que passam a campos ausentes
--     (episódios abertos, internamentos sem alta, atos sem marcação, análises
--     sem resultado).
--   - Valores: somas e contagens que dependem dos dados copiados (tamanho dos
--     anexos, valores dos resultados, resultados fora dos valores de
--     referência, episódios por ano), para confirmar que os números e as
--     datas foram migrados com o valor certo e não apenas o número certo de
--     elementos.
-- =============================================================================

SELECT teste, valor
  FROM (
        -- Contagens por entidade
        SELECT 1 AS ordem, 'episodios' AS teste, COUNT(*)::TEXT AS valor
          FROM episodio
        UNION ALL
        SELECT 2, 'internamentos', COUNT(*)::TEXT
          FROM internamento
        UNION ALL
        SELECT 3, 'observacoes', COUNT(*)::TEXT
          FROM observacao
        UNION ALL
        SELECT 4, 'atos', COUNT(*)::TEXT
          FROM ato_clinico
        UNION ALL
        SELECT 5, 'anexos', COUNT(*)::TEXT
          FROM anexo
        UNION ALL
        SELECT 6, 'pedidos', COUNT(*)::TEXT
          FROM pedido_laboratorial
        UNION ALL
        SELECT 7, 'analises_pedidas', COUNT(*)::TEXT
          FROM linha_pedido
        UNION ALL
        SELECT 8, 'resultados', COUNT(*)::TEXT
          FROM resultado
        UNION ALL
        SELECT 9, 'animais_com_episodios', COUNT(DISTINCT id_animal)::TEXT
          FROM episodio

        -- Casos-limite (NULL no PostgreSQL = campo ausente no MongoDB)
        UNION ALL
        SELECT 10, 'episodios_abertos', COUNT(*)::TEXT
          FROM episodio
         WHERE data_hora_fim IS NULL
        UNION ALL
        SELECT 11, 'internamentos_sem_alta', COUNT(*)::TEXT
          FROM internamento
         WHERE data_hora_fim IS NULL
        UNION ALL
        SELECT 12, 'atos_com_marcacao', COUNT(*)::TEXT
          FROM ato_clinico
         WHERE id_marcacao IS NOT NULL
        UNION ALL
        SELECT 13, 'analises_sem_resultado', COUNT(*)::TEXT
          FROM linha_pedido AS lp
          LEFT JOIN resultado AS r
            ON r.id_pedido = lp.id_pedido AND r.id_analise = lp.id_analise
         WHERE r.id_resultado IS NULL

        -- Valores
        UNION ALL
        SELECT 14, 'soma_tamanho_anexos', SUM(tamanho_bytes)::TEXT
          FROM anexo
        UNION ALL
        SELECT 15, 'soma_valor_obtido', TO_CHAR(SUM(valor_obtido), 'FM999999990.000')
          FROM resultado
        UNION ALL
        SELECT 16, 'resultados_fora_referencia', COUNT(*)::TEXT
          FROM resultado AS r
          JOIN analise AS a ON a.id_analise = r.id_analise
         WHERE r.valor_obtido < a.valor_ref_min
            OR r.valor_obtido > a.valor_ref_max
        UNION ALL
        SELECT 17, 'episodios_2025', COUNT(*)::TEXT
          FROM episodio
         WHERE EXTRACT(YEAR FROM data_hora_inicio) = 2025
        UNION ALL
        SELECT 18, 'episodios_2026', COUNT(*)::TEXT
          FROM episodio
         WHERE EXTRACT(YEAR FROM data_hora_inicio) = 2026
       ) AS t
 ORDER BY ordem;