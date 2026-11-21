-- ALTERAÇÕES AO MODELO ER FACE À ENTREGA 1
-- a) Nova entidade de nível superior Pessoa (generalização), com especialização
--    total e sobreposta em Cliente e Colaborador: evita duplicar os dados
--    pessoais quando um colaborador é também cliente da clínica.
-- b) Entidade Ficheiro renomeada para Anexo.
-- c) Relacionamento "autoriza" (Função — Serviço) renomeado para
--    "pode_realizar", que deixa claro o sentido da relação.

DROP VIEW IF EXISTS vw_clientes_animais;
DROP VIEW IF EXISTS vw_agenda;
DROP VIEW IF EXISTS vw_episodios_abertos;
DROP VIEW IF EXISTS vw_analises_pendentes;
DROP VIEW IF EXISTS vw_internamentos;

DROP TABLE IF EXISTS resultado;
DROP TABLE IF EXISTS linha_pedido;
DROP TABLE IF EXISTS pedido_laboratorial;
DROP TABLE IF EXISTS analise;
DROP TABLE IF EXISTS observacao;
DROP TABLE IF EXISTS anexo;
DROP TABLE IF EXISTS ato_clinico;
DROP TABLE IF EXISTS internamento;
DROP TABLE IF EXISTS episodio;
DROP TABLE IF EXISTS marcacao;
DROP TABLE IF EXISTS animal;
DROP TABLE IF EXISTS pode_realizar;
DROP TABLE IF EXISTS servico;
DROP TABLE IF EXISTS veterinario;
DROP TABLE IF EXISTS colaborador;
DROP TABLE IF EXISTS funcao;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS pessoa;

CREATE TABLE pessoa (
    id_pessoa   INT PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    nif         VARCHAR(9)   NOT NULL UNIQUE,
    telefone    VARCHAR(20)  NOT NULL,
    email       VARCHAR(100),
    morada      VARCHAR(200),
    CONSTRAINT ck_pessoa_nif      CHECK (nif LIKE '_________'),
    CONSTRAINT ck_pessoa_telefone CHECK (telefone LIKE '_________%'),
    CONSTRAINT ck_pessoa_email    CHECK (email IS NULL OR email LIKE '_%@_%._%')
);

CREATE TABLE cliente (
    id_pessoa   INT     PRIMARY KEY,
    ativo       BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa)
);

CREATE TABLE funcao (
    id_funcao   INT PRIMARY KEY,
    designacao  VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE colaborador (
    id_pessoa   INT     PRIMARY KEY,
    id_funcao   INT     NOT NULL,
    ativo       BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa),
    FOREIGN KEY (id_funcao) REFERENCES funcao (id_funcao)
);

CREATE TABLE veterinario (
    id_pessoa           INT         PRIMARY KEY,
    cedula_profissional VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (id_pessoa) REFERENCES colaborador (id_pessoa)
);

CREATE TABLE servico (
    id_servico  INT PRIMARY KEY,
    designacao  VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE pode_realizar (
    id_funcao   INT NOT NULL,
    id_servico  INT NOT NULL,
    PRIMARY KEY (id_funcao, id_servico),
    FOREIGN KEY (id_funcao)  REFERENCES funcao (id_funcao),
    FOREIGN KEY (id_servico) REFERENCES servico (id_servico) ON DELETE CASCADE
);

CREATE TABLE animal (
    id_animal       INT PRIMARY KEY,
    id_cliente      INT         NOT NULL,
    nome            VARCHAR(50) NOT NULL,
    especie         VARCHAR(30) NOT NULL,
    raca            VARCHAR(50),
    sexo            CHAR(1)     NOT NULL,
    data_nascimento DATE,
    microchip       VARCHAR(15) UNIQUE,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_pessoa),
    CONSTRAINT ck_animal_especie    CHECK (especie IN ('Cão', 'Gato', 'Coelho', 'Furão', 'Ave',
                                                       'Roedor', 'Réptil', 'Outro')),
    CONSTRAINT ck_animal_sexo       CHECK (sexo IN ('M', 'F')),
    CONSTRAINT ck_animal_nascimento CHECK (data_nascimento <= CURRENT_DATE)
);

