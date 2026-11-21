-- Função: episódios clínicos abertos há mais de p_horas horas, com os animais
-- e clientes associados (usada na Q09).
CREATE OR REPLACE FUNCTION fn_episodios_abertos(p_horas INT)
RETURNS TABLE (
    episodio     INT,
    inicio       TIMESTAMP,
    tempo_aberto INTERVAL,
    nome_animal  VARCHAR(50),
    especie_animal VARCHAR(30),
    nome_cliente VARCHAR(100),
    telefone_cliente VARCHAR(20),
    internado    BOOLEAN)
AS $$
BEGIN
    RETURN QUERY
    SELECT e.id_episodio, e.data_hora_inicio,
           CURRENT_TIMESTAMP - e.data_hora_inicio,
           an.nome, an.especie, pc.nome, pc.telefone,
           EXISTS (SELECT * FROM internamento AS i
                    WHERE i.id_episodio = e.id_episodio AND i.data_hora_fim IS NULL)
      FROM episodio AS e
      JOIN animal   AS an ON e.id_animal = an.id_animal
      JOIN pessoa   AS pc ON an.id_cliente = pc.id_pessoa
     WHERE e.data_hora_fim IS NULL
       AND e.data_hora_inicio < CURRENT_TIMESTAMP - p_horas * INTERVAL '1 hour'
     ORDER BY e.data_hora_inicio;
END;
$$ LANGUAGE plpgsql;

-- Procedimento: dar alta a um animal internado.
-- Regista a data e hora de fim (alta) do internamento ativo do episódio e
-- encerra o episódio com a mesma data e hora.
CREATE OR REPLACE PROCEDURE sp_dar_alta(IN p_id_episodio INT, IN p_data_hora TIMESTAMP)
AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM internamento
                    WHERE id_episodio = p_id_episodio AND data_hora_fim IS NULL) THEN
        RAISE EXCEPTION 'O episódio % não tem um internamento ativo', p_id_episodio;
    END IF;
    UPDATE internamento
       SET data_hora_fim = p_data_hora
     WHERE id_episodio = p_id_episodio;
    UPDATE episodio
       SET data_hora_fim = p_data_hora
     WHERE id_episodio = p_id_episodio;
END;
$$ LANGUAGE plpgsql;