CREATE TABLE marcacao (
    id_marcacao      INT PRIMARY KEY,
    id_animal        INT       NOT NULL,
    id_veterinario   INT       NOT NULL,
    id_registo       INT       NOT NULL,
    data_hora_inicio TIMESTAMP NOT NULL,
    data_hora_fim    TIMESTAMP NOT NULL,
    FOREIGN KEY (id_animal)      REFERENCES animal (id_animal),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario (id_pessoa),
    FOREIGN KEY (id_registo)     REFERENCES colaborador (id_pessoa),
    CONSTRAINT ck_marcacao_periodo CHECK (data_hora_fim > data_hora_inicio)
);

CREATE TABLE episodio (
    id_episodio      INT PRIMARY KEY,
    id_animal        INT       NOT NULL,
    data_hora_inicio TIMESTAMP NOT NULL,
    data_hora_fim    TIMESTAMP,
    FOREIGN KEY (id_animal) REFERENCES animal (id_animal),
    CONSTRAINT ck_episodio_periodo CHECK (data_hora_fim IS NULL OR data_hora_fim >= data_hora_inicio)
);

CREATE TABLE internamento (
    id_internamento  INT PRIMARY KEY,
    id_episodio      INT       NOT NULL UNIQUE,
    data_hora_inicio TIMESTAMP NOT NULL,
    data_hora_fim    TIMESTAMP,
    FOREIGN KEY (id_episodio) REFERENCES episodio (id_episodio),
    CONSTRAINT ck_internamento_periodo CHECK (data_hora_fim IS NULL OR data_hora_fim >= data_hora_inicio)
);

CREATE TABLE ato_clinico (
    id_ato          INT PRIMARY KEY,
    id_episodio     INT           NOT NULL,
    id_servico      INT           NOT NULL,
    id_colaborador  INT           NOT NULL,
    id_marcacao     INT           UNIQUE,
    data_hora       TIMESTAMP     NOT NULL,
    notas           VARCHAR(1000),
    FOREIGN KEY (id_episodio)    REFERENCES episodio (id_episodio),
    FOREIGN KEY (id_servico)     REFERENCES servico (id_servico),
    FOREIGN KEY (id_colaborador) REFERENCES colaborador (id_pessoa),
    FOREIGN KEY (id_marcacao)    REFERENCES marcacao (id_marcacao)
);

-- O ficheiro não é guardado na base de dados: guarda-se o caminho onde está
-- armazenado e os respetivos metadados (nome, tipo, tamanho), mantendo a base
-- de dados leve.
CREATE TABLE anexo (
    id_anexo          INT PRIMARY KEY,
    id_ato            INT          NOT NULL,
    id_colaborador    INT          NOT NULL,
    nome              VARCHAR(255) NOT NULL,
    tipo_mime         VARCHAR(100) NOT NULL,
    tamanho_bytes     INT          NOT NULL,
    caminho           VARCHAR(500) NOT NULL UNIQUE,
    data_hora_upload  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descricao         VARCHAR(255),
    FOREIGN KEY (id_ato)         REFERENCES ato_clinico (id_ato),
    FOREIGN KEY (id_colaborador) REFERENCES colaborador (id_pessoa),
    CONSTRAINT ck_anexo_tamanho CHECK (tamanho_bytes > 0)
);

CREATE TABLE observacao (
    id_observacao     INT PRIMARY KEY,
    id_episodio       INT           NOT NULL,
    id_colaborador    INT           NOT NULL,
    data_hora         TIMESTAMP     NOT NULL,
    peso              NUMERIC(6,2),
    temperatura       NUMERIC(4,1),
    freq_cardiaca     SMALLINT,
    freq_respiratoria SMALLINT,
    notas             VARCHAR(1000),
    FOREIGN KEY (id_episodio)    REFERENCES episodio (id_episodio),
    FOREIGN KEY (id_colaborador) REFERENCES colaborador (id_pessoa),
    CONSTRAINT ck_obs_peso  CHECK (peso > 0),
    CONSTRAINT ck_obs_temp  CHECK (temperatura BETWEEN 0 AND 99),
    CONSTRAINT ck_obs_fc    CHECK (freq_cardiaca >= 0),
    CONSTRAINT ck_obs_fr    CHECK (freq_respiratoria >= 0),
    CONSTRAINT ck_obs_algum CHECK (peso IS NOT NULL OR temperatura IS NOT NULL
                                   OR freq_cardiaca IS NOT NULL OR freq_respiratoria IS NOT NULL
                                   OR notas IS NOT NULL)
);

CREATE TABLE analise (
    id_analise     INT PRIMARY KEY,
    nome           VARCHAR(100)  NOT NULL UNIQUE,
    unidade_medida VARCHAR(20)   NOT NULL,
    valor_ref_min  NUMERIC(10,3),
    valor_ref_max  NUMERIC(10,3),
    CONSTRAINT ck_analise_ref CHECK (valor_ref_min <= valor_ref_max)
);

CREATE TABLE pedido_laboratorial (
    id_pedido        INT PRIMARY KEY,
    id_episodio      INT           NOT NULL,
    id_veterinario   INT           NOT NULL,
    data_hora_pedido TIMESTAMP     NOT NULL,
    notas            VARCHAR(1000),
    FOREIGN KEY (id_episodio)    REFERENCES episodio (id_episodio),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario (id_pessoa)
);

CREATE TABLE linha_pedido (
    id_pedido   INT NOT NULL,
    id_analise  INT NOT NULL,
    PRIMARY KEY (id_pedido, id_analise),
    FOREIGN KEY (id_pedido)  REFERENCES pedido_laboratorial (id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_analise) REFERENCES analise (id_analise)
);

CREATE TABLE resultado (
    id_resultado          INT PRIMARY KEY,
    id_pedido             INT           NOT NULL,
    id_analise            INT           NOT NULL,
    id_colaborador        INT           NOT NULL,
    valor_obtido          NUMERIC(10,3) NOT NULL,
    data_hora_realizacao  TIMESTAMP     NOT NULL,
    data_hora_registo     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notas                 VARCHAR(1000),
    FOREIGN KEY (id_pedido, id_analise) REFERENCES linha_pedido (id_pedido, id_analise),
    FOREIGN KEY (id_colaborador)        REFERENCES colaborador (id_pessoa),
    CONSTRAINT ux_resultado_linha UNIQUE (id_pedido, id_analise),
    CONSTRAINT ck_resultado_datas CHECK (data_hora_registo >= data_hora_realizacao)
);

-- Função auxiliar: devolve a designação da função de um colaborador.
-- Lança erro se o colaborador estiver desativado (RN08).
CREATE OR REPLACE FUNCTION fn_funcao_colaborador_ativo(p_colaborador INT)
RETURNS VARCHAR AS $$
DECLARE
    v_funcao VARCHAR(30);
    v_ativo  BOOLEAN;
BEGIN
    SELECT f.designacao, c.ativo INTO v_funcao, v_ativo
      FROM colaborador AS c JOIN funcao AS f ON c.id_funcao = f.id_funcao
     WHERE c.id_pessoa = p_colaborador;
    IF NOT v_ativo THEN
        RAISE EXCEPTION 'O colaborador % está desativado', p_colaborador;
    END IF;
    RETURN v_funcao;
END;
$$ LANGUAGE plpgsql;

-- Função auxiliar: valida que o episódio está aberto e que a data do
-- registo não é anterior ao início do episódio.
CREATE OR REPLACE FUNCTION fn_validar_episodio(p_episodio INT, p_data TIMESTAMP)
RETURNS BOOLEAN AS $$
DECLARE
    v_inicio TIMESTAMP;
    v_fim    TIMESTAMP;
BEGIN
    SELECT data_hora_inicio, data_hora_fim INTO v_inicio, v_fim
      FROM episodio
     WHERE id_episodio = p_episodio;
    IF v_fim IS NOT NULL THEN
        RAISE EXCEPTION 'O episódio % está encerrado', p_episodio;
    END IF;
    IF p_data < v_inicio THEN
        RAISE EXCEPTION 'Data/hora (%) anterior ao início do episódio % (%)', p_data, p_episodio, v_inicio;
    END IF;
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;


-- Trigger: garante que um cliente desativado não recebe novos animais.
CREATE OR REPLACE FUNCTION trg_animal_cliente_ativo() RETURNS trigger AS $$
BEGIN
    IF NOT (SELECT ativo FROM cliente WHERE id_pessoa = NEW.id_cliente) THEN
        RAISE EXCEPTION 'O cliente % está desativado', NEW.id_cliente;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_animal_cliente_ativo
    BEFORE INSERT OR UPDATE OF id_cliente ON animal
    FOR EACH ROW EXECUTE FUNCTION trg_animal_cliente_ativo();


-- Trigger: garante a coerência entre a especialização Veterinário e a respetiva Função.
CREATE OR REPLACE FUNCTION trg_veterinario_funcao() RETURNS trigger AS $$
BEGIN
    IF (SELECT f.designacao
          FROM colaborador AS c JOIN funcao AS f ON c.id_funcao = f.id_funcao
         WHERE c.id_pessoa = NEW.id_pessoa) <> 'Veterinário' THEN
        RAISE EXCEPTION 'O colaborador % não tem a função de veterinário', NEW.id_pessoa;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_veterinario_funcao
    BEFORE INSERT OR UPDATE ON veterinario
    FOR EACH ROW EXECUTE FUNCTION trg_veterinario_funcao();

-- Trigger: garante que as marcações envolvem apenas colaboradores ativos e que
-- o mesmo veterinário não tem marcações com períodos sobrepostos.
CREATE OR REPLACE FUNCTION trg_marcacao_regras() RETURNS trigger AS $$
DECLARE
    v_funcao VARCHAR(30);
BEGIN
    SELECT fn_funcao_colaborador_ativo(NEW.id_veterinario) INTO v_funcao;
    SELECT fn_funcao_colaborador_ativo(NEW.id_registo) INTO v_funcao;
    IF EXISTS (SELECT *
                 FROM marcacao AS m
                WHERE m.id_veterinario = NEW.id_veterinario
                  AND m.id_marcacao <> NEW.id_marcacao
                  AND m.data_hora_inicio < NEW.data_hora_fim
                  AND m.data_hora_fim > NEW.data_hora_inicio) THEN
        RAISE EXCEPTION 'O veterinário % já tem uma marcação nesse período', NEW.id_veterinario;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_marcacao_regras
    BEFORE INSERT OR UPDATE ON marcacao
    FOR EACH ROW EXECUTE FUNCTION trg_marcacao_regras();

-- Trigger: garante que um animal não tem dois episódios abertos em simultâneo.
CREATE OR REPLACE FUNCTION trg_episodio_aberto_unico() RETURNS trigger AS $$
BEGIN
    IF NEW.data_hora_fim IS NULL
       AND EXISTS (SELECT *
                     FROM episodio
                    WHERE id_animal = NEW.id_animal
                      AND data_hora_fim IS NULL
                      AND id_episodio <> NEW.id_episodio) THEN
        RAISE EXCEPTION 'O animal % já tem um episódio aberto', NEW.id_animal;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_episodio_aberto_unico
    BEFORE INSERT OR UPDATE ON episodio
    FOR EACH ROW EXECUTE FUNCTION trg_episodio_aberto_unico();

-- Trigger: garante que um episódio só é encerrado se incluir uma consulta e,
-- havendo internamento, se a alta estiver registada até à data de encerramento.
CREATE OR REPLACE FUNCTION trg_episodio_encerramento() RETURNS trigger AS $$
DECLARE
    v_alta TIMESTAMP;
BEGIN
    IF NEW.data_hora_fim IS NOT NULL
       AND (OLD.data_hora_fim IS NULL OR OLD.data_hora_fim <> NEW.data_hora_fim) THEN
        IF NOT EXISTS (SELECT *
                         FROM ato_clinico AS a JOIN servico AS s ON a.id_servico = s.id_servico
                        WHERE a.id_episodio = NEW.id_episodio
                          AND s.designacao = 'Consulta') THEN
            RAISE EXCEPTION 'O episódio % não pode ser encerrado sem uma consulta', NEW.id_episodio;
        END IF;
        IF EXISTS (SELECT * FROM internamento WHERE id_episodio = NEW.id_episodio) THEN
            SELECT data_hora_fim INTO v_alta FROM internamento WHERE id_episodio = NEW.id_episodio;
            IF v_alta IS NULL THEN
                RAISE EXCEPTION 'O episódio % tem um internamento sem alta', NEW.id_episodio;
            ELSIF NEW.data_hora_fim < v_alta THEN
                RAISE EXCEPTION 'O encerramento não pode ser anterior à alta (%)', v_alta;
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_episodio_encerramento
    BEFORE UPDATE OF data_hora_fim ON episodio
    FOR EACH ROW EXECUTE FUNCTION trg_episodio_encerramento();

-- Trigger: garante que os atos clínicos são registados em episódios abertos,
-- por colaboradores ativos cuja função está autorizada para o serviço, que as
-- consultas são realizadas por veterinários e que a marcação associada, quando
-- existe, é de uma consulta do mesmo animal.
CREATE OR REPLACE FUNCTION trg_ato_clinico_regras() RETURNS trigger AS $$
DECLARE
    v_ok      BOOLEAN;
    v_funcao  VARCHAR(30);
    v_servico VARCHAR(50);
BEGIN
    -- Numa inserção não existe linha antiga, por isso OLD.id_ato é NULL: a
    -- validação do episódio só é feita ao inserir, permitindo corrigir os
    -- registos de um episódio já encerrado. O mesmo critério é usado nos
    -- triggers das observações, anexos e resultados.
    IF OLD.id_ato IS NULL THEN                       -- inserção
        SELECT fn_validar_episodio(NEW.id_episodio, NEW.data_hora) INTO v_ok;
    END IF;
    SELECT fn_funcao_colaborador_ativo(NEW.id_colaborador) INTO v_funcao;
    SELECT designacao INTO v_servico FROM servico WHERE id_servico = NEW.id_servico;
    IF NOT EXISTS (SELECT *
                     FROM colaborador AS c JOIN pode_realizar AS a ON c.id_funcao = a.id_funcao
                    WHERE c.id_pessoa = NEW.id_colaborador
                      AND a.id_servico = NEW.id_servico) THEN
        RAISE EXCEPTION 'A função do colaborador % não está autorizada para o serviço "%"',
            NEW.id_colaborador, v_servico;
    END IF;
    IF v_servico = 'Consulta'
       AND NOT EXISTS (SELECT * FROM veterinario WHERE id_pessoa = NEW.id_colaborador) THEN
        RAISE EXCEPTION 'As consultas só podem ser realizadas por veterinários';
    END IF;
    IF NEW.id_marcacao IS NOT NULL THEN
        IF v_servico <> 'Consulta' THEN
            RAISE EXCEPTION 'Só um ato do serviço Consulta pode resultar de uma marcação';
        END IF;
        IF (SELECT id_animal FROM marcacao WHERE id_marcacao = NEW.id_marcacao)
           <> (SELECT id_animal FROM episodio WHERE id_episodio = NEW.id_episodio) THEN
            RAISE EXCEPTION 'A marcação % refere-se a outro animal', NEW.id_marcacao;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_ato_clinico_regras
    BEFORE INSERT OR UPDATE ON ato_clinico
    FOR EACH ROW EXECUTE FUNCTION trg_ato_clinico_regras();

-- Trigger: garante que as observações são registadas em episódios abertos e
-- apenas por veterinários ou enfermeiros ativos.
CREATE OR REPLACE FUNCTION trg_observacao_regras() RETURNS trigger AS $$
DECLARE
    v_ok     BOOLEAN;
    v_funcao VARCHAR(30);
BEGIN
    IF OLD.id_observacao IS NULL THEN                -- inserção
        SELECT fn_validar_episodio(NEW.id_episodio, NEW.data_hora) INTO v_ok;
    END IF;
    SELECT fn_funcao_colaborador_ativo(NEW.id_colaborador) INTO v_funcao;
    IF v_funcao NOT IN ('Veterinário', 'Enfermeiro') THEN
        RAISE EXCEPTION 'Só veterinários e enfermeiros registam observações';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_observacao_regras
    BEFORE INSERT OR UPDATE ON observacao
    FOR EACH ROW EXECUTE FUNCTION trg_observacao_regras();

-- Trigger: garante que os anexos são carregados em episódios abertos, por
-- colaboradores ativos e não antes da realização do respetivo ato.
CREATE OR REPLACE FUNCTION trg_anexo_regras() RETURNS trigger AS $$
DECLARE
    v_ok       BOOLEAN;
    v_funcao   VARCHAR(30);
    v_episodio INT;
    v_data_ato TIMESTAMP;
BEGIN
    SELECT id_episodio, data_hora INTO v_episodio, v_data_ato
      FROM ato_clinico
     WHERE id_ato = NEW.id_ato;
    IF OLD.id_anexo IS NULL THEN                     -- inserção
        SELECT fn_validar_episodio(v_episodio, NEW.data_hora_upload) INTO v_ok;
    END IF;
    SELECT fn_funcao_colaborador_ativo(NEW.id_colaborador) INTO v_funcao;
    IF NEW.data_hora_upload < v_data_ato THEN
        RAISE EXCEPTION 'O anexo não pode ser carregado antes da realização do ato';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_anexo_regras
    BEFORE INSERT OR UPDATE ON anexo
    FOR EACH ROW EXECUTE FUNCTION trg_anexo_regras();

-- Trigger: garante que os resultados são registados em episódios abertos,
-- apenas por técnicos de laboratório ativos, e que a análise não é realizada
-- antes de ser pedida.
CREATE OR REPLACE FUNCTION trg_resultado_regras() RETURNS trigger AS $$
DECLARE
    v_ok        BOOLEAN;
    v_funcao    VARCHAR(30);
    v_episodio  INT;
    v_data_ped  TIMESTAMP;
BEGIN
    SELECT id_episodio, data_hora_pedido INTO v_episodio, v_data_ped
      FROM pedido_laboratorial
     WHERE id_pedido = NEW.id_pedido;
    IF OLD.id_resultado IS NULL THEN                 -- inserção
        SELECT fn_validar_episodio(v_episodio, NEW.data_hora_realizacao) INTO v_ok;
    END IF;
    SELECT fn_funcao_colaborador_ativo(NEW.id_colaborador) INTO v_funcao;
    IF v_funcao <> 'Técnico de laboratório' THEN
        RAISE EXCEPTION 'Só técnicos de laboratório registam resultados';
    END IF;
    IF NEW.data_hora_realizacao < v_data_ped THEN
        RAISE EXCEPTION 'A análise não pode ser realizada antes de ser pedida';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_resultado_regras
    BEFORE INSERT OR UPDATE ON resultado
    FOR EACH ROW EXECUTE FUNCTION trg_resultado_regras();
