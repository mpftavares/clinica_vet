-- =============================================================================
-- IBD 2026/27 — Entrega 2 — Clínica Veterinária
-- data.sql : povoamento da base de dados
--
-- Execução (depois do schema.sql):  psql -d <base_de_dados> -f data.sql
--
-- Os ids são indicados explicitamente, para as chaves estrangeiras.
-- Os registos clínicos de cada episódio são inseridos com o episódio aberto e
-- o episódio é encerrado no fim com UPDATE, para passar pelas validações dos
-- triggers (episódio aberto, consulta obrigatória, alta do internamento).
-- =============================================================================

BEGIN;

-- Funções e serviços ----------------------------------------------------------
INSERT INTO funcao (id_funcao, designacao) VALUES
  (1, 'Veterinário'),
  (2, 'Enfermeiro'),
  (3, 'Técnico de laboratório'),
  (4, 'Administrativo');
INSERT INTO servico (id_servico, designacao) VALUES
  (1, 'Consulta'),
  (2, 'Vacinação'),
  (3, 'Desparasitação'),
  (4, 'Penso'),
  (5, 'Administração de medicação'),
  (6, 'Colheita de sangue'),
  (7, 'Radiografia'),
  (8, 'Ecografia'),
  (9, 'Cirurgia'),
  (10, 'Microchipagem'),
  (11, 'Fluidoterapia');
INSERT INTO pode_realizar (id_funcao, id_servico) VALUES
  (1, 1),
  (1, 2),
  (2, 2),
  (1, 3),
  (2, 3),
  (1, 4),
  (2, 4),
  (1, 5),
  (2, 5),
  (1, 6),
  (2, 6),
  (1, 7),
  (1, 8),
  (1, 9),
  (1, 10),
  (1, 11),
  (2, 11);

-- Pessoas, colaboradores e clientes -------------------------------------------
INSERT INTO pessoa (id_pessoa, nome, nif, telefone, email, morada) VALUES
  (1, 'Patrícia Costa Moreira', '145499876', '913104048', 'patricia.moreira33@sapo.pt', NULL),
  (2, 'Bruno Fernandes Lopes', '206178714', '931844113', 'bruno.lopes7@hotmail.com', 'Rua do Ouro, 56, 2790-300 Carnaxide'),
  (3, 'Beatriz Fernandes Soares', '288047999', '920746858', 'beatriz.soares19@outlook.pt', NULL),
  (4, 'Joana Correia Marques', '193757822', '966429624', 'joana.marques63@gmail.com', NULL),
  (5, 'Luís Jesus Alves', '374426628', '920782261', 'luis.alves44@sapo.pt', NULL),
  (6, 'Rodrigo Pereira Costa', '105052395', '967985028', 'rodrigo.costa97@sapo.pt', NULL),
  (7, 'Filipe Pires Cardoso', '232754943', '918843542', 'filipe.cardoso81@hotmail.com', 'Av. Guerra Junqueiro, 201, 1700-500 Lisboa'),
  (8, 'Bruno Sousa Vieira', '137734618', '914491154', 'bruno.vieira82@sapo.pt', 'Rua do Ouro, 201, 1050-100 Lisboa'),
  (9, 'Rita Silva Vieira', '226255681', '910587286', 'rita.vieira96@sapo.pt', 'Av. de Roma, 176, 1675-100 Pontinha'),
  (10, 'Paulo Costa Marques', '371678673', '938667431', 'paulo.marques61@sapo.pt', 'Rua de Benfica, 84, 1600-400 Lisboa'),
  (11, 'Bruno Neves Rocha', '278906950', '925517732', 'bruno.rocha39@gmail.com', NULL),
  (12, 'Gonçalo Cunha Cunha', '194123150', '931714115', 'goncalo.cunha62@hotmail.com', NULL),
  (13, 'Raquel Ramos Almeida', '320185480', '912336844', 'raquel.almeida36@gmail.com', NULL),
  (14, 'Mariana Ferreira Carvalho', '124267085', '928356278', 'mariana.carvalho80@hotmail.com', NULL),
  (15, 'Diogo Ferreira Pinto', '223742620', '923024114', 'diogo.pinto24@gmail.com', 'Rua do Ouro, 106, 1675-100 Pontinha'),
  (16, 'Helena Pereira Neves', '128422216', '961134401', 'helena.neves17@gmail.com', NULL),
  (17, 'Helena Lopes Cardoso', '349261926', '928280803', 'helena.cardoso64@hotmail.com', NULL),
  (18, 'Bruno Gonçalves Pires', '261856816', '967073052', 'bruno.pires35@sapo.pt', NULL),
  (19, 'André Mendes Cardoso', '274718409', '965565462', 'andre.cardoso21@hotmail.com', NULL),
  (20, 'Luís Nunes Nunes', '130502642', '937582948', 'luis.nunes38@outlook.pt', NULL),
  (21, 'Luís Alves Alves', '109040487', '926534404', 'luis.alves42@hotmail.com', 'Rua do Ouro, 141, 1500-300 Lisboa'),
  (22, 'André Cunha Alves', '235871379', '930229405', 'andre.alves57@hotmail.com', 'Av. de Berna, 188, 1500-300 Lisboa'),
  (23, 'Tiago Coelho Rocha', '290699047', '932497254', 'tiago.rocha14@hotmail.com', 'Av. Guerra Junqueiro, 133, 1675-100 Pontinha'),
  (24, 'Bruno Pires Teixeira', '220285594', '922141937', NULL, 'Av. de Roma, 92, 1700-500 Lisboa'),
  (25, 'Patrícia Pires Alves', '205687150', '922391551', 'patricia.alves9@hotmail.com', 'Rua de Campolide, 14, 2780-200 Oeiras'),
  (26, 'Carlos Sousa Rocha', '337571172', '961888948', 'carlos.rocha23@sapo.pt', 'Rua de Benfica, 220, 1700-500 Lisboa'),
  (27, 'Joana Costa Correia', '257001721', '932364382', NULL, 'Av. da República, 79, 1000-001 Lisboa'),
  (28, 'Patrícia Oliveira Soares', '242184574', '962195955', 'patricia.soares17@outlook.pt', 'Rua do Ouro, 191, 1700-500 Lisboa'),
  (29, 'Teresa Pereira Carvalho', '111734640', '927896864', NULL, 'Av. de Roma, 221, 2780-200 Oeiras'),
  (30, 'Sofia Silva Rodrigues', '148133743', '963724192', 'sofia.rodrigues33@outlook.pt', 'Rua Coronel Pereira da Silva, 117, 1600-400 Lisboa'),
  (31, 'Carlos Ribeiro Ribeiro', '127600528', '960049458', 'carlos.ribeiro21@sapo.pt', 'Rua Castilho, 84, 2700-100 Amadora'),
  (32, 'Inês Gonçalves Silva', '282678976', '921874757', 'ines.silva38@gmail.com', 'Rua Coronel Pereira da Silva, 210, 1100-200 Lisboa'),
  (33, 'Beatriz Rodrigues Cruz', '366195701', '935456431', 'beatriz.cruz36@gmail.com', 'Av. Almirante Reis, 113, 2790-300 Carnaxide'),
  (34, 'Daniela Cardoso Lopes', '172108298', '925859633', 'daniela.lopes38@sapo.pt', 'Rua Coronel Pereira da Silva, 205, 1600-400 Lisboa'),
  (35, 'Rodrigo Cardoso Ferreira', '356783706', '938834546', 'rodrigo.ferreira23@gmail.com', 'Rua da Prata, 136, 1000-001 Lisboa'),
  (36, 'Tiago Moreira Reis', '200655203', '917077538', 'tiago.reis9@sapo.pt', 'Av. Almirante Reis, 2, 1000-001 Lisboa'),
  (37, 'João Pinto Almeida', '156615910', '960179088', 'joao.almeida54@outlook.pt', 'Rua Castilho, 59, 1500-300 Lisboa'),
  (38, 'Vera Ferreira Rodrigues', '193146417', '934079904', NULL, 'Av. João XXI, 2, 2780-200 Oeiras'),
  (39, 'André Rodrigues Marques', '370165195', '932628964', 'andre.marques6@sapo.pt', 'Rua Augusta, 174, 1100-200 Lisboa'),
  (40, 'Patrícia Alves Santos', '232848680', '916673877', 'patricia.santos29@sapo.pt', 'Av. da República, 23, 1000-001 Lisboa'),
  (41, 'Paulo Cruz Monteiro', '359398545', '925138092', NULL, 'Rua Coronel Pereira da Silva, 237, 2700-100 Amadora'),
  (42, 'Diogo Correia Vieira', '373656578', '926849822', NULL, 'Rua de Campolide, 14, 1700-500 Lisboa'),
  (43, 'Diogo Coelho Rocha', '265314898', '965957066', 'diogo.rocha94@hotmail.com', 'Rua Augusta, 8, 2780-200 Oeiras'),
  (44, 'Carla Jesus Oliveira', '347864888', '963727943', 'carla.oliveira1@gmail.com', 'Av. Almirante Reis, 205, 1050-100 Lisboa'),
  (45, 'Tiago Gomes Marques', '386321105', '915678839', 'tiago.marques16@sapo.pt', 'Rua Gomes Freire, 83, 1100-200 Lisboa'),
  (46, 'Vasco Costa Teixeira', '198629023', '926870796', 'vasco.teixeira41@gmail.com', 'Av. da República, 217, 1500-300 Lisboa'),
  (47, 'Gonçalo Martins Almeida', '393248581', '924044516', NULL, 'Av. da República, 203, 1700-500 Lisboa'),
  (48, 'Patrícia Neves Neves', '218363260', '924928266', 'patricia.neves80@sapo.pt', 'Rua Morais Soares, 51, 2700-100 Amadora'),
  (49, 'Mariana Santos Sousa', '112915850', '968691447', 'mariana.sousa33@outlook.pt', 'Estrada de Telheiras, 64, 1500-300 Lisboa'),
  (50, 'Inês Gonçalves Alves', '340669609', '919313619', NULL, 'Rua do Ouro, 31, 2700-100 Amadora');
INSERT INTO pessoa (id_pessoa, nome, nif, telefone, email, morada) VALUES
  (51, 'Gonçalo Marques Costa', '103097847', '920488893', 'goncalo.costa74@hotmail.com', 'Rua de Benfica, 206, 2780-200 Oeiras'),
  (52, 'João Rodrigues Sousa', '231257493', '935285266', 'joao.sousa54@gmail.com', 'Estrada de Telheiras, 19, 1600-400 Lisboa'),
  (53, 'Gonçalo Marques Oliveira', '351454123', '960007864', 'goncalo.oliveira10@sapo.pt', 'Av. Guerra Junqueiro, 99, 1050-100 Lisboa'),
  (54, 'João Coelho Coelho', '276517562', '928050248', 'joao.coelho58@hotmail.com', 'Av. da República, 164, 1700-500 Lisboa'),
  (55, 'Ana Pereira Cardoso', '215590722', '920196495', NULL, 'Av. João XXI, 172, 2700-100 Amadora'),
  (56, 'Carla Pinto Martins', '187112418', '933037053', 'carla.martins90@gmail.com', 'Av. de Roma, 70, 1500-300 Lisboa'),
  (57, 'Vasco Oliveira Moreira', '331729326', '926139794', 'vasco.moreira84@sapo.pt', 'Rua do Ouro, 217, 1675-100 Pontinha'),
  (58, 'Carlos Mendes Almeida', '380404439', '914672770', 'carlos.almeida48@sapo.pt', 'Estrada de Telheiras, 163, 2790-300 Carnaxide'),
  (59, 'Miguel Gonçalves Pires', '220498235', '918735576', 'miguel.pires85@hotmail.com', 'Rua de Campolide, 52, 1050-100 Lisboa'),
  (60, 'Manuel Santos Pires', '118095340', '914467348', NULL, 'Av. João XXI, 184, 1000-001 Lisboa'),
  (61, 'Luís Sousa Carvalho', '348096636', '922896242', 'luis.carvalho16@outlook.pt', 'Rua de Benfica, 249, 2700-100 Amadora'),
  (62, 'Beatriz Neves Sousa', '372470072', '914817148', 'beatriz.sousa97@outlook.pt', 'Av. de Berna, 130, 1050-100 Lisboa'),
  (63, 'Teresa Moreira Moreira', '131502911', '923914423', 'teresa.moreira2@gmail.com', 'Rua Augusta, 38, 1100-200 Lisboa'),
  (64, 'André Gomes Almeida', '124241064', '963903994', 'andre.almeida38@outlook.pt', 'Av. Almirante Reis, 88, 1500-300 Lisboa'),
  (65, 'Carlos Pereira Soares', '128026816', '922639700', 'carlos.soares8@sapo.pt', 'Av. da República, 162, 1100-200 Lisboa'),
  (66, 'Teresa Pereira Jesus', '358865933', '938725749', 'teresa.jesus95@hotmail.com', 'Av. da República, 223, 2790-300 Carnaxide'),
  (67, 'Catarina Fernandes Ramos', '390449894', '964153159', 'catarina.ramos16@hotmail.com', 'Estrada de Telheiras, 91, 1700-500 Lisboa'),
  (68, 'Raquel Santos Pires', '196860840', '923674184', 'raquel.pires80@gmail.com', 'Av. da República, 41, 1100-200 Lisboa'),
  (69, 'Raquel Jesus Pires', '226976325', '966074032', 'raquel.pires30@gmail.com', 'Av. de Berna, 49, 2780-200 Oeiras'),
  (70, 'Rui Rodrigues Cunha', '200608006', '936250345', 'rui.cunha61@hotmail.com', 'Rua Castilho, 3, 1500-300 Lisboa'),
  (71, 'Diogo Gomes Costa', '273869140', '933311297', 'diogo.costa41@sapo.pt', 'Rua Coronel Pereira da Silva, 147, 2790-300 Carnaxide'),
  (72, 'Carlos Cardoso Teixeira', '107432537', '928456326', NULL, 'Rua Castilho, 39, 2780-200 Oeiras'),
  (73, 'Carlos Monteiro Silva', '358755402', '930315033', 'carlos.silva4@hotmail.com', 'Rua de Benfica, 100, 1050-100 Lisboa'),
  (74, 'Nuno Cardoso Reis', '291954839', '911473730', 'nuno.reis80@outlook.pt', 'Rua do Ouro, 245, 1050-100 Lisboa'),
  (75, 'Joana Coelho Cruz', '154074472', '921798147', 'joana.cruz18@outlook.pt', 'Estrada de Telheiras, 51, 2780-200 Oeiras'),
  (76, 'Rita Fernandes Ramos', '274934807', '964299070', 'rita.ramos36@hotmail.com', 'Rua do Ouro, 55, 1000-001 Lisboa'),
  (77, 'Filipa Teixeira Vieira', '268170822', '935127883', 'filipa.vieira71@sapo.pt', 'Estrada de Telheiras, 171, 1675-100 Pontinha'),
  (78, 'Ana Lopes Cunha', '224910169', '931285747', 'ana.cunha16@sapo.pt', 'Rua do Ouro, 190, 1050-100 Lisboa'),
  (79, 'Ricardo Nunes Moreira', '104861606', '931269900', NULL, 'Estrada de Telheiras, 32, 1675-100 Pontinha'),
  (80, 'Leonor Rocha Pereira', '257929854', '916542497', 'leonor.pereira11@outlook.pt', 'Estrada de Telheiras, 125, 1100-200 Lisboa'),
  (81, 'Luís Pinto Silva', '386328405', '967758475', NULL, 'Av. de Roma, 145, 1700-500 Lisboa'),
  (82, 'Patrícia Ferreira Gomes', '137368141', '927340559', NULL, 'Rua Coronel Pereira da Silva, 16, 1600-400 Lisboa'),
  (83, 'Filipa Carvalho Almeida', '388182006', '931507194', 'filipa.almeida2@hotmail.com', 'Rua do Ouro, 201, 1100-200 Lisboa'),
  (84, 'Leonor Fernandes Ribeiro', '314937955', '912404780', NULL, 'Rua Augusta, 155, 1675-100 Pontinha'),
  (85, 'Inês Jesus Soares', '342381826', '927544564', NULL, 'Rua Morais Soares, 134, 2780-200 Oeiras'),
  (86, 'Filipe Carvalho Carvalho', '253695381', '915037661', 'filipe.carvalho38@hotmail.com', 'Av. de Berna, 124, 2780-200 Oeiras');
INSERT INTO colaborador (id_pessoa, id_funcao, ativo) VALUES
  (1, 1, TRUE),
  (2, 1, TRUE),
  (3, 1, TRUE),
  (4, 1, TRUE),
  (5, 1, TRUE),
  (6, 1, TRUE),
  (7, 2, TRUE),
  (8, 2, TRUE),
  (9, 2, TRUE),
  (10, 2, TRUE),
  (11, 2, TRUE),
  (12, 3, TRUE),
  (13, 3, TRUE),
  (14, 3, TRUE),
  (15, 4, TRUE),
  (16, 4, TRUE),
  (17, 4, TRUE),
  (18, 4, TRUE),
  (19, 1, TRUE),
  (20, 2, TRUE);
INSERT INTO veterinario (id_pessoa, cedula_profissional) VALUES
  (1, 'OMV1500'),
  (2, 'OMV1637'),
  (3, 'OMV1774'),
  (4, 'OMV1911'),
  (5, 'OMV2048'),
  (6, 'OMV2185'),
  (19, 'OMV2322');
INSERT INTO cliente (id_pessoa, ativo) VALUES
  (21, TRUE),
  (22, TRUE),
  (23, TRUE),
  (24, TRUE),
  (25, TRUE),
  (26, TRUE),
  (27, TRUE),
  (28, TRUE),
  (29, TRUE),
  (30, TRUE),
  (31, TRUE),
  (32, TRUE),
  (33, TRUE),
  (34, TRUE),
  (35, TRUE),
  (36, TRUE),
  (37, TRUE),
  (38, TRUE),
  (39, TRUE),
  (40, TRUE),
  (41, TRUE),
  (42, TRUE),
  (43, TRUE),
  (44, TRUE),
  (45, TRUE),
  (46, TRUE),
  (47, TRUE),
  (48, TRUE),
  (49, TRUE),
  (50, TRUE),
  (51, TRUE),
  (52, TRUE),
  (53, TRUE),
  (54, TRUE),
  (55, TRUE),
  (56, TRUE),
  (57, TRUE),
  (58, TRUE),
  (59, TRUE),
  (60, TRUE),
  (61, TRUE),
  (62, TRUE),
  (63, TRUE),
  (64, TRUE),
  (65, TRUE),
  (66, TRUE),
  (67, TRUE),
  (68, TRUE),
  (69, TRUE),
  (70, TRUE);
INSERT INTO cliente (id_pessoa, ativo) VALUES
  (71, TRUE),
  (72, TRUE),
  (73, TRUE),
  (74, TRUE),
  (75, TRUE),
  (76, TRUE),
  (77, TRUE),
  (78, TRUE),
  (79, TRUE),
  (80, TRUE),
  (81, TRUE),
  (82, TRUE),
  (83, TRUE),
  (84, TRUE),
  (85, TRUE),
  (86, TRUE),
  (2, TRUE),
  (7, TRUE);

-- Animais ---------------------------------------------------------------------
INSERT INTO animal (id_animal, id_cliente, nome, especie, raca, sexo, data_nascimento, microchip) VALUES
  (1, 21, 'Mia', 'Gato', 'Siamês', 'F', '2023-03-22', '620268393600478'),
  (2, 22, 'Óscar', 'Cão', 'Bulldog Francês', 'M', '2012-01-28', '620592559873047'),
  (3, 23, 'Riscas', 'Cão', 'Cão de Água Português', 'M', '2023-05-20', '620330131304302'),
  (4, 24, 'Zeus', 'Gato', 'British Shorthair', 'M', '2015-06-24', '620719031569509'),
  (5, 25, 'Pintas', 'Cão', 'Yorkshire Terrier', 'F', '2025-12-04', NULL),
  (6, 26, 'Canela', 'Cão', 'Golden Retriever', 'M', '2024-10-07', '620146322992083'),
  (7, 26, 'Rocky', 'Cão', 'Labrador Retriever', 'F', NULL, '620310864417935'),
  (8, 27, 'Chico', 'Cão', 'Labrador Retriever', 'M', '2016-05-20', NULL),
  (9, 27, 'Sombra', 'Cão', 'Boxer', 'M', '2022-12-27', '620596656864806'),
  (10, 28, 'Canela', 'Ave', 'Papagaio-cinzento', 'F', '2018-01-23', NULL),
  (11, 28, 'Pirata', 'Outro', 'Ouriço-pigmeu-africano', 'M', '2017-12-15', NULL),
  (12, 28, 'Pintas', 'Coelho', 'Anão Holandês', 'F', '2014-08-26', NULL),
  (13, 29, 'Snoopy', 'Cão', 'Yorkshire Terrier', 'M', '2016-08-15', '620675517469475'),
  (14, 30, 'Chico', 'Gato', 'Maine Coon', 'M', '2019-06-14', '620546047390559'),
  (15, 31, 'Jade', 'Coelho', 'Cabeça de Leão', 'F', '2018-04-15', NULL),
  (16, 31, 'Max', 'Gato', 'Europeu Comum', 'M', '2022-09-26', '620805193032808'),
  (17, 32, 'Canela', 'Gato', NULL, 'F', '2021-10-25', '620170848468874'),
  (18, 33, 'Canela', 'Gato', NULL, 'M', '2019-12-31', '620748749324681'),
  (19, 34, 'Sombra', 'Furão', NULL, 'M', '2013-08-05', '620937840703211'),
  (20, 35, 'Leo', 'Cão', 'Boxer', 'F', '2023-06-12', NULL),
  (21, 36, 'Farrusco', 'Cão', 'Bulldog Francês', 'M', '2019-06-06', NULL),
  (22, 37, 'Jade', 'Gato', 'Siamês', 'F', '2011-12-24', NULL),
  (23, 38, 'Kiko', 'Cão', 'Chihuahua', 'F', '2019-12-29', NULL),
  (24, 39, 'Luna', 'Cão', 'Podengo Português', 'M', '2021-10-06', '620403831452065'),
  (25, 39, 'Bela', 'Cão', 'Bulldog Francês', 'F', '2016-09-22', '620876782474888'),
  (26, 40, 'Leo', 'Coelho', NULL, 'M', '2013-01-06', NULL),
  (27, 41, 'Becas', 'Gato', 'Bengal', 'F', NULL, '620009661238661'),
  (28, 42, 'Pintas', 'Coelho', 'Cabeça de Leão', 'M', '2014-09-06', NULL),
  (29, 43, 'Sombra', 'Cão', NULL, 'F', '2024-03-17', '620063564740009'),
  (30, 43, 'Baltasar', 'Gato', 'Bengal', 'F', '2017-01-10', '620919205823547'),
  (31, 44, 'Tobi', 'Gato', 'Siamês', 'M', '2023-07-16', NULL),
  (32, 45, 'Kika', 'Cão', 'Pastor Alemão', 'F', '2015-01-04', NULL),
  (33, 46, 'Luna', 'Gato', 'Bengal', 'M', '2014-07-10', '620403168988260'),
  (34, 47, 'Estrela', 'Gato', NULL, 'F', '2013-09-21', NULL),
  (35, 48, 'Kika', 'Cão', 'Labrador Retriever', 'F', NULL, '620859758115979'),
  (36, 49, 'Zeus', 'Gato', 'Maine Coon', 'M', '2016-07-12', NULL),
  (37, 50, 'Faísca', 'Outro', 'Ouriço-pigmeu-africano', 'M', '2018-06-28', NULL),
  (38, 51, 'Zeus', 'Cão', 'Boxer', 'F', '2015-11-16', NULL),
  (39, 52, 'Farrusco', 'Roedor', 'Porquinho-da-índia', 'F', '2012-09-06', NULL),
  (40, 53, 'Bolinha', 'Cão', 'Golden Retriever', 'F', '2016-02-05', '620340594594268'),
  (41, 54, 'Baltasar', 'Cão', 'Labrador Retriever', 'M', '2018-07-23', '620020946764549'),
  (42, 55, 'Bolinha', 'Gato', NULL, 'M', NULL, '620052571660539'),
  (43, 56, 'Bolinha', 'Gato', 'Europeu Comum', 'M', '2013-06-29', '620533001755774'),
  (44, 57, 'Nala', 'Cão', 'Boxer', 'M', '2015-06-02', NULL),
  (45, 58, 'Luna', 'Gato', NULL, 'F', '2021-04-27', '620749307218109'),
  (46, 59, 'Mia', 'Furão', NULL, 'M', '2020-11-25', NULL),
  (47, 59, 'Lola', 'Cão', 'Golden Retriever', 'M', '2025-05-17', '620031416528611'),
  (48, 60, 'Fofinho', 'Cão', 'Chihuahua', 'F', '2018-06-22', '620057353373151'),
  (49, 60, 'Bobi', 'Gato', 'Persa', 'M', NULL, '620616533728915'),
  (50, 61, 'Max', 'Cão', 'Chihuahua', 'F', '2016-11-16', '620272718851236');
INSERT INTO animal (id_animal, id_cliente, nome, especie, raca, sexo, data_nascimento, microchip) VALUES
  (51, 62, 'Bela', 'Cão', 'Boxer', 'F', '2017-08-30', NULL),
  (52, 62, 'Simba', 'Coelho', 'Anão Holandês', 'F', '2013-05-17', NULL),
  (53, 63, 'Farrusco', 'Gato', 'Bengal', 'M', '2020-10-12', '620542120226645'),
  (54, 64, 'Lola', 'Furão', NULL, 'M', '2019-04-25', '620290335064683'),
  (55, 65, 'Pantufa', 'Gato', NULL, 'F', '2011-08-12', '620008726168004'),
  (56, 66, 'Pintas', 'Cão', 'Pastor Alemão', 'M', '2025-11-23', '620103110204242'),
  (57, 66, 'Pirata', 'Gato', NULL, 'M', '2023-10-19', NULL),
  (58, 67, 'Lola', 'Cão', 'Beagle', 'F', '2024-01-01', '620873877688104'),
  (59, 68, 'Lua', 'Gato', 'Maine Coon', 'F', '2017-10-27', '620260442004048'),
  (60, 69, 'Max', 'Gato', 'Bengal', 'M', '2024-10-22', '620197659398573'),
  (61, 69, 'Ruca', 'Coelho', 'Belier', 'F', '2020-10-14', NULL),
  (62, 70, 'Bobi', 'Gato', 'Maine Coon', 'F', '2016-08-17', '620971803951281'),
  (63, 71, 'Matilde', 'Gato', 'Persa', 'F', '2017-08-07', '620735991918284'),
  (64, 71, 'Zeus', 'Cão', 'Pastor Alemão', 'F', '2015-05-22', '620415483269910'),
  (65, 72, 'Max', 'Gato', 'Persa', 'F', '2024-05-12', '620121836345487'),
  (66, 73, 'Nina', 'Coelho', NULL, 'F', '2014-03-31', NULL),
  (67, 74, 'Bolinha', 'Outro', 'Ouriço-pigmeu-africano', 'M', '2019-04-29', NULL),
  (68, 75, 'Luna', 'Cão', 'Chihuahua', 'F', '2014-07-01', NULL),
  (69, 75, 'Leo', 'Cão', 'Boxer', 'M', '2014-05-31', NULL),
  (70, 76, 'Ruca', 'Gato', 'Maine Coon', 'F', '2014-02-20', '620096450396003'),
  (71, 77, 'Zeus', 'Gato', 'British Shorthair', 'F', '2013-10-12', NULL),
  (72, 78, 'Becas', 'Gato', 'Maine Coon', 'M', '2014-09-20', '620531841148931'),
  (73, 79, 'Max', 'Ave', 'Caturra', 'F', '2020-09-22', NULL),
  (74, 80, 'Bolinha', 'Réptil', 'Pitão-real', 'F', '2013-06-19', NULL),
  (75, 80, 'Bolinha', 'Gato', 'British Shorthair', 'M', NULL, '620164928565554'),
  (76, 81, 'Kiko', 'Gato', 'Europeu Comum', 'F', '2017-02-13', '620779523712413'),
  (77, 81, 'Mia', 'Coelho', 'Cabeça de Leão', 'F', '2015-05-04', NULL),
  (78, 82, 'Max', 'Gato', 'Maine Coon', 'F', '2018-08-04', '620423489880319'),
  (79, 2, 'Ruca', 'Ave', 'Caturra', 'F', '2017-06-15', NULL),
  (80, 7, 'Piloto', 'Gato', 'Persa', 'F', '2018-02-19', '620196115806641'),
  (81, 7, 'Baltasar', 'Gato', 'Bengal', 'F', '2016-11-01', '620032901715516');

-- Catálogo de análises --------------------------------------------------------
INSERT INTO analise (id_analise, nome, unidade_medida, valor_ref_min, valor_ref_max) VALUES
  (1, 'Glicose', 'mg/dL', 70, 140),
  (2, 'Ureia', 'mg/dL', 15, 60),
  (3, 'Creatinina', 'mg/dL', 0.5, 1.8),
  (4, 'ALT', 'U/L', 10, 100),
  (5, 'Fosfatase alcalina', 'U/L', 20, 150),
  (6, 'Hematócrito', '%', 37, 55),
  (7, 'Leucócitos', '10^9/L', 6, 17),
  (8, 'Plaquetas', '10^9/L', 200, 500),
  (9, 'Proteínas totais', 'g/dL', 5.4, 7.6),
  (10, 'Albumina', 'g/dL', 2.6, 4.0),
  (11, 'Potássio', 'mmol/L', 3.5, 5.8),
  (12, 'Sódio', 'mmol/L', 140, 155),
  (13, 'T4 total', 'ug/dL', 1.0, 4.0),
  (14, 'SDMA', 'ug/dL', NULL, 14);

-- Marcações (inclui faltas e marcações futuras sem consulta) ------------------
INSERT INTO marcacao (id_marcacao, id_animal, id_veterinario, id_registo, data_hora_inicio, data_hora_fim) VALUES
  (1, 1, 5, 18, '2025-12-12 12:00', '2025-12-12 12:30'),
  (2, 1, 2, 8, '2026-06-04 16:30', '2026-06-04 17:00'),
  (3, 1, 4, 11, '2026-06-19 10:30', '2026-06-19 11:00'),
  (4, 1, 3, 9, '2026-07-01 15:30', '2026-07-01 16:00'),
  (5, 1, 6, 7, '2026-07-20 12:30', '2026-07-20 13:00'),
  (6, 2, 4, 11, '2026-09-21 10:00', '2026-09-21 10:30'),
  (7, 3, 3, 16, '2025-09-22 09:00', '2025-09-22 09:30'),
  (8, 3, 2, 11, '2026-10-12 11:30', '2026-10-12 12:00'),
  (9, 4, 4, 9, '2026-05-15 10:00', '2026-05-15 10:30'),
  (10, 5, 4, 8, '2025-03-24 11:30', '2025-03-24 12:00'),
  (11, 6, 19, 8, '2025-08-12 09:00', '2025-08-12 09:30'),
  (12, 6, 6, 7, '2026-09-16 09:30', '2026-09-16 10:00'),
  (13, 7, 3, 7, '2025-06-16 14:30', '2025-06-16 15:00'),
  (14, 7, 3, 7, '2026-02-09 11:30', '2026-02-09 12:00'),
  (15, 8, 2, 17, '2025-11-10 13:30', '2025-11-10 14:00'),
  (16, 9, 3, 8, '2025-12-08 10:30', '2025-12-08 11:00'),
  (17, 9, 3, 18, '2026-04-16 15:00', '2026-04-16 15:30'),
  (18, 12, 3, 17, '2026-06-05 11:00', '2026-06-05 11:30'),
  (19, 14, 19, 10, '2025-04-07 15:30', '2025-04-07 16:00'),
  (20, 15, 3, 8, '2026-06-08 10:00', '2026-06-08 10:30'),
  (21, 16, 6, 8, '2026-02-10 14:30', '2026-02-10 15:00'),
  (22, 16, 1, 17, '2026-07-15 12:00', '2026-07-15 12:30'),
  (23, 16, 2, 17, '2026-09-07 15:00', '2026-09-07 15:30'),
  (24, 16, 4, 16, '2026-10-02 12:00', '2026-10-02 12:30'),
  (25, 17, 6, 15, '2025-04-16 17:30', '2025-04-16 18:00'),
  (26, 17, 6, 7, '2025-11-07 10:00', '2025-11-07 10:30'),
  (27, 18, 6, 18, '2026-04-13 13:30', '2026-04-13 14:00'),
  (28, 21, 3, 8, '2026-03-02 16:30', '2026-03-02 17:00'),
  (29, 22, 4, 10, '2026-04-06 11:30', '2026-04-06 12:00'),
  (30, 23, 1, 11, '2025-11-06 14:00', '2025-11-06 14:30'),
  (31, 23, 5, 17, '2026-05-11 10:30', '2026-05-11 11:00'),
  (32, 24, 3, 17, '2025-04-10 17:30', '2025-04-10 18:00'),
  (33, 24, 2, 8, '2026-04-27 15:30', '2026-04-27 16:00'),
  (34, 25, 2, 16, '2025-02-27 14:00', '2025-02-27 14:30'),
  (35, 25, 5, 7, '2026-10-09 12:00', '2026-10-09 12:30'),
  (36, 26, 2, 7, '2025-12-26 14:30', '2025-12-26 15:00'),
  (37, 27, 1, 10, '2025-07-07 10:30', '2025-07-07 11:00'),
  (38, 28, 4, 8, '2026-01-09 16:00', '2026-01-09 16:30'),
  (39, 28, 6, 9, '2026-10-02 10:00', '2026-10-02 10:30'),
  (40, 29, 3, 18, '2025-04-02 12:00', '2025-04-02 12:30'),
  (41, 29, 6, 17, '2025-10-08 11:00', '2025-10-08 11:30'),
  (42, 29, 1, 11, '2026-06-22 12:30', '2026-06-22 13:00'),
  (43, 31, 2, 7, '2025-12-24 17:30', '2025-12-24 18:00'),
  (44, 31, 1, 7, '2026-06-12 16:30', '2026-06-12 17:00'),
  (45, 31, 3, 10, '2026-07-15 12:00', '2026-07-15 12:30'),
  (46, 32, 1, 10, '2025-09-29 09:00', '2025-09-29 09:30'),
  (47, 33, 3, 11, '2026-03-10 09:30', '2026-03-10 10:00'),
  (48, 34, 19, 8, '2025-07-28 13:00', '2025-07-28 13:30'),
  (49, 34, 2, 18, '2025-12-01 14:00', '2025-12-01 14:30'),
  (50, 35, 19, 9, '2025-12-16 13:30', '2025-12-16 14:00');
INSERT INTO marcacao (id_marcacao, id_animal, id_veterinario, id_registo, data_hora_inicio, data_hora_fim) VALUES
  (51, 36, 1, 7, '2025-06-02 09:30', '2025-06-02 10:00'),
  (52, 37, 5, 9, '2025-04-28 14:30', '2025-04-28 15:00'),
  (53, 38, 3, 10, '2026-07-08 17:00', '2026-07-08 17:30'),
  (54, 39, 19, 9, '2025-12-26 09:30', '2025-12-26 10:00'),
  (55, 41, 19, 10, '2025-06-13 13:00', '2025-06-13 13:30'),
  (56, 41, 6, 18, '2025-10-01 16:30', '2025-10-01 17:00'),
  (57, 43, 5, 16, '2025-07-21 17:30', '2025-07-21 18:00'),
  (58, 43, 3, 18, '2025-08-18 15:00', '2025-08-18 15:30'),
  (59, 43, 5, 9, '2026-07-10 13:30', '2026-07-10 14:00'),
  (60, 44, 6, 7, '2025-05-05 17:00', '2025-05-05 17:30'),
  (61, 44, 1, 17, '2026-07-08 09:00', '2026-07-08 09:30'),
  (62, 45, 1, 16, '2026-09-23 11:30', '2026-09-23 12:00'),
  (63, 46, 19, 16, '2025-11-24 12:00', '2025-11-24 12:30'),
  (64, 46, 19, 9, '2025-12-01 13:00', '2025-12-01 13:30'),
  (65, 46, 5, 10, '2026-03-16 09:00', '2026-03-16 09:30'),
  (66, 46, 5, 8, '2026-09-29 15:00', '2026-09-29 15:30'),
  (67, 47, 19, 10, '2025-04-02 11:30', '2025-04-02 12:00'),
  (68, 49, 1, 9, '2025-02-13 10:30', '2025-02-13 11:00'),
  (69, 49, 4, 8, '2025-08-04 11:00', '2025-08-04 11:30'),
  (70, 52, 2, 18, '2025-03-24 12:00', '2025-03-24 12:30'),
  (71, 52, 2, 8, '2025-06-09 12:00', '2025-06-09 12:30'),
  (72, 53, 2, 18, '2025-08-05 16:00', '2025-08-05 16:30'),
  (73, 54, 2, 8, '2026-08-14 11:00', '2026-08-14 11:30'),
  (74, 55, 5, 17, '2026-04-01 12:30', '2026-04-01 13:00'),
  (75, 56, 2, 7, '2026-05-25 09:00', '2026-05-25 09:30'),
  (76, 57, 3, 18, '2025-07-07 15:00', '2025-07-07 15:30'),
  (77, 58, 4, 15, '2026-08-11 16:00', '2026-08-11 16:30'),
  (78, 59, 6, 18, '2026-05-01 09:00', '2026-05-01 09:30'),
  (79, 59, 4, 10, '2026-10-26 12:00', '2026-10-26 12:30'),
  (80, 61, 3, 7, '2026-01-19 09:30', '2026-01-19 10:00'),
  (81, 61, 1, 7, '2026-06-29 14:30', '2026-06-29 15:00'),
  (82, 61, 3, 10, '2026-07-14 10:00', '2026-07-14 10:30'),
  (83, 61, 2, 15, '2026-08-06 15:00', '2026-08-06 15:30'),
  (84, 61, 3, 17, '2026-10-13 15:00', '2026-10-13 15:30'),
  (85, 63, 19, 11, '2025-02-03 14:00', '2025-02-03 14:30'),
  (86, 63, 1, 10, '2025-08-21 14:00', '2025-08-21 14:30'),
  (87, 64, 1, 9, '2025-03-11 10:00', '2025-03-11 10:30'),
  (88, 64, 3, 10, '2025-04-07 10:00', '2025-04-07 10:30'),
  (89, 64, 5, 15, '2026-09-14 14:00', '2026-09-14 14:30'),
  (90, 65, 1, 17, '2025-01-17 14:30', '2025-01-17 15:00'),
  (91, 66, 1, 18, '2025-04-24 13:00', '2025-04-24 13:30'),
  (92, 68, 1, 7, '2025-12-01 14:30', '2025-12-01 15:00'),
  (93, 68, 4, 17, '2026-10-26 14:30', '2026-10-26 15:00'),
  (94, 69, 2, 15, '2025-02-19 11:00', '2025-02-19 11:30'),
  (95, 71, 3, 16, '2025-05-26 12:30', '2025-05-26 13:00'),
  (96, 71, 6, 11, '2025-07-08 09:00', '2025-07-08 09:30'),
  (97, 73, 6, 8, '2025-09-02 10:30', '2025-09-02 11:00'),
  (98, 73, 4, 16, '2026-03-17 14:30', '2026-03-17 15:00'),
  (99, 73, 4, 7, '2026-06-09 11:00', '2026-06-09 11:30'),
  (100, 74, 4, 11, '2025-01-24 14:00', '2025-01-24 14:30');
INSERT INTO marcacao (id_marcacao, id_animal, id_veterinario, id_registo, data_hora_inicio, data_hora_fim) VALUES
  (101, 76, 19, 18, '2026-01-26 09:00', '2026-01-26 09:30'),
  (102, 76, 4, 16, '2026-02-12 13:00', '2026-02-12 13:30'),
  (103, 76, 2, 18, '2026-03-27 10:00', '2026-03-27 10:30'),
  (104, 76, 3, 8, '2026-06-29 09:00', '2026-06-29 09:30'),
  (105, 77, 6, 15, '2026-04-20 09:00', '2026-04-20 09:30'),
  (106, 77, 6, 10, '2026-07-13 17:30', '2026-07-13 18:00'),
  (107, 78, 19, 18, '2025-07-03 09:00', '2025-07-03 09:30'),
  (108, 79, 2, 9, '2025-08-28 09:30', '2025-08-28 10:00'),
  (109, 79, 1, 7, '2026-04-03 11:30', '2026-04-03 12:00'),
  (110, 81, 2, 16, '2025-12-31 11:30', '2025-12-31 12:00'),
  (111, 57, 5, 10, '2026-11-02 15:30', '2026-11-02 16:00'),
  (112, 16, 2, 16, '2026-11-02 12:00', '2026-11-02 12:30'),
  (113, 67, 4, 17, '2026-10-28 09:00', '2026-10-28 09:30'),
  (114, 34, 3, 11, '2026-10-27 09:00', '2026-10-27 09:30'),
  (115, 81, 3, 8, '2026-04-20 15:30', '2026-04-20 16:00'),
  (116, 43, 5, 18, '2025-09-10 15:00', '2025-09-10 15:30'),
  (117, 38, 5, 17, '2025-08-25 09:30', '2025-08-25 10:00'),
  (118, 23, 6, 18, '2025-07-25 12:30', '2025-07-25 13:00'),
  (119, 71, 1, 9, '2025-12-25 11:00', '2025-12-25 11:30'),
  (120, 3, 3, 16, '2026-06-10 12:00', '2026-06-10 12:30'),
  (121, 73, 4, 10, '2025-03-04 17:30', '2025-03-04 18:00'),
  (122, 76, 6, 9, '2026-10-19 14:00', '2026-10-19 14:30'),
  (123, 9, 4, 18, '2025-11-24 09:00', '2025-11-24 09:30'),
  (124, 26, 19, 11, '2026-01-05 14:00', '2026-01-05 14:30'),
  (125, 21, 4, 7, '2026-12-16 09:00', '2026-12-16 09:30'),
  (126, 65, 3, 11, '2026-11-25 15:30', '2026-11-25 16:00'),
  (127, 67, 2, 7, '2026-12-15 10:30', '2026-12-15 11:00'),
  (128, 71, 3, 15, '2026-11-25 15:00', '2026-11-25 15:30'),
  (129, 76, 4, 18, '2026-11-30 13:30', '2026-11-30 14:00'),
  (130, 5, 1, 11, '2026-12-16 09:00', '2026-12-16 09:30'),
  (131, 60, 4, 15, '2026-12-21 14:30', '2026-12-21 15:00'),
  (132, 4, 3, 9, '2026-12-15 09:30', '2026-12-15 10:00');

-- Episódios clínicos e respetivos registos ------------------------------------

-- Episódio 1 — Max (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (1, 65, '2025-01-17 14:39');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (1, 1, 1, 1, 90, '2025-01-17 14:39', 'Sintomas: claudicação do membro posterior. Diagnóstico: gastroenterite aguda. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (1, 1, 1, '2025-01-17 14:45', 7.31, 37.7, 142, 39, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (2, 1, 7, 1, NULL, '2025-01-17 14:59', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (1, 2, 1, 'rx_1.jpg', 'image/jpeg', 5552107, '/anexos/2025/01/ato_2/rx_1.jpg', '2025-01-17 16:07', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (1, 1, 1, '2025-01-17 15:28', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (1, 11), (1, 12);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (1, 1, 11, 12, 3.049, '2025-01-17 18:36', '2025-01-17 19:07', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (2, 1, 12, 14, 148.6, '2025-01-17 18:44', '2025-01-17 18:47', NULL);
UPDATE episodio SET data_hora_fim = '2025-01-17 16:58' WHERE id_episodio = 1;

-- Episódio 2 — Bolinha (Réptil)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (2, 74, '2025-01-24 14:02');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (3, 2, 1, 4, 100, '2025-01-24 14:02', 'Sintomas: check-up anual. Diagnóstico: gastroenterite aguda. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (2, 2, 4, '2025-01-24 14:19', 2.26, 25.0, 20, 24, 'Dor à palpação abdominal');
UPDATE episodio SET data_hora_fim = '2025-01-24 14:58' WHERE id_episodio = 2;

-- Episódio 3 — Matilde (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (3, 63, '2025-02-03 14:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (4, 3, 1, 19, 85, '2025-02-03 14:07', 'Sintomas: dificuldade respiratória. Diagnóstico: animal saudável. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (3, 3, 19, '2025-02-03 14:13', 7.81, 39.2, 198, 40, 'Mucosas rosadas, TRC < 2 s');
UPDATE episodio SET data_hora_fim = '2025-02-03 15:28' WHERE id_episodio = 3;

-- Episódio 4 — Bobi (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (4, 49, '2025-02-13 10:32');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (5, 4, 1, 1, 68, '2025-02-13 10:32', 'Sintomas: otite com corrimento. Diagnóstico: dermatite alérgica. Plano: internamento para fluidoterapia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (4, 4, 1, '2025-02-13 10:43', 5.54, 39.6, 220, NULL, 'Sem alterações');
UPDATE episodio SET data_hora_fim = '2025-02-13 11:33' WHERE id_episodio = 4;

-- Episódio 5 — Leo (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (5, 69, '2025-02-19 11:03');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (6, 5, 1, 2, 94, '2025-02-19 11:03', 'Sintomas: diarreia. Diagnóstico: laceração cutânea. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (5, 5, 2, '2025-02-19 11:08', 2.86, 38.2, 67, NULL, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (7, 5, 8, 2, NULL, '2025-02-19 11:29', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (2, 7, 2, 'relatorio_eco_2.pdf', 'application/pdf', 876880, '/anexos/2025/02/ato_7/relatorio_eco_2.pdf', '2025-02-19 12:45', 'Imagem do exame');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (8, 5, 5, 8, NULL, '2025-02-19 12:08', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (2, 5, 2, '2025-02-19 12:25', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (2, 2), (2, 3), (2, 14);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (3, 2, 2, 14, 88.5, '2025-02-19 13:33', '2025-02-19 14:42', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (4, 2, 3, 12, 2.468, '2025-02-19 13:05', '2025-02-19 13:16', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (5, 2, 14, 13, 4.3, '2025-02-19 14:54', '2025-02-19 16:43', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2025-02-19 13:01' WHERE id_episodio = 5;

-- Episódio 6 — Zeus (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (6, 4, '2025-02-20 12:44');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (9, 6, 1, 1, NULL, '2025-02-20 12:44', 'Sintomas: ingestão de corpo estranho. Diagnóstico: doença renal crónica. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (6, 6, 1, '2025-02-20 12:50', 5.79, 39.2, 217, 23, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (10, 6, 8, 1, NULL, '2025-02-20 13:04', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (3, 10, 1, 'eco_3.jpg', 'image/jpeg', 2526337, '/anexos/2025/02/ato_10/eco_3.jpg', '2025-02-20 14:01', 'Imagem do exame');
UPDATE episodio SET data_hora_fim = '2025-02-20 13:24' WHERE id_episodio = 6;

-- Episódio 7 — Bela (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (7, 25, '2025-02-27 14:00');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (11, 7, 1, 2, 34, '2025-02-27 14:00', 'Sintomas: vacinação de rotina. Diagnóstico: diabetes mellitus. Plano: limpeza auricular diária.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (4, 11, 2, 'foto_lesao_4.jpg', 'image/jpeg', 1718191, '/anexos/2025/02/ato_11/foto_lesao_4.jpg', '2025-02-27 14:56', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (7, 7, 2, '2025-02-27 14:13', 4.9, 39.1, 106, 18, 'Come com apetite');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (1, 7, '2025-02-27 14:23');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (8, 7, 10, '2025-02-27 20:23', NULL, 38.5, 117, 27, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (9, 7, 11, '2025-02-28 10:23', NULL, 38.2, 81, 22, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (12, 7, 11, 11, NULL, '2025-02-28 10:33', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (10, 7, 20, '2025-03-01 05:23', NULL, 38.7, 104, 26, 'Animal alerta e responsivo');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (11, 7, 10, '2025-03-02 02:23', NULL, 39.6, 120, 14, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (13, 7, 11, 10, NULL, '2025-03-02 02:33', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (12, 7, 9, '2025-03-03 01:23', 6.28, 38.5, 86, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (14, 7, 5, 9, NULL, '2025-03-03 01:33', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (13, 7, 7, '2025-03-03 13:23', NULL, 39.3, 124, 18, 'Ligeira desidratação');
UPDATE internamento SET data_hora_fim = '2025-03-03 23:23' WHERE id_internamento = 1;
UPDATE episodio SET data_hora_fim = '2025-03-03 23:39' WHERE id_episodio = 7;

-- Episódio 8 — Sombra (Furão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (8, 19, '2025-03-03 16:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (15, 8, 1, 3, NULL, '2025-03-03 16:38', 'Sintomas: check-up anual. Diagnóstico: conjuntivite bacteriana. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (14, 8, 3, '2025-03-03 16:51', 1.01, 39.8, 192, 35, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (16, 8, 6, 20, NULL, '2025-03-03 17:21', NULL);
UPDATE episodio SET data_hora_fim = '2025-03-03 17:39' WHERE id_episodio = 8;

-- Episódio 9 — Zeus (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (9, 64, '2025-03-11 10:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (17, 9, 1, 1, 87, '2025-03-11 10:07', 'Sintomas: ingestão de corpo estranho. Diagnóstico: dermatite alérgica. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (15, 9, 1, '2025-03-11 10:20', 15.83, 39.9, 98, 10, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (18, 9, 7, 1, NULL, '2025-03-11 10:49', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (5, 18, 1, 'rx_5.jpg', 'image/jpeg', 1142622, '/anexos/2025/03/ato_18/rx_5.jpg', '2025-03-11 10:55', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (3, 9, 1, '2025-03-11 10:59', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (3, 1), (3, 2), (3, 3);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (6, 3, 1, 14, 118.7, '2025-03-11 12:43', '2025-03-11 13:54', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (7, 3, 2, 14, 39.3, '2025-03-11 11:36', '2025-03-11 12:40', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (8, 3, 3, 12, 2.612, '2025-03-11 12:55', '2025-03-11 13:13', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (2, 9, '2025-03-11 11:24');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (16, 9, 8, '2025-03-11 16:24', 8.19, 37.1, 122, 13, 'Ligeira desidratação');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (17, 9, 8, '2025-03-12 06:24', NULL, 38.9, 121, 15, 'Come com apetite');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (18, 9, 11, '2025-03-13 03:24', 8.97, 38.1, 122, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (19, 9, 4, 11, NULL, '2025-03-13 03:34', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (19, 9, 11, '2025-03-14 00:24', NULL, 38.7, 66, 19, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (20, 9, 5, 11, NULL, '2025-03-14 00:34', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (20, 9, 7, '2025-03-14 13:24', NULL, 37.2, 97, 18, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (21, 9, 4, 7, NULL, '2025-03-14 13:34', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (6, 21, 7, 'foto_ferida_6.jpg', 'image/jpeg', 2163112, '/anexos/2025/03/ato_21/foto_ferida_6.jpg', '2025-03-14 14:10', 'Penso — Zeus');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (21, 9, 7, '2025-03-15 08:24', NULL, 37.1, 99, NULL, 'Animal alerta e responsivo');
UPDATE internamento SET data_hora_fim = '2025-03-15 17:24' WHERE id_internamento = 2;
UPDATE episodio SET data_hora_fim = '2025-03-15 18:14' WHERE id_episodio = 9;

-- Episódio 10 — Pintas (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (10, 5, '2025-03-24 11:40');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (22, 10, 1, 4, 10, '2025-03-24 11:40', 'Sintomas: conjuntivite. Diagnóstico: conjuntivite bacteriana. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (22, 10, 4, '2025-03-24 11:53', 42.42, 38.9, 138, 26, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (23, 10, 5, 9, NULL, '2025-03-24 12:14', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (24, 10, 10, 4, NULL, '2025-03-24 12:49', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (3, 10, '2025-03-24 13:01');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (25, 10, 9, 4, NULL, '2025-03-24 14:01', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (7, 25, 4, 'foto_pos_op_7.jpg', 'image/jpeg', 4241659, '/anexos/2025/03/ato_25/foto_pos_op_7.jpg', '2025-03-24 15:14', 'Cirurgia — Pintas');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (23, 10, 8, '2025-03-24 18:01', NULL, 38.8, 74, 18, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (26, 10, 5, 8, NULL, '2025-03-24 18:11', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (24, 10, 8, '2025-03-25 18:01', NULL, 38.5, 87, NULL, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (27, 10, 4, 8, NULL, '2025-03-25 18:11', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (25, 10, 7, '2025-03-26 17:01', NULL, 39.6, 97, 20, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (26, 10, 8, '2025-03-27 11:01', 39.79, 39.0, 88, 21, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (27, 10, 7, '2025-03-28 00:01', NULL, 37.1, 132, 15, 'Animal alerta e responsivo');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (28, 10, 8, '2025-03-28 17:01', NULL, 39.8, 65, 27, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (29, 10, 20, '2025-03-29 15:01', 29.46, 38.8, 103, 23, 'Animal alerta e responsivo');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (30, 10, 11, '2025-03-30 11:01', NULL, 37.3, 71, 21, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (28, 10, 11, 11, NULL, '2025-03-30 11:11', NULL);
UPDATE internamento SET data_hora_fim = '2025-03-30 20:01' WHERE id_internamento = 3;
UPDATE episodio SET data_hora_fim = '2025-03-30 20:47' WHERE id_episodio = 10;

-- Episódio 11 — Simba (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (11, 52, '2025-03-24 12:09');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (29, 11, 1, 2, 70, '2025-03-24 12:09', 'Sintomas: vacinação de rotina. Diagnóstico: laceração cutânea. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (31, 11, 2, '2025-03-24 12:23', 1.9, 38.8, 280, 30, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (30, 11, 6, 7, NULL, '2025-03-24 12:44', NULL);
UPDATE episodio SET data_hora_fim = '2025-03-24 13:33' WHERE id_episodio = 11;

-- Episódio 12 — Lola (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (12, 47, '2025-04-02 11:34');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (31, 12, 1, 19, 67, '2025-04-02 11:34', 'Sintomas: dificuldade respiratória. Diagnóstico: laceração cutânea. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (32, 12, 19, '2025-04-02 11:41', 18.8, 38.9, 127, NULL, 'Dor à palpação abdominal');
UPDATE episodio SET data_hora_fim = '2025-04-02 13:07' WHERE id_episodio = 12;

-- Episódio 13 — Sombra (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (13, 29, '2025-04-02 12:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (32, 13, 1, 3, 40, '2025-04-02 12:05', 'Sintomas: perda de peso. Diagnóstico: laceração cutânea. Plano: internamento para fluidoterapia.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (8, 32, 3, 'foto_lesao_8.jpg', 'image/jpeg', 2702138, '/anexos/2025/04/ato_32/foto_lesao_8.jpg', '2025-04-02 12:19', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (33, 13, 3, '2025-04-02 12:11', 14.88, 38.5, 117, 16, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (33, 13, 6, 9, NULL, '2025-04-02 12:25', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (34, 13, 8, 3, NULL, '2025-04-02 12:35', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (9, 34, 3, 'relatorio_eco_9.pdf', 'application/pdf', 734058, '/anexos/2025/04/ato_34/relatorio_eco_9.pdf', '2025-04-02 13:44', 'Entregue pelo cliente');
UPDATE episodio SET data_hora_fim = '2025-04-02 12:55' WHERE id_episodio = 13;

-- Episódio 14 — Zeus (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (14, 64, '2025-04-07 10:06');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (35, 14, 1, 3, 88, '2025-04-07 10:06', 'Sintomas: conjuntivite. Diagnóstico: hipertiroidismo. Plano: internamento para fluidoterapia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (34, 14, 3, '2025-04-07 10:12', 32.11, 39.7, 118, NULL, 'Ligeira desidratação');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (4, 14, 3, '2025-04-07 10:24', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (4, 1);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (9, 4, 1, 13, 104.1, '2025-04-07 13:02', '2025-04-07 13:09', NULL);
UPDATE episodio SET data_hora_fim = '2025-04-07 10:51' WHERE id_episodio = 14;

-- Episódio 15 — Chico (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (15, 14, '2025-04-07 15:36');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (36, 15, 1, 19, 19, '2025-04-07 15:36', 'Sintomas: claudicação do membro posterior. Diagnóstico: traqueobronquite. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (35, 15, 19, '2025-04-07 15:44', 3.09, 37.7, 212, 37, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (37, 15, 2, 7, NULL, '2025-04-07 16:08', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (5, 15, 19, '2025-04-07 16:31', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (5, 1), (5, 2), (5, 3);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (10, 5, 1, 12, 129.8, '2025-04-07 18:43', '2025-04-07 18:49', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (11, 5, 2, 13, 51.3, '2025-04-07 16:55', '2025-04-07 17:18', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (12, 5, 3, 13, 1.094, '2025-04-07 18:44', '2025-04-07 19:04', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (4, 15, '2025-04-07 17:04');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (36, 15, 11, '2025-04-07 19:04', 3.47, 39.3, 147, 37, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (37, 15, 7, '2025-04-08 15:04', NULL, 38.8, 209, 31, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (38, 15, 8, '2025-04-09 14:04', NULL, 38.5, 214, 33, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (39, 15, 11, '2025-04-10 06:04', 7.68, 38.5, 183, 38, 'Ligeira desidratação');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (40, 15, 7, '2025-04-10 22:04', NULL, 39.1, 201, NULL, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (41, 15, 7, '2025-04-11 10:04', NULL, 37.6, 197, 22, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (38, 15, 4, 7, NULL, '2025-04-11 10:14', NULL);
UPDATE internamento SET data_hora_fim = '2025-04-12 02:04' WHERE id_internamento = 4;
UPDATE episodio SET data_hora_fim = '2025-04-12 02:59' WHERE id_episodio = 15;

-- Episódio 16 — Luna (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (16, 24, '2025-04-10 17:33');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (39, 16, 1, 3, 32, '2025-04-10 17:33', 'Sintomas: prostração e falta de apetite. Diagnóstico: traqueobronquite. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (42, 16, 3, '2025-04-10 17:50', 36.84, 39.1, 131, 14, 'Come com apetite');
UPDATE episodio SET data_hora_fim = '2025-04-10 18:43' WHERE id_episodio = 16;

-- Episódio 17 — Canela (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (17, 17, '2025-04-16 17:36');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (40, 17, 1, 6, 25, '2025-04-16 17:36', 'Sintomas: check-up anual. Diagnóstico: artrose. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (43, 17, 6, '2025-04-16 17:42', 2.74, 38.4, 178, 28, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (41, 17, 6, 6, NULL, '2025-04-16 17:59', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (5, 17, '2025-04-16 18:19');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (44, 17, 7, '2025-04-16 20:19', 7.65, 38.4, 181, 30, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (42, 17, 11, 7, NULL, '2025-04-16 20:29', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (45, 17, 7, '2025-04-17 17:19', 4.49, 39.1, 218, 37, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (43, 17, 4, 7, NULL, '2025-04-17 17:29', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (46, 17, 11, '2025-04-18 11:19', NULL, 38.0, 154, 26, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (44, 17, 5, 11, NULL, '2025-04-18 11:29', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (47, 17, 11, '2025-04-19 05:19', 3.99, 37.6, 178, 21, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (45, 17, 11, 11, NULL, '2025-04-19 05:29', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (48, 17, 8, '2025-04-19 21:19', 3.0, 38.3, 213, 31, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (46, 17, 11, 8, NULL, '2025-04-19 21:29', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (49, 17, 20, '2025-04-20 10:19', NULL, 39.2, 194, NULL, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (47, 17, 11, 20, NULL, '2025-04-20 10:29', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (50, 17, 9, '2025-04-21 10:19', NULL, 38.3, 193, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (48, 17, 11, 9, NULL, '2025-04-21 10:29', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (51, 17, 9, '2025-04-22 03:19', 5.53, 38.3, 220, 40, NULL);
UPDATE internamento SET data_hora_fim = '2025-04-22 22:19' WHERE id_internamento = 5;
UPDATE episodio SET data_hora_fim = '2025-04-22 22:56' WHERE id_episodio = 17;

-- Episódio 18 — Nina (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (18, 66, '2025-04-24 13:01');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (49, 18, 1, 1, 91, '2025-04-24 13:01', 'Sintomas: ingestão de corpo estranho. Diagnóstico: hipertiroidismo. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (10, 49, 1, 'foto_lesao_10.jpg', 'image/jpeg', 5506887, '/anexos/2025/04/ato_49/foto_lesao_10.jpg', '2025-04-24 13:15', 'Consulta — Nina');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (11, 49, 1, 'relatorio_consulta_11.pdf', 'application/pdf', 531215, '/anexos/2025/04/ato_49/relatorio_consulta_11.pdf', '2025-04-24 14:05', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (52, 18, 1, '2025-04-24 13:07', 1.99, 40.5, 179, NULL, 'Sem alterações');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (6, 18, 1, '2025-04-24 13:18', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (6, 9), (6, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (13, 6, 9, 14, 6.904, '2025-04-24 14:23', '2025-04-24 14:32', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (14, 6, 10, 13, 3.961, '2025-04-24 16:22', '2025-04-24 16:37', NULL);
UPDATE episodio SET data_hora_fim = '2025-04-24 14:35' WHERE id_episodio = 18;

-- Episódio 19 — Faísca (Outro)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (19, 37, '2025-04-28 14:39');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (50, 19, 1, 5, 52, '2025-04-28 14:39', 'Sintomas: check-up anual. Diagnóstico: hipertiroidismo. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (53, 19, 5, '2025-04-28 14:59', 19.28, 39.1, 85, 46, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (51, 19, 3, 20, NULL, '2025-04-28 15:35', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (7, 19, 5, '2025-04-28 16:05', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (7, 6), (7, 7), (7, 8), (7, 9);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (15, 7, 6, 12, 42.5, '2025-04-28 19:31', '2025-04-28 20:16', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (16, 7, 7, 12, 8.4, '2025-04-28 17:06', '2025-04-28 18:17', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (17, 7, 8, 13, 200.2, '2025-04-28 17:13', '2025-04-28 18:37', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (18, 7, 9, 14, 8.529, '2025-04-28 17:58', '2025-04-28 18:10', 'Repetido para confirmação');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (6, 19, '2025-04-28 16:39');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (52, 19, 9, 5, NULL, '2025-04-28 17:39', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (12, 52, 5, 'foto_pos_op_12.jpg', 'image/jpeg', 5928767, '/anexos/2025/04/ato_52/foto_pos_op_12.jpg', '2025-04-28 18:26', 'Entregue pelo cliente');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (13, 52, 5, 'relatorio_cirurgico_13.pdf', 'application/pdf', 709129, '/anexos/2025/04/ato_52/relatorio_cirurgico_13.pdf', '2025-04-28 18:54', 'Cirurgia — Faísca');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (14, 52, 5, 'foto_pos_op_14.jpg', 'image/jpeg', 7935466, '/anexos/2025/04/ato_52/foto_pos_op_14.jpg', '2025-04-28 18:32', 'Cirurgia — Faísca');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (54, 19, 7, '2025-04-28 22:39', 37.28, 35.3, 163, 34, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (53, 19, 11, 7, NULL, '2025-04-28 22:49', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (55, 19, 10, '2025-04-29 19:39', NULL, 38.4, 122, NULL, 'Come com apetite');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (56, 19, 20, '2025-04-30 09:39', NULL, 38.2, 154, 31, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (57, 19, 9, '2025-05-01 06:39', NULL, 36.5, 119, NULL, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (58, 19, 8, '2025-05-02 01:39', NULL, 35.6, 185, 23, 'Ligeira desidratação');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (59, 19, 11, '2025-05-02 15:39', 10.14, 38.3, 196, 22, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (54, 19, 11, 11, NULL, '2025-05-02 15:49', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (60, 19, 20, '2025-05-03 04:39', 0.98, 37.8, 112, NULL, 'Animal alerta e responsivo');
UPDATE internamento SET data_hora_fim = '2025-05-03 09:39' WHERE id_internamento = 6;
UPDATE episodio SET data_hora_fim = '2025-05-03 10:34' WHERE id_episodio = 19;

-- Episódio 20 — Nala (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (20, 44, '2025-05-05 17:01');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (55, 20, 1, 6, 60, '2025-05-05 17:01', 'Sintomas: prostração e falta de apetite. Diagnóstico: traqueobronquite. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (61, 20, 6, '2025-05-05 17:10', 24.13, 38.9, 105, 22, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (56, 20, 8, 6, NULL, '2025-05-05 17:44', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (15, 56, 6, 'relatorio_eco_15.pdf', 'application/pdf', 504791, '/anexos/2025/05/ato_56/relatorio_eco_15.pdf', '2025-05-05 18:58', 'Imagem do exame');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (57, 20, 6, 7, NULL, '2025-05-05 18:07', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (8, 20, 6, '2025-05-05 18:24', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (8, 11), (8, 12), (8, 13);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (19, 8, 11, 12, 5.476, '2025-05-05 19:00', '2025-05-05 20:33', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (20, 8, 12, 12, 141.6, '2025-05-05 22:22', '2025-05-05 22:31', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (21, 8, 13, 12, 5.618, '2025-05-05 20:58', '2025-05-05 22:39', NULL);
UPDATE episodio SET data_hora_fim = '2025-05-05 19:19' WHERE id_episodio = 20;

-- Episódio 21 — Zeus (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (21, 71, '2025-05-26 12:34');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (58, 21, 1, 3, 95, '2025-05-26 12:34', 'Sintomas: prurido intenso. Diagnóstico: doença renal crónica. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (62, 21, 3, '2025-05-26 12:51', 4.83, 38.1, 218, 22, 'Dor à palpação abdominal');
UPDATE episodio SET data_hora_fim = '2025-05-26 13:19' WHERE id_episodio = 21;

-- Episódio 22 — Zeus (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (22, 36, '2025-06-02 09:31');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (59, 22, 1, 1, 51, '2025-06-02 09:31', 'Sintomas: ferida na pata. Diagnóstico: conjuntivite bacteriana. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (63, 22, 1, '2025-06-02 09:41', 3.67, 39.4, 196, NULL, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (60, 22, 8, 1, NULL, '2025-06-02 10:18', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (16, 60, 1, 'relatorio_eco_16.pdf', 'application/pdf', 691938, '/anexos/2025/06/ato_60/relatorio_eco_16.pdf', '2025-06-02 10:54', 'Entregue pelo cliente');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (61, 22, 10, 1, NULL, '2025-06-02 10:28', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (7, 22, '2025-06-02 10:43');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (64, 22, 10, '2025-06-02 12:43', NULL, 37.7, 166, NULL, 'Animal alerta e responsivo');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (65, 22, 7, '2025-06-03 04:43', NULL, 38.6, 145, 36, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (62, 22, 4, 7, NULL, '2025-06-03 04:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (66, 22, 8, '2025-06-04 01:43', NULL, 39.0, 198, NULL, 'Come com apetite');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (67, 22, 11, '2025-06-04 19:43', 2.68, 39.3, 177, NULL, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (63, 22, 4, 11, NULL, '2025-06-04 19:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (68, 22, 10, '2025-06-05 08:43', NULL, 40.1, 175, 32, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (69, 22, 7, '2025-06-06 07:43', NULL, 37.9, 150, 33, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (64, 22, 4, 7, NULL, '2025-06-06 07:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (70, 22, 10, '2025-06-07 01:43', NULL, 38.2, 143, 23, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (65, 22, 5, 10, NULL, '2025-06-07 01:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (71, 22, 20, '2025-06-07 16:43', 6.89, 39.7, 191, 40, NULL);
UPDATE internamento SET data_hora_fim = '2025-06-08 04:43' WHERE id_internamento = 7;
UPDATE episodio SET data_hora_fim = '2025-06-08 05:02' WHERE id_episodio = 22;

-- Episódio 23 — Simba (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (23, 52, '2025-06-09 12:10');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (66, 23, 1, 2, 71, '2025-06-09 12:10', 'Sintomas: dor abdominal. Diagnóstico: doença renal crónica. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (72, 23, 2, '2025-06-09 12:15', 2.44, 38.8, 229, 59, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (67, 23, 8, 2, NULL, '2025-06-09 12:46', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (17, 67, 2, 'eco_17.jpg', 'image/jpeg', 6818300, '/anexos/2025/06/ato_67/eco_17.jpg', '2025-06-09 14:09', 'Ecografia — Simba');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (68, 23, 4, 2, NULL, '2025-06-09 13:15', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (9, 23, 2, '2025-06-09 13:36', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (9, 1), (9, 2), (9, 3), (9, 11), (9, 12);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (22, 9, 1, 12, 81.5, '2025-06-09 14:55', '2025-06-09 15:20', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (23, 9, 2, 13, 27.8, '2025-06-09 15:59', '2025-06-09 16:54', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (24, 9, 3, 13, 0.954, '2025-06-09 17:14', '2025-06-09 18:15', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (25, 9, 11, 13, 4.734, '2025-06-09 16:28', '2025-06-09 17:57', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (26, 9, 12, 14, 147.2, '2025-06-09 15:06', '2025-06-09 16:52', NULL);
UPDATE episodio SET data_hora_fim = '2025-06-09 14:34' WHERE id_episodio = 23;

-- Episódio 24 — Baltasar (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (24, 41, '2025-06-13 13:00');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (69, 24, 1, 19, 55, '2025-06-13 13:00', 'Sintomas: vacinação de rotina. Diagnóstico: animal saudável. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (73, 24, 19, '2025-06-13 13:19', 37.35, 38.1, 83, 25, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (70, 24, 8, 19, NULL, '2025-06-13 13:55', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (71, 24, 5, 20, NULL, '2025-06-13 14:11', NULL);
UPDATE episodio SET data_hora_fim = '2025-06-13 14:50' WHERE id_episodio = 24;

-- Episódio 25 — Rocky (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (25, 7, '2025-06-16 14:31');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (72, 25, 1, 3, 13, '2025-06-16 14:31', 'Sintomas: perda de peso. Diagnóstico: gastroenterite aguda. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (74, 25, 3, '2025-06-16 14:44', 15.03, 39.1, 134, 13, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (73, 25, 2, 20, NULL, '2025-06-16 14:57', NULL);
UPDATE episodio SET data_hora_fim = '2025-06-16 15:42' WHERE id_episodio = 25;

-- Episódio 26 — Max (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (26, 78, '2025-07-03 09:10');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (74, 26, 1, 19, 107, '2025-07-03 09:10', 'Sintomas: prostração e falta de apetite. Diagnóstico: lipoma. Plano: internamento para fluidoterapia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (75, 26, 19, '2025-07-03 09:28', 6.51, 38.2, 198, 20, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (75, 26, 6, 7, NULL, '2025-07-03 10:08', NULL);
UPDATE episodio SET data_hora_fim = '2025-07-03 11:04' WHERE id_episodio = 26;

-- Episódio 27 — Becas (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (27, 27, '2025-07-07 10:34');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (76, 27, 1, 1, 37, '2025-07-07 10:34', 'Sintomas: ferida na pata. Diagnóstico: diabetes mellitus. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (76, 27, 1, '2025-07-07 10:48', 5.03, 39.3, 158, NULL, 'Sem alterações');
UPDATE episodio SET data_hora_fim = '2025-07-07 12:14' WHERE id_episodio = 27;

-- Episódio 28 — Pirata (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (28, 57, '2025-07-07 15:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (77, 28, 1, 3, 76, '2025-07-07 15:07', 'Sintomas: massa subcutânea. Diagnóstico: doença renal crónica. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (77, 28, 3, '2025-07-07 15:15', 4.05, 38.3, 185, NULL, 'Ligeira desidratação');
UPDATE episodio SET data_hora_fim = '2025-07-07 15:49' WHERE id_episodio = 28;

-- Episódio 29 — Zeus (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (29, 71, '2025-07-08 09:04');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (78, 29, 1, 6, 96, '2025-07-08 09:04', 'Sintomas: dor abdominal. Diagnóstico: lipoma. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (18, 78, 6, 'relatorio_consulta_18.pdf', 'application/pdf', 417800, '/anexos/2025/07/ato_78/relatorio_consulta_18.pdf', '2025-07-08 09:07', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (78, 29, 6, '2025-07-08 09:24', 4.42, 38.6, 174, NULL, 'Mucosas rosadas, TRC < 2 s');
UPDATE episodio SET data_hora_fim = '2025-07-08 09:53' WHERE id_episodio = 29;

-- Episódio 30 — Jade (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (30, 22, '2025-07-08 19:44');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (79, 30, 1, 1, NULL, '2025-07-08 19:44', 'Sintomas: dificuldade respiratória. Diagnóstico: gastroenterite aguda. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (19, 79, 1, 'foto_lesao_19.jpg', 'image/jpeg', 898671, '/anexos/2025/07/ato_79/foto_lesao_19.jpg', '2025-07-08 20:04', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (79, 30, 1, '2025-07-08 19:57', 5.77, 38.9, 209, 27, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (80, 30, 4, 1, NULL, '2025-07-08 20:13', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (10, 30, 1, '2025-07-08 20:26', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (10, 6), (10, 7), (10, 8), (10, 9);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (27, 10, 6, 14, 68.8, '2025-07-08 21:13', '2025-07-08 23:08', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (28, 10, 7, 14, 8.5, '2025-07-09 00:24', '2025-07-09 00:55', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (29, 10, 8, 13, 291.5, '2025-07-08 23:20', '2025-07-09 01:13', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (30, 10, 9, 14, 5.628, '2025-07-09 00:06', '2025-07-09 01:37', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2025-07-08 20:58' WHERE id_episodio = 30;

-- Episódio 31 — Bolinha (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (31, 43, '2025-07-21 17:35');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (81, 31, 1, 5, 57, '2025-07-21 17:35', 'Sintomas: ferida na pata. Diagnóstico: diabetes mellitus. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (80, 31, 5, '2025-07-21 17:45', 5.74, 39.4, 207, 29, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (82, 31, 5, 8, NULL, '2025-07-21 18:20', NULL);
UPDATE episodio SET data_hora_fim = '2025-07-21 19:19' WHERE id_episodio = 31;

-- Episódio 32 — Estrela (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (32, 34, '2025-07-28 13:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (83, 32, 1, 19, 48, '2025-07-28 13:07', 'Sintomas: dor abdominal. Diagnóstico: otite externa. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (81, 32, 19, '2025-07-28 13:24', 4.38, 40.2, 217, 36, 'Dor à palpação abdominal');
UPDATE episodio SET data_hora_fim = '2025-07-28 14:10' WHERE id_episodio = 32;

-- Episódio 33 — Farrusco (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (33, 21, '2025-07-28 13:52');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (84, 33, 1, 6, NULL, '2025-07-28 13:52', 'Sintomas: prurido intenso. Diagnóstico: gastroenterite aguda. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (82, 33, 6, '2025-07-28 13:58', 41.85, 37.3, 118, 25, 'Dor à palpação abdominal');
UPDATE episodio SET data_hora_fim = '2025-07-28 14:31' WHERE id_episodio = 33;

-- Episódio 34 — Pirata (Outro)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (34, 11, '2025-07-30 19:26');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (85, 34, 1, 6, NULL, '2025-07-30 19:26', 'Sintomas: massa subcutânea. Diagnóstico: doença renal crónica. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (83, 34, 6, '2025-07-30 19:32', 18.01, 37.5, 181, 38, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (86, 34, 5, 6, NULL, '2025-07-30 20:03', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (11, 34, 6, '2025-07-30 20:15', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (11, 1), (11, 2), (11, 3);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (31, 11, 1, 14, 158.2, '2025-07-30 22:28', '2025-07-30 23:05', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (32, 11, 2, 12, 86.9, '2025-07-30 22:32', '2025-07-30 23:05', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (33, 11, 3, 12, 0.278, '2025-07-30 22:28', '2025-07-30 23:54', NULL);
UPDATE episodio SET data_hora_fim = '2025-07-30 21:44' WHERE id_episodio = 34;

-- Episódio 35 — Bobi (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (35, 49, '2025-08-04 11:06');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (87, 35, 1, 4, 69, '2025-08-04 11:06', 'Sintomas: dificuldade respiratória. Diagnóstico: animal saudável. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (84, 35, 4, '2025-08-04 11:25', 3.85, 39.6, 156, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (88, 35, 7, 4, NULL, '2025-08-04 11:57', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (20, 88, 4, 'relatorio_rx_20.pdf', 'application/pdf', 260367, '/anexos/2025/08/ato_88/relatorio_rx_20.pdf', '2025-08-04 13:26', 'Imagem do exame');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (8, 35, '2025-08-04 12:25');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (85, 35, 9, '2025-08-04 14:25', NULL, 37.9, 169, 38, 'Ligeira desidratação');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (86, 35, 20, '2025-08-05 04:25', NULL, 38.7, 155, NULL, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (89, 35, 4, 20, NULL, '2025-08-05 04:35', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (87, 35, 10, '2025-08-05 17:25', NULL, 37.8, 189, NULL, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (90, 35, 4, 10, NULL, '2025-08-05 17:35', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (88, 35, 7, '2025-08-06 09:25', NULL, 38.7, 161, 23, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (91, 35, 5, 7, NULL, '2025-08-06 09:35', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (89, 35, 11, '2025-08-07 05:25', NULL, 38.8, 194, 24, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (92, 35, 11, 11, NULL, '2025-08-07 05:35', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (90, 35, 10, '2025-08-08 03:25', NULL, 39.5, 144, 34, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (91, 35, 11, '2025-08-08 18:25', 5.66, 39.3, 188, NULL, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (92, 35, 10, '2025-08-09 07:25', NULL, 38.5, 154, NULL, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (93, 35, 7, '2025-08-10 03:25', NULL, 38.6, 211, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (93, 35, 5, 7, NULL, '2025-08-10 03:35', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (94, 35, 20, '2025-08-10 19:25', NULL, 40.3, 184, 21, NULL);
UPDATE internamento SET data_hora_fim = '2025-08-11 09:25' WHERE id_internamento = 8;
UPDATE episodio SET data_hora_fim = '2025-08-11 10:24' WHERE id_episodio = 35;

-- Episódio 36 — Farrusco (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (36, 53, '2025-08-05 16:00');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (94, 36, 1, 2, 72, '2025-08-05 16:00', 'Sintomas: check-up anual. Diagnóstico: dermatite alérgica. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (21, 94, 2, 'documento_cliente_21.pdf', 'application/pdf', 213593, '/anexos/2025/08/ato_94/documento_cliente_21.pdf', '2025-08-05 16:16', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (95, 36, 2, '2025-08-05 16:11', 2.75, 38.8, 140, 39, 'Ligeira desidratação');
UPDATE episodio SET data_hora_fim = '2025-08-05 17:27' WHERE id_episodio = 36;

-- Episódio 37 — Bela (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (37, 51, '2025-08-11 14:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (95, 37, 1, 6, NULL, '2025-08-11 14:38', 'Sintomas: prurido intenso. Diagnóstico: hipertiroidismo. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (96, 37, 6, '2025-08-11 14:53', 3.69, 40.1, 77, 26, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (96, 37, 6, 6, NULL, '2025-08-11 15:26', NULL);
UPDATE episodio SET data_hora_fim = '2025-08-11 16:09' WHERE id_episodio = 37;

-- Episódio 38 — Canela (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (38, 6, '2025-08-12 09:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (97, 38, 1, 19, 11, '2025-08-12 09:05', 'Sintomas: claudicação do membro posterior. Diagnóstico: traqueobronquite. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (97, 38, 19, '2025-08-12 09:10', 17.76, 38.4, 107, 15, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (98, 38, 6, 19, NULL, '2025-08-12 09:45', NULL);
UPDATE episodio SET data_hora_fim = '2025-08-12 10:58' WHERE id_episodio = 38;

-- Episódio 39 — Jade (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (39, 22, '2025-08-13 17:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (99, 39, 1, 6, NULL, '2025-08-13 17:38', 'Sintomas: conjuntivite. Diagnóstico: artrose. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (98, 39, 6, '2025-08-13 17:50', 7.96, 40.3, 167, 25, NULL);
UPDATE episodio SET data_hora_fim = '2025-08-13 18:19' WHERE id_episodio = 39;

-- Episódio 40 — Fofinho (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (40, 48, '2025-08-18 11:26');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (100, 40, 1, 6, NULL, '2025-08-18 11:26', 'Sintomas: ferida na pata. Diagnóstico: infeção urinária. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (99, 40, 6, '2025-08-18 11:41', 20.95, 38.4, 123, 14, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (101, 40, 4, 6, NULL, '2025-08-18 11:58', NULL);
UPDATE episodio SET data_hora_fim = '2025-08-18 13:12' WHERE id_episodio = 40;

-- Episódio 41 — Bolinha (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (41, 43, '2025-08-18 15:09');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (102, 41, 1, 3, 58, '2025-08-18 15:09', 'Sintomas: prostração e falta de apetite. Diagnóstico: gastroenterite aguda. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (100, 41, 3, '2025-08-18 15:23', 5.57, 39.4, 140, 37, 'Come com apetite');
UPDATE episodio SET data_hora_fim = '2025-08-18 15:47' WHERE id_episodio = 41;

-- Episódio 42 — Matilde (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (42, 63, '2025-08-21 14:02');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (103, 42, 1, 1, 86, '2025-08-21 14:02', 'Sintomas: otite com corrimento. Diagnóstico: dermatite alérgica. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (101, 42, 1, '2025-08-21 14:09', 5.31, 38.9, 180, 30, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (104, 42, 4, 1, NULL, '2025-08-21 14:32', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (105, 42, 5, 1, NULL, '2025-08-21 15:12', NULL);
UPDATE episodio SET data_hora_fim = '2025-08-21 16:21' WHERE id_episodio = 42;

-- Episódio 43 — Ruca (Ave)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (43, 79, '2025-08-28 09:37');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (106, 43, 1, 2, 108, '2025-08-28 09:37', 'Sintomas: ferida na pata. Diagnóstico: artrose. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (102, 43, 2, '2025-08-28 09:45', 0.34, 41.5, 443, 49, NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (12, 43, 2, '2025-08-28 10:06', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (12, 9), (12, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (34, 12, 9, 13, 8.979, '2025-08-28 12:41', '2025-08-28 14:36', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (35, 12, 10, 14, 4.744, '2025-08-28 12:38', '2025-08-28 13:30', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (9, 43, '2025-08-28 10:43');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (103, 43, 11, '2025-08-28 14:43', NULL, 39.7, 216, NULL, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (104, 43, 9, '2025-08-29 02:43', NULL, 42.9, 206, 58, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (105, 43, 9, '2025-08-30 01:43', 0.27, 42.4, 492, 55, 'Ligeira desidratação');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (106, 43, 10, '2025-08-30 21:43', NULL, 41.8, 296, 26, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (107, 43, 5, 10, NULL, '2025-08-30 21:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (107, 43, 20, '2025-08-31 09:43', NULL, 41.4, 375, 33, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (108, 43, 11, 20, NULL, '2025-08-31 09:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (108, 43, 7, '2025-09-01 09:43', NULL, 42.2, 282, 60, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (109, 43, 11, '2025-09-02 01:43', NULL, 39.5, 441, 34, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (109, 43, 11, 11, NULL, '2025-09-02 01:53', NULL);
UPDATE internamento SET data_hora_fim = '2025-09-03 00:43' WHERE id_internamento = 9;
UPDATE episodio SET data_hora_fim = '2025-09-03 01:00' WHERE id_episodio = 43;

-- Episódio 44 — Max (Ave)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (44, 73, '2025-09-02 10:32');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (110, 44, 1, 6, 97, '2025-09-02 10:32', 'Sintomas: dor abdominal. Diagnóstico: conjuntivite bacteriana. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (110, 44, 6, '2025-09-02 10:48', 0.47, 43.1, 262, NULL, 'Sem alterações');
UPDATE episodio SET data_hora_fim = '2025-09-02 11:31' WHERE id_episodio = 44;

-- Episódio 45 — Riscas (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (45, 3, '2025-09-22 09:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (111, 45, 1, 3, 7, '2025-09-22 09:05', 'Sintomas: massa subcutânea. Diagnóstico: gastroenterite aguda. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (111, 45, 3, '2025-09-22 09:21', 2.24, 37.7, 108, 12, 'Come com apetite');
UPDATE episodio SET data_hora_fim = '2025-09-22 10:09' WHERE id_episodio = 45;

-- Episódio 46 — Ruca (Ave)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (46, 79, '2025-09-26 14:52');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (112, 46, 1, 6, NULL, '2025-09-26 14:52', 'Sintomas: ingestão de corpo estranho. Diagnóstico: conjuntivite bacteriana. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (112, 46, 6, '2025-09-26 14:57', 0.34, 39.7, 260, 57, 'Sem alterações');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (13, 46, 6, '2025-09-26 15:19', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (13, 2), (13, 3), (13, 6), (13, 7), (13, 8), (13, 14);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (36, 13, 2, 13, 59.3, '2025-09-26 19:10', '2025-09-26 19:17', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (37, 13, 3, 14, 0.122, '2025-09-26 16:55', '2025-09-26 17:14', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (38, 13, 6, 14, 52.6, '2025-09-26 17:19', '2025-09-26 19:16', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (39, 13, 7, 14, 10.0, '2025-09-26 18:17', '2025-09-26 19:03', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (40, 13, 8, 12, 496.4, '2025-09-26 15:47', '2025-09-26 16:33', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (41, 13, 14, 14, 6.3, '2025-09-26 18:00', '2025-09-26 19:55', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (10, 46, '2025-09-26 15:43');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (113, 46, 8, '2025-09-26 18:43', NULL, 41.5, 423, 25, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (114, 46, 9, '2025-09-27 06:43', NULL, 39.2, 390, 28, 'Ligeira desidratação');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (115, 46, 9, '2025-09-28 05:43', NULL, 43.4, 453, 45, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (116, 46, 10, '2025-09-29 00:43', NULL, 42.5, 288, 56, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (113, 46, 5, 10, NULL, '2025-09-29 00:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (117, 46, 11, '2025-09-29 12:43', NULL, 39.3, 362, 27, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (114, 46, 4, 11, NULL, '2025-09-29 12:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (118, 46, 10, '2025-09-30 12:43', NULL, 40.4, 299, 37, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (115, 46, 4, 10, NULL, '2025-09-30 12:53', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (119, 46, 20, '2025-10-01 01:43', NULL, 40.0, 407, 34, 'Ligeira desidratação');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (120, 46, 8, '2025-10-01 21:43', NULL, 41.7, 344, 51, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (116, 46, 4, 8, NULL, '2025-10-01 21:53', NULL);
UPDATE internamento SET data_hora_fim = '2025-10-02 07:43' WHERE id_internamento = 10;
UPDATE episodio SET data_hora_fim = '2025-10-02 08:15' WHERE id_episodio = 46;

-- Episódio 47 — Kika (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (47, 32, '2025-09-29 09:09');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (117, 47, 1, 1, 46, '2025-09-29 09:09', 'Sintomas: polidipsia e poliúria. Diagnóstico: obstrução intestinal. Plano: limpeza auricular diária.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (22, 117, 1, 'relatorio_consulta_22.pdf', 'application/pdf', 594771, '/anexos/2025/09/ato_117/relatorio_consulta_22.pdf', '2025-09-29 09:58', 'Imagem do exame');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (23, 117, 1, 'relatorio_consulta_23.pdf', 'application/pdf', 236701, '/anexos/2025/09/ato_117/relatorio_consulta_23.pdf', '2025-09-29 10:19', 'Consulta — Kika');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (121, 47, 1, '2025-09-29 09:14', 23.59, 39.2, 63, 27, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (118, 47, 7, 1, NULL, '2025-09-29 09:24', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (24, 118, 1, 'relatorio_rx_24.pdf', 'application/pdf', 183215, '/anexos/2025/09/ato_118/relatorio_rx_24.pdf', '2025-09-29 10:49', 'Entregue pelo cliente');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (11, 47, '2025-09-29 10:00');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (122, 47, 10, '2025-09-29 16:00', NULL, 37.1, 93, 25, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (119, 47, 11, 10, NULL, '2025-09-29 16:10', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (123, 47, 7, '2025-09-30 08:00', 34.27, 40.0, 118, 30, 'Mucosas rosadas, TRC < 2 s');
UPDATE internamento SET data_hora_fim = '2025-10-01 00:00' WHERE id_internamento = 11;
UPDATE episodio SET data_hora_fim = '2025-10-01 00:14' WHERE id_episodio = 47;

-- Episódio 48 — Baltasar (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (48, 41, '2025-10-01 16:39');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (120, 48, 1, 6, 56, '2025-10-01 16:39', 'Sintomas: conjuntivite. Diagnóstico: conjuntivite bacteriana. Plano: internamento para fluidoterapia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (124, 48, 6, '2025-10-01 16:59', 21.53, 37.2, 61, 13, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (121, 48, 7, 6, NULL, '2025-10-01 17:36', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (25, 121, 6, 'rx_25.jpg', 'image/jpeg', 4342686, '/anexos/2025/10/ato_121/rx_25.jpg', '2025-10-01 18:22', 'Radiografia — Baltasar');
UPDATE episodio SET data_hora_fim = '2025-10-01 19:02' WHERE id_episodio = 48;

-- Episódio 49 — Bolinha (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (49, 42, '2025-10-02 16:52');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (122, 49, 1, 2, NULL, '2025-10-02 16:52', 'Sintomas: prurido intenso. Diagnóstico: otite externa. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (26, 122, 2, 'relatorio_consulta_26.pdf', 'application/pdf', 178989, '/anexos/2025/10/ato_122/relatorio_consulta_26.pdf', '2025-10-02 17:23', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (27, 122, 2, 'foto_lesao_27.jpg', 'image/jpeg', 6018360, '/anexos/2025/10/ato_122/foto_lesao_27.jpg', '2025-10-02 17:00', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (125, 49, 2, '2025-10-02 17:03', 6.94, 38.9, 212, 40, 'Sem alterações');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (12, 49, '2025-10-02 17:28');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (126, 49, 7, '2025-10-02 19:28', 3.72, 38.0, 195, 20, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (123, 49, 5, 7, NULL, '2025-10-02 19:38', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (127, 49, 7, '2025-10-03 11:28', NULL, 40.1, 213, NULL, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (124, 49, 11, 7, NULL, '2025-10-03 11:38', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (128, 49, 8, '2025-10-04 11:28', 3.06, 39.6, 176, 30, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (129, 49, 9, '2025-10-05 06:28', NULL, 39.4, 154, 36, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (125, 49, 4, 9, NULL, '2025-10-05 06:38', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (130, 49, 8, '2025-10-05 20:28', 5.92, 39.9, 170, NULL, 'Come com apetite');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (131, 49, 9, '2025-10-06 13:28', NULL, 37.6, 177, 28, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (132, 49, 20, '2025-10-07 11:28', NULL, 39.4, 156, 26, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (133, 49, 7, '2025-10-08 05:28', NULL, 38.0, 168, 36, 'Come com apetite');
UPDATE internamento SET data_hora_fim = '2025-10-08 12:28' WHERE id_internamento = 12;
UPDATE episodio SET data_hora_fim = '2025-10-08 13:00' WHERE id_episodio = 49;

-- Episódio 50 — Sombra (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (50, 29, '2025-10-08 11:01');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (126, 50, 1, 6, 41, '2025-10-08 11:01', 'Sintomas: ferida na pata. Diagnóstico: lipoma. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (28, 126, 6, 'documento_cliente_28.pdf', 'application/pdf', 813555, '/anexos/2025/10/ato_126/documento_cliente_28.pdf', '2025-10-08 12:15', 'Consulta — Sombra');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (134, 50, 6, '2025-10-08 11:21', 28.08, 40.2, 138, NULL, NULL);
UPDATE episodio SET data_hora_fim = '2025-10-08 11:53' WHERE id_episodio = 50;

-- Episódio 51 — Bolinha (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (51, 42, '2025-10-20 20:26');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (127, 51, 1, 2, NULL, '2025-10-20 20:26', 'Sintomas: ferida na pata. Diagnóstico: animal saudável. Plano: análises de controlo em 1 mês.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (29, 127, 2, 'foto_lesao_29.jpg', 'image/jpeg', 5678496, '/anexos/2025/10/ato_127/foto_lesao_29.jpg', '2025-10-20 21:27', 'Consulta — Bolinha');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (135, 51, 2, '2025-10-20 20:36', 5.31, 39.5, 199, 33, 'Animal alerta e responsivo');
UPDATE episodio SET data_hora_fim = '2025-10-20 21:41' WHERE id_episodio = 51;

-- Episódio 52 — Lola (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (52, 47, '2025-10-22 16:17');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (128, 52, 1, 3, NULL, '2025-10-22 16:17', 'Sintomas: dificuldade respiratória. Diagnóstico: doença renal crónica. Plano: cirurgia programada.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (30, 128, 3, 'documento_cliente_30.pdf', 'application/pdf', 888748, '/anexos/2025/10/ato_128/documento_cliente_30.pdf', '2025-10-22 16:57', 'Consulta — Lola');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (31, 128, 3, 'foto_lesao_31.jpg', 'image/jpeg', 2696981, '/anexos/2025/10/ato_128/foto_lesao_31.jpg', '2025-10-22 16:53', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (136, 52, 3, '2025-10-22 16:35', 10.09, 37.6, 110, 28, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (129, 52, 7, 3, NULL, '2025-10-22 17:13', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (32, 129, 3, 'rx_32.jpg', 'image/jpeg', 5594745, '/anexos/2025/10/ato_129/rx_32.jpg', '2025-10-22 17:30', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (130, 52, 7, 3, NULL, '2025-10-22 17:36', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (33, 130, 3, 'rx_33.png', 'image/png', 4847002, '/anexos/2025/10/ato_130/rx_33.png', '2025-10-22 18:11', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (34, 130, 3, 'rx_34.jpg', 'image/jpeg', 4498526, '/anexos/2025/10/ato_130/rx_34.jpg', '2025-10-22 18:41', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (14, 52, 3, '2025-10-22 18:04', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (14, 11), (14, 12);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (42, 14, 11, 12, 5.348, '2025-10-22 22:03', '2025-10-22 22:38', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (43, 14, 12, 14, 149.4, '2025-10-22 20:40', '2025-10-22 21:29', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2025-10-22 18:30' WHERE id_episodio = 52;

-- Episódio 53 — Luna (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (53, 68, '2025-11-05 08:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (131, 53, 1, 19, NULL, '2025-11-05 08:05', 'Sintomas: diarreia. Diagnóstico: animal saudável. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (137, 53, 19, '2025-11-05 08:13', 10.11, 39.0, 87, 25, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (15, 53, 19, '2025-11-05 08:32', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (15, 4), (15, 5);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (44, 15, 4, 12, 30.7, '2025-11-05 10:31', '2025-11-05 12:11', 'Repetido para confirmação');
UPDATE episodio SET data_hora_fim = '2025-11-05 09:54' WHERE id_episodio = 53;

-- Episódio 54 — Kiko (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (54, 23, '2025-11-06 14:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (132, 54, 1, 1, 30, '2025-11-06 14:07', 'Sintomas: perda de peso. Diagnóstico: lipoma. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (138, 54, 1, '2025-11-06 14:18', 25.5, 38.2, 66, NULL, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (133, 54, 7, 1, NULL, '2025-11-06 14:43', NULL);
UPDATE episodio SET data_hora_fim = '2025-11-06 15:04' WHERE id_episodio = 54;

-- Episódio 55 — Canela (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (55, 17, '2025-11-07 10:00');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (134, 55, 1, 6, 26, '2025-11-07 10:00', 'Sintomas: vómitos há 2 dias. Diagnóstico: otite externa. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (139, 55, 6, '2025-11-07 10:07', 6.5, 39.3, 151, 28, 'Dor à palpação abdominal');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (16, 55, 6, '2025-11-07 10:25', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (16, 9), (16, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (45, 16, 9, 12, 4.654, '2025-11-07 12:06', '2025-11-07 12:22', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (46, 16, 10, 14, 3.742, '2025-11-07 14:07', '2025-11-07 14:50', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2025-11-07 11:19' WHERE id_episodio = 55;

-- Episódio 56 — Chico (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (56, 8, '2025-11-10 13:34');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (135, 56, 1, 2, 15, '2025-11-10 13:34', 'Sintomas: prostração e falta de apetite. Diagnóstico: lipoma. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (35, 135, 2, 'documento_cliente_35.pdf', 'application/pdf', 764637, '/anexos/2025/11/ato_135/documento_cliente_35.pdf', '2025-11-10 14:58', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (140, 56, 2, '2025-11-10 13:44', 37.48, 38.7, 101, 20, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (136, 56, 6, 2, NULL, '2025-11-10 14:09', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (137, 56, 6, 10, NULL, '2025-11-10 14:31', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (17, 56, 2, '2025-11-10 14:37', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (17, 9), (17, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (47, 17, 9, 13, 7.054, '2025-11-10 16:39', '2025-11-10 17:55', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (48, 17, 10, 13, 2.317, '2025-11-10 16:35', '2025-11-10 17:23', NULL);
UPDATE episodio SET data_hora_fim = '2025-11-10 15:46' WHERE id_episodio = 56;

-- Episódio 57 — Bobi (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (57, 62, '2025-11-17 17:26');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (138, 57, 1, 5, NULL, '2025-11-17 17:26', 'Sintomas: tosse seca. Diagnóstico: traqueobronquite. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (141, 57, 5, '2025-11-17 17:32', 5.46, 39.6, 199, 24, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (139, 57, 8, 5, NULL, '2025-11-17 17:56', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (36, 139, 5, 'relatorio_eco_36.pdf', 'application/pdf', 160761, '/anexos/2025/11/ato_139/relatorio_eco_36.pdf', '2025-11-17 18:31', 'Entregue pelo cliente');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (13, 57, '2025-11-17 18:10');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (140, 57, 9, 5, NULL, '2025-11-17 19:10', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (37, 140, 5, 'consentimento_37.pdf', 'application/pdf', 774758, '/anexos/2025/11/ato_140/consentimento_37.pdf', '2025-11-17 19:42', 'Cirurgia — Bobi');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (38, 140, 5, 'relatorio_cirurgico_38.pdf', 'application/pdf', 456254, '/anexos/2025/11/ato_140/relatorio_cirurgico_38.pdf', '2025-11-17 19:39', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (142, 57, 20, '2025-11-17 22:10', NULL, 38.1, 178, 34, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (141, 57, 5, 20, NULL, '2025-11-17 22:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (143, 57, 10, '2025-11-18 14:10', NULL, 39.3, 174, 29, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (142, 57, 4, 10, NULL, '2025-11-18 14:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (144, 57, 7, '2025-11-19 08:10', NULL, 39.8, 191, 26, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (143, 57, 4, 7, NULL, '2025-11-19 08:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (145, 57, 11, '2025-11-19 22:10', NULL, 39.1, 174, 31, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (146, 57, 8, '2025-11-20 18:10', NULL, 40.1, 189, 36, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (144, 57, 4, 8, NULL, '2025-11-20 18:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (147, 57, 9, '2025-11-21 07:10', NULL, 38.3, 184, 23, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (145, 57, 11, 9, NULL, '2025-11-21 07:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (148, 57, 10, '2025-11-21 19:10', NULL, 39.1, 205, 28, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (146, 57, 5, 10, NULL, '2025-11-21 19:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (149, 57, 20, '2025-11-22 11:10', NULL, 38.5, 208, 29, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (147, 57, 11, 20, NULL, '2025-11-22 11:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (150, 57, 11, '2025-11-23 06:10', NULL, 37.8, 216, 40, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (148, 57, 4, 11, NULL, '2025-11-23 06:20', NULL);
UPDATE internamento SET data_hora_fim = '2025-11-23 08:10' WHERE id_internamento = 13;
UPDATE episodio SET data_hora_fim = '2025-11-23 08:24' WHERE id_episodio = 57;

-- Episódio 58 — Max (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (58, 16, '2025-11-24 11:17');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (149, 58, 1, 4, NULL, '2025-11-24 11:17', 'Sintomas: vómitos há 2 dias. Diagnóstico: obstrução intestinal. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (151, 58, 4, '2025-11-24 11:30', 5.54, 38.4, 154, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (150, 58, 6, 20, NULL, '2025-11-24 11:52', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (18, 58, 4, '2025-11-24 12:03', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (18, 1);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (49, 18, 1, 14, 92.2, '2025-11-24 13:57', '2025-11-24 15:49', NULL);
UPDATE episodio SET data_hora_fim = '2025-11-24 13:06' WHERE id_episodio = 58;

-- Episódio 59 — Mia (Furão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (59, 46, '2025-11-24 12:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (151, 59, 1, 19, 63, '2025-11-24 12:07', 'Sintomas: check-up anual. Diagnóstico: diabetes mellitus. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (152, 59, 19, '2025-11-24 12:13', 0.8, 39.2, 198, 38, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (152, 59, 6, 19, NULL, '2025-11-24 12:33', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (19, 59, 19, '2025-11-24 12:38', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (19, 2), (19, 3), (19, 14);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (50, 19, 3, 14, 1.186, '2025-11-24 15:19', '2025-11-24 16:02', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (51, 19, 14, 13, 7.7, '2025-11-24 13:47', '2025-11-24 14:13', NULL);
UPDATE episodio SET data_hora_fim = '2025-11-24 12:59' WHERE id_episodio = 59;

-- Episódio 60 — Mia (Furão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (60, 46, '2025-12-01 13:06');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (153, 60, 1, 19, 64, '2025-12-01 13:06', 'Sintomas: ferida na pata. Diagnóstico: infeção urinária. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (153, 60, 19, '2025-12-01 13:26', 1.55, 38.4, 207, 39, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (154, 60, 2, 20, NULL, '2025-12-01 14:05', NULL);
UPDATE episodio SET data_hora_fim = '2025-12-01 15:15' WHERE id_episodio = 60;

-- Episódio 61 — Estrela (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (61, 34, '2025-12-01 14:03');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (155, 61, 1, 2, 49, '2025-12-01 14:03', 'Sintomas: vómitos há 2 dias. Diagnóstico: obstrução intestinal. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (154, 61, 2, '2025-12-01 14:17', 7.58, 38.5, 197, 34, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (156, 61, 7, 2, NULL, '2025-12-01 14:56', NULL);
UPDATE episodio SET data_hora_fim = '2025-12-01 15:22' WHERE id_episodio = 61;

-- Episódio 62 — Luna (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (62, 68, '2025-12-01 14:31');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (157, 62, 1, 1, 92, '2025-12-01 14:31', 'Sintomas: polidipsia e poliúria. Diagnóstico: conjuntivite bacteriana. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (155, 62, 1, '2025-12-01 14:43', 37.3, 38.4, 137, NULL, 'Ligeira desidratação');
UPDATE episodio SET data_hora_fim = '2025-12-01 16:08' WHERE id_episodio = 62;

-- Episódio 63 — Sombra (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (63, 9, '2025-12-08 10:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (158, 63, 1, 3, 16, '2025-12-08 10:38', 'Sintomas: otite com corrimento. Diagnóstico: gastroenterite aguda. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (156, 63, 3, '2025-12-08 10:54', 14.3, 37.5, 102, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (159, 63, 2, 9, NULL, '2025-12-08 11:16', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (20, 63, 3, '2025-12-08 11:21', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (20, 9), (20, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (52, 20, 9, 13, 5.634, '2025-12-08 12:54', '2025-12-08 13:57', NULL);
UPDATE episodio SET data_hora_fim = '2025-12-08 11:59' WHERE id_episodio = 63;

-- Episódio 64 — Snoopy (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (64, 13, '2025-12-10 17:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (160, 64, 1, 1, NULL, '2025-12-10 17:05', 'Sintomas: polidipsia e poliúria. Diagnóstico: hipertiroidismo. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (39, 160, 1, 'relatorio_consulta_39.pdf', 'application/pdf', 471160, '/anexos/2025/12/ato_160/relatorio_consulta_39.pdf', '2025-12-10 18:10', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (157, 64, 1, '2025-12-10 17:16', 25.23, 38.4, 124, 16, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (161, 64, 6, 11, NULL, '2025-12-10 17:35', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (162, 64, 2, 10, NULL, '2025-12-10 18:04', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (21, 64, 1, '2025-12-10 18:21', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (21, 11), (21, 12);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (53, 21, 12, 12, 139.3, '2025-12-10 20:50', '2025-12-10 21:50', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2025-12-10 19:38' WHERE id_episodio = 64;

-- Episódio 65 — Mia (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (65, 1, '2025-12-12 12:04');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (163, 65, 1, 5, 1, '2025-12-12 12:04', 'Sintomas: dificuldade respiratória. Diagnóstico: diabetes mellitus. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (158, 65, 5, '2025-12-12 12:09', 6.48, 39.2, 212, 22, 'Sem alterações');
UPDATE episodio SET data_hora_fim = '2025-12-12 12:25' WHERE id_episodio = 65;

-- Episódio 66 — Bolinha (Outro)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (66, 67, '2025-12-15 21:26');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (164, 66, 1, 5, NULL, '2025-12-15 21:26', 'Sintomas: massa subcutânea. Diagnóstico: infeção urinária. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (159, 66, 5, '2025-12-15 21:38', 22.02, 39.5, 168, 24, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (165, 66, 8, 5, NULL, '2025-12-15 22:18', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (166, 66, 4, 5, NULL, '2025-12-15 22:41', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (22, 66, 5, '2025-12-15 22:46', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (22, 1), (22, 11), (22, 12);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (54, 22, 1, 13, 66.6, '2025-12-15 23:44', '2025-12-16 01:42', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (55, 22, 11, 14, 4.648, '2025-12-16 01:41', '2025-12-16 02:16', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (56, 22, 12, 12, 135.1, '2025-12-15 23:45', '2025-12-16 01:14', 'Repetido para confirmação');
UPDATE episodio SET data_hora_fim = '2025-12-15 23:01' WHERE id_episodio = 66;

-- Episódio 67 — Kika (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (67, 35, '2025-12-16 13:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (167, 67, 1, 19, 50, '2025-12-16 13:38', 'Sintomas: conjuntivite. Diagnóstico: dermatite alérgica. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (160, 67, 19, '2025-12-16 13:52', 5.19, 40.0, 135, 14, NULL);
UPDATE episodio SET data_hora_fim = '2025-12-16 14:24' WHERE id_episodio = 67;

-- Episódio 68 — Tobi (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (68, 31, '2025-12-24 17:30');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (168, 68, 1, 2, 43, '2025-12-24 17:30', 'Sintomas: tosse seca. Diagnóstico: otite externa. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (161, 68, 2, '2025-12-24 17:49', 7.19, 40.0, 198, NULL, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (169, 68, 5, 10, NULL, '2025-12-24 18:06', NULL);
UPDATE episodio SET data_hora_fim = '2025-12-24 18:46' WHERE id_episodio = 68;

-- Episódio 69 — Farrusco (Roedor)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (69, 39, '2025-12-26 09:40');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (170, 69, 1, 19, 54, '2025-12-26 09:40', 'Sintomas: ferida na pata. Diagnóstico: lipoma. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (162, 69, 19, '2025-12-26 09:46', 0.67, 39.0, 373, 65, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (171, 69, 7, 19, NULL, '2025-12-26 10:14', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (40, 171, 19, 'relatorio_rx_40.pdf', 'application/pdf', 185367, '/anexos/2025/12/ato_171/relatorio_rx_40.pdf', '2025-12-26 10:16', 'Imagem do exame');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (172, 69, 2, 7, NULL, '2025-12-26 10:35', NULL);
UPDATE episodio SET data_hora_fim = '2025-12-26 11:50' WHERE id_episodio = 69;

-- Episódio 70 — Leo (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (70, 26, '2025-12-26 14:35');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (173, 70, 1, 2, 36, '2025-12-26 14:35', 'Sintomas: vómitos há 2 dias. Diagnóstico: diabetes mellitus. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (163, 70, 2, '2025-12-26 14:48', 1.13, 38.9, 180, 59, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (174, 70, 2, 20, NULL, '2025-12-26 15:21', NULL);
UPDATE episodio SET data_hora_fim = '2025-12-26 15:45' WHERE id_episodio = 70;

-- Episódio 71 — Baltasar (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (71, 81, '2025-12-31 11:34');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (175, 71, 1, 2, 110, '2025-12-31 11:34', 'Sintomas: check-up anual. Diagnóstico: otite externa. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (164, 71, 2, '2025-12-31 11:39', 6.31, 38.3, 218, 31, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (14, 71, '2025-12-31 12:17');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (176, 71, 9, 2, NULL, '2025-12-31 13:17', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (41, 176, 2, 'foto_pos_op_41.jpg', 'image/jpeg', 2623355, '/anexos/2025/12/ato_176/foto_pos_op_41.jpg', '2025-12-31 13:22', 'Cirurgia — Baltasar');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (42, 176, 2, 'foto_pos_op_42.jpg', 'image/jpeg', 4444335, '/anexos/2025/12/ato_176/foto_pos_op_42.jpg', '2025-12-31 14:12', 'Cirurgia — Baltasar');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (165, 71, 7, '2025-12-31 15:17', 5.69, 38.7, 213, NULL, 'Animal alerta e responsivo');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (166, 71, 11, '2026-01-01 12:17', NULL, 39.1, 188, 25, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (177, 71, 11, 11, NULL, '2026-01-01 12:27', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (167, 71, 20, '2026-01-02 11:17', 6.64, 39.4, 200, 39, 'Animal alerta e responsivo');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (168, 71, 20, '2026-01-03 07:17', NULL, 39.7, 167, 31, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (178, 71, 11, 20, NULL, '2026-01-03 07:27', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (169, 71, 9, '2026-01-04 01:17', NULL, 39.6, 143, 30, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (179, 71, 11, 9, NULL, '2026-01-04 01:27', NULL);
UPDATE internamento SET data_hora_fim = '2026-01-04 15:17' WHERE id_internamento = 14;
UPDATE episodio SET data_hora_fim = '2026-01-04 15:51' WHERE id_episodio = 71;

-- Episódio 72 — Pintas (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (72, 28, '2026-01-09 16:06');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (180, 72, 1, 4, 38, '2026-01-09 16:06', 'Sintomas: massa subcutânea. Diagnóstico: lipoma. Plano: internamento para fluidoterapia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (170, 72, 4, '2026-01-09 16:15', 2.63, 39.7, 220, NULL, NULL);
UPDATE episodio SET data_hora_fim = '2026-01-09 17:18' WHERE id_episodio = 72;

-- Episódio 73 — Sombra (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (73, 9, '2026-01-12 16:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (181, 73, 1, 19, NULL, '2026-01-12 16:05', 'Sintomas: prurido intenso. Diagnóstico: animal saudável. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (43, 181, 19, 'relatorio_consulta_43.pdf', 'application/pdf', 624989, '/anexos/2026/01/ato_181/relatorio_consulta_43.pdf', '2026-01-12 16:49', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (171, 73, 19, '2026-01-12 16:19', 17.09, 38.0, 135, NULL, NULL);
UPDATE episodio SET data_hora_fim = '2026-01-12 16:52' WHERE id_episodio = 73;

-- Episódio 74 — Ruca (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (74, 61, '2026-01-19 09:37');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (182, 74, 1, 3, 80, '2026-01-19 09:37', 'Sintomas: ingestão de corpo estranho. Diagnóstico: otite externa. Plano: cirurgia programada.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (44, 182, 3, 'documento_cliente_44.pdf', 'application/pdf', 501302, '/anexos/2026/01/ato_182/documento_cliente_44.pdf', '2026-01-19 09:39', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (172, 74, 3, '2026-01-19 09:50', 2.68, 41.0, 152, 41, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (183, 74, 10, 3, NULL, '2026-01-19 10:07', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (23, 74, 3, '2026-01-19 10:30', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (23, 1), (23, 2), (23, 3), (23, 13);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (57, 23, 1, 12, 67.6, '2026-01-19 13:44', '2026-01-19 13:45', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (58, 23, 2, 13, 10.3, '2026-01-19 13:39', '2026-01-19 13:47', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (59, 23, 3, 12, 1.015, '2026-01-19 13:00', '2026-01-19 14:54', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (60, 23, 13, 12, 3.052, '2026-01-19 14:05', '2026-01-19 15:43', NULL);
UPDATE episodio SET data_hora_fim = '2026-01-19 11:44' WHERE id_episodio = 74;

-- Episódio 75 — Kiko (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (75, 76, '2026-01-26 09:04');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (184, 75, 1, 19, 101, '2026-01-26 09:04', 'Sintomas: ingestão de corpo estranho. Diagnóstico: conjuntivite bacteriana. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (173, 75, 19, '2026-01-26 09:13', 4.8, 37.7, 165, 34, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (185, 75, 5, 10, NULL, '2026-01-26 09:52', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (24, 75, 19, '2026-01-26 10:03', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (24, 1);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (61, 24, 1, 13, 79.3, '2026-01-26 13:26', '2026-01-26 15:16', NULL);
UPDATE episodio SET data_hora_fim = '2026-01-26 11:13' WHERE id_episodio = 75;

-- Episódio 76 — Rocky (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (76, 7, '2026-02-09 11:31');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (186, 76, 1, 3, 14, '2026-02-09 11:31', 'Sintomas: ingestão de corpo estranho. Diagnóstico: obstrução intestinal. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (174, 76, 3, '2026-02-09 11:43', 37.72, 39.9, 65, 11, 'Ligeira desidratação');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (25, 76, 3, '2026-02-09 11:49', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (25, 9), (25, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (62, 25, 9, 13, 8.165, '2026-02-09 12:40', '2026-02-09 12:57', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (63, 25, 10, 14, 3.902, '2026-02-09 12:34', '2026-02-09 13:08', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (15, 76, '2026-02-09 12:18');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (175, 76, 7, '2026-02-09 15:18', NULL, 37.8, 111, 11, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (176, 76, 9, '2026-02-10 09:18', NULL, 37.5, 93, 18, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (177, 76, 20, '2026-02-11 08:18', NULL, 37.2, 138, 23, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (187, 76, 11, 20, NULL, '2026-02-11 08:28', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (178, 76, 9, '2026-02-12 01:18', 3.28, 39.3, 108, 16, 'Come com apetite');
UPDATE internamento SET data_hora_fim = '2026-02-12 02:18' WHERE id_internamento = 15;
UPDATE episodio SET data_hora_fim = '2026-02-12 02:31' WHERE id_episodio = 76;

-- Episódio 77 — Max (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (77, 16, '2026-02-10 14:31');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (188, 77, 1, 6, 21, '2026-02-10 14:31', 'Sintomas: prurido intenso. Diagnóstico: conjuntivite bacteriana. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (45, 188, 6, 'foto_lesao_45.jpg', 'image/jpeg', 2938041, '/anexos/2026/02/ato_188/foto_lesao_45.jpg', '2026-02-10 15:08', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (179, 77, 6, '2026-02-10 14:47', 5.58, 39.6, 191, 23, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (189, 77, 5, 6, NULL, '2026-02-10 14:57', NULL);
UPDATE episodio SET data_hora_fim = '2026-02-10 15:12' WHERE id_episodio = 77;

-- Episódio 78 — Kiko (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (78, 76, '2026-02-12 13:06');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (190, 78, 1, 4, 102, '2026-02-12 13:06', 'Sintomas: conjuntivite. Diagnóstico: gastroenterite aguda. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (180, 78, 4, '2026-02-12 13:23', 5.85, 39.1, 218, 21, 'Mucosas rosadas, TRC < 2 s');
UPDATE episodio SET data_hora_fim = '2026-02-12 13:49' WHERE id_episodio = 78;

-- Episódio 79 — Tobi (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (79, 31, '2026-03-02 16:17');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (191, 79, 1, 4, NULL, '2026-03-02 16:17', 'Sintomas: tosse seca. Diagnóstico: animal saudável. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (181, 79, 4, '2026-03-02 16:24', 6.7, 40.3, 159, 36, 'Ligeira desidratação');
UPDATE episodio SET data_hora_fim = '2026-03-02 16:56' WHERE id_episodio = 79;

-- Episódio 80 — Farrusco (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (80, 21, '2026-03-02 16:31');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (192, 80, 1, 3, 28, '2026-03-02 16:31', 'Sintomas: ferida na pata. Diagnóstico: gastroenterite aguda. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (182, 80, 3, '2026-03-02 16:42', 31.38, 38.1, 69, 18, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (193, 80, 5, 8, NULL, '2026-03-02 17:09', NULL);
UPDATE episodio SET data_hora_fim = '2026-03-02 18:26' WHERE id_episodio = 80;

-- Episódio 81 — Luna (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (81, 33, '2026-03-10 09:30');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (194, 81, 1, 3, 47, '2026-03-10 09:30', 'Sintomas: massa subcutânea. Diagnóstico: dermatite alérgica. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (183, 81, 3, '2026-03-10 09:46', 6.89, 38.7, 172, 24, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (195, 81, 8, 3, NULL, '2026-03-10 10:11', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (46, 195, 3, 'eco_46.jpg', 'image/jpeg', 748912, '/anexos/2026/03/ato_195/eco_46.jpg', '2026-03-10 11:32', NULL);
UPDATE episodio SET data_hora_fim = '2026-03-10 11:07' WHERE id_episodio = 81;

-- Episódio 82 — Mia (Furão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (82, 46, '2026-03-16 09:04');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (196, 82, 1, 5, 65, '2026-03-16 09:04', 'Sintomas: perda de peso. Diagnóstico: otite externa. Plano: cirurgia programada.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (47, 196, 5, 'relatorio_consulta_47.pdf', 'application/pdf', 378302, '/anexos/2026/03/ato_196/relatorio_consulta_47.pdf', '2026-03-16 09:44', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (184, 82, 5, '2026-03-16 09:11', 1.6, 40.6, 204, NULL, 'Dor à palpação abdominal');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (26, 82, 5, '2026-03-16 09:22', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (26, 1), (26, 2), (26, 3);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (64, 26, 1, 13, 163.2, '2026-03-16 09:51', '2026-03-16 11:05', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (65, 26, 2, 14, 49.8, '2026-03-16 12:11', '2026-03-16 12:46', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (66, 26, 3, 12, 1.402, '2026-03-16 12:45', '2026-03-16 13:31', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2026-03-16 10:08' WHERE id_episodio = 82;

-- Episódio 83 — Max (Ave)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (83, 73, '2026-03-17 14:31');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (197, 83, 1, 4, 98, '2026-03-17 14:31', 'Sintomas: dificuldade respiratória. Diagnóstico: conjuntivite bacteriana. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (185, 83, 4, '2026-03-17 14:46', 0.32, 39.2, 265, 58, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (198, 83, 8, 4, NULL, '2026-03-17 15:20', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (48, 198, 4, 'relatorio_eco_48.pdf', 'application/pdf', 359572, '/anexos/2026/03/ato_198/relatorio_eco_48.pdf', '2026-03-17 16:40', 'Ecografia — Max');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (199, 83, 2, 4, NULL, '2026-03-17 15:43', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (49, 199, 4, 'boletim_vacinas_49.pdf', 'application/pdf', 749126, '/anexos/2026/03/ato_199/boletim_vacinas_49.pdf', '2026-03-17 16:12', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (16, 83, '2026-03-17 15:56');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (200, 83, 9, 4, NULL, '2026-03-17 16:56', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (50, 200, 4, 'relatorio_cirurgico_50.pdf', 'application/pdf', 184403, '/anexos/2026/03/ato_200/relatorio_cirurgico_50.pdf', '2026-03-17 18:14', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (186, 83, 8, '2026-03-17 19:56', NULL, 41.8, 445, 47, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (201, 83, 4, 8, NULL, '2026-03-17 20:06', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (187, 83, 8, '2026-03-18 17:56', NULL, 39.5, 216, 27, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (202, 83, 4, 8, NULL, '2026-03-18 18:06', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (188, 83, 7, '2026-03-19 13:56', NULL, 39.1, 245, NULL, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (203, 83, 5, 7, NULL, '2026-03-19 14:06', NULL);
UPDATE internamento SET data_hora_fim = '2026-03-19 20:56' WHERE id_internamento = 16;
UPDATE episodio SET data_hora_fim = '2026-03-19 21:37' WHERE id_episodio = 83;

-- Episódio 84 — Kiko (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (84, 76, '2026-03-27 10:00');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (204, 84, 1, 2, 103, '2026-03-27 10:00', 'Sintomas: vacinação de rotina. Diagnóstico: dermatite alérgica. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (189, 84, 2, '2026-03-27 10:09', 7.0, 38.9, 160, NULL, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (205, 84, 3, 9, NULL, '2026-03-27 10:44', NULL);
UPDATE episodio SET data_hora_fim = '2026-03-27 11:34' WHERE id_episodio = 84;

-- Episódio 85 — Pantufa (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (85, 55, '2026-04-01 12:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (206, 85, 1, 5, 74, '2026-04-01 12:38', 'Sintomas: dificuldade respiratória. Diagnóstico: hipertiroidismo. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (51, 206, 5, 'documento_cliente_51.pdf', 'application/pdf', 639659, '/anexos/2026/04/ato_206/documento_cliente_51.pdf', '2026-04-01 13:38', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (190, 85, 5, '2026-04-01 12:44', 3.22, 39.8, 176, 29, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (207, 85, 4, 8, NULL, '2026-04-01 13:13', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (52, 207, 8, 'foto_ferida_52.jpg', 'image/jpeg', 403830, '/anexos/2026/04/ato_207/foto_ferida_52.jpg', '2026-04-01 13:40', 'Penso — Pantufa');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (53, 207, 8, 'foto_ferida_53.jpg', 'image/jpeg', 1305915, '/anexos/2026/04/ato_207/foto_ferida_53.jpg', '2026-04-01 14:26', 'Penso — Pantufa');
UPDATE episodio SET data_hora_fim = '2026-04-01 14:33' WHERE id_episodio = 85;

-- Episódio 86 — Ruca (Ave)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (86, 79, '2026-04-03 11:33');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (208, 86, 1, 1, 109, '2026-04-03 11:33', 'Sintomas: dor abdominal. Diagnóstico: otite externa. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (191, 86, 1, '2026-04-03 11:45', 0.42, 40.5, 317, 51, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (209, 86, 4, 1, NULL, '2026-04-03 12:00', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (54, 209, 1, 'foto_ferida_54.jpg', 'image/jpeg', 7779996, '/anexos/2026/04/ato_209/foto_ferida_54.jpg', '2026-04-03 12:12', 'Imagem do exame');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (210, 86, 7, 1, NULL, '2026-04-03 12:18', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (55, 210, 1, 'rx_55.png', 'image/png', 4393236, '/anexos/2026/04/ato_210/rx_55.png', '2026-04-03 13:42', 'Entregue pelo cliente');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (56, 210, 1, 'rx_56.jpg', 'image/jpeg', 5176908, '/anexos/2026/04/ato_210/rx_56.jpg', '2026-04-03 12:32', 'Radiografia — Ruca');
UPDATE episodio SET data_hora_fim = '2026-04-03 12:49' WHERE id_episodio = 86;

-- Episódio 87 — Pintas (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (87, 28, '2026-04-03 17:44');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (211, 87, 1, 2, NULL, '2026-04-03 17:44', 'Sintomas: conjuntivite. Diagnóstico: diabetes mellitus. Plano: pensos a cada 48 h.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (57, 211, 2, 'foto_lesao_57.jpg', 'image/jpeg', 2199160, '/anexos/2026/04/ato_211/foto_lesao_57.jpg', '2026-04-03 18:51', 'Consulta — Pintas');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (192, 87, 2, '2026-04-03 17:49', 1.96, 40.5, 239, NULL, 'Mucosas rosadas, TRC < 2 s');
UPDATE episodio SET data_hora_fim = '2026-04-03 18:50' WHERE id_episodio = 87;

-- Episódio 88 — Jade (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (88, 22, '2026-04-06 11:30');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (212, 88, 1, 4, 29, '2026-04-06 11:30', 'Sintomas: vómitos há 2 dias. Diagnóstico: lipoma. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (193, 88, 4, '2026-04-06 11:38', 3.3, 40.2, 203, 28, NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (27, 88, 4, '2026-04-06 12:07', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (27, 6), (27, 7), (27, 8), (27, 9);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (67, 27, 6, 12, 51.1, '2026-04-06 13:45', '2026-04-06 14:34', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (68, 27, 7, 14, 11.6, '2026-04-06 15:34', '2026-04-06 16:48', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (69, 27, 8, 14, 141.0, '2026-04-06 14:23', '2026-04-06 16:00', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (70, 27, 9, 14, 7.589, '2026-04-06 15:08', '2026-04-06 15:59', 'Repetido para confirmação');
UPDATE episodio SET data_hora_fim = '2026-04-06 12:22' WHERE id_episodio = 88;

-- Episódio 89 — Canela (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (89, 18, '2026-04-13 13:33');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (213, 89, 1, 6, 27, '2026-04-13 13:33', 'Sintomas: conjuntivite. Diagnóstico: infeção urinária. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (194, 89, 6, '2026-04-13 13:47', 5.34, 39.7, 195, 40, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (214, 89, 8, 6, NULL, '2026-04-13 14:04', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (58, 214, 6, 'relatorio_eco_58.pdf', 'application/pdf', 158954, '/anexos/2026/04/ato_214/relatorio_eco_58.pdf', '2026-04-13 14:27', 'Entregue pelo cliente');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (28, 89, 6, '2026-04-13 14:19', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (28, 1), (28, 2), (28, 3), (28, 9), (28, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (71, 28, 2, 13, 23.1, '2026-04-13 17:37', '2026-04-13 17:54', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (72, 28, 3, 14, 0.926, '2026-04-13 15:36', '2026-04-13 16:53', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (73, 28, 9, 12, 6.03, '2026-04-13 17:29', '2026-04-13 18:30', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (74, 28, 10, 14, 2.144, '2026-04-13 17:42', '2026-04-13 18:41', NULL);
UPDATE episodio SET data_hora_fim = '2026-04-13 15:12' WHERE id_episodio = 89;

-- Episódio 90 — Sombra (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (90, 9, '2026-04-16 15:02');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (215, 90, 1, 3, 17, '2026-04-16 15:02', 'Sintomas: massa subcutânea. Diagnóstico: infeção urinária. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (195, 90, 3, '2026-04-16 15:19', 27.21, 40.1, 124, 11, 'Mucosas rosadas, TRC < 2 s');
UPDATE episodio SET data_hora_fim = '2026-04-16 16:20' WHERE id_episodio = 90;

-- Episódio 91 — Mia (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (91, 77, '2026-04-20 09:04');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (216, 91, 1, 6, 105, '2026-04-20 09:04', 'Sintomas: tosse seca. Diagnóstico: otite externa. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (196, 91, 6, '2026-04-20 09:17', 1.8, 40.3, 216, 45, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (217, 91, 3, 6, NULL, '2026-04-20 09:48', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (17, 91, '2026-04-20 10:10');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (197, 91, 8, '2026-04-20 13:10', 2.36, 38.6, 147, 37, 'Come com apetite');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (198, 91, 7, '2026-04-21 05:10', NULL, 38.3, 238, 37, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (199, 91, 10, '2026-04-21 19:10', 2.33, 39.1, 214, 42, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (218, 91, 11, 10, NULL, '2026-04-21 19:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (200, 91, 10, '2026-04-22 11:10', NULL, 38.1, 262, NULL, 'Come com apetite');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (201, 91, 7, '2026-04-23 06:10', NULL, 40.8, 178, 59, 'Animal alerta e responsivo');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (202, 91, 9, '2026-04-23 18:10', NULL, 40.0, 148, 33, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (203, 91, 11, '2026-04-24 18:10', 1.72, 38.8, 293, 39, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (204, 91, 8, '2026-04-25 07:10', NULL, 40.3, 288, 40, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (219, 91, 4, 8, NULL, '2026-04-25 07:20', NULL);
UPDATE internamento SET data_hora_fim = '2026-04-25 11:10' WHERE id_internamento = 17;
UPDATE episodio SET data_hora_fim = '2026-04-25 11:53' WHERE id_episodio = 91;

-- Episódio 92 — Becas (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (92, 72, '2026-04-27 09:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (220, 92, 1, 1, NULL, '2026-04-27 09:05', 'Sintomas: claudicação do membro posterior. Diagnóstico: artrose. Plano: pensos a cada 48 h.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (59, 220, 1, 'relatorio_consulta_59.pdf', 'application/pdf', 530826, '/anexos/2026/04/ato_220/relatorio_consulta_59.pdf', '2026-04-27 10:28', 'Entregue pelo cliente');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (60, 220, 1, 'relatorio_consulta_60.pdf', 'application/pdf', 763417, '/anexos/2026/04/ato_220/relatorio_consulta_60.pdf', '2026-04-27 09:51', 'Consulta — Becas');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (205, 92, 1, '2026-04-27 09:12', 3.24, 39.4, 146, 28, 'Sem alterações');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (18, 92, '2026-04-27 09:41');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (206, 92, 10, '2026-04-27 15:41', NULL, 38.1, 217, 20, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (221, 92, 4, 10, NULL, '2026-04-27 15:51', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (61, 221, 10, 'foto_ferida_61.jpg', 'image/jpeg', 4948176, '/anexos/2026/04/ato_221/foto_ferida_61.jpg', '2026-04-27 15:59', 'Penso — Becas');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (207, 92, 11, '2026-04-28 15:41', NULL, 39.7, 173, 37, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (208, 92, 11, '2026-04-29 15:41', 4.05, 38.8, 151, 23, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (222, 92, 5, 11, NULL, '2026-04-29 15:51', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (209, 92, 11, '2026-04-30 14:41', NULL, 39.7, 186, 22, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (223, 92, 11, 11, NULL, '2026-04-30 14:51', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (210, 92, 8, '2026-05-01 05:41', NULL, 38.3, 197, NULL, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (224, 92, 4, 8, NULL, '2026-05-01 05:51', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (62, 224, 8, 'foto_ferida_62.jpg', 'image/jpeg', 4215345, '/anexos/2026/05/ato_224/foto_ferida_62.jpg', '2026-05-01 06:47', 'Penso — Becas');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (63, 224, 8, 'foto_ferida_63.jpg', 'image/jpeg', 4848851, '/anexos/2026/05/ato_224/foto_ferida_63.jpg', '2026-05-01 06:20', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (211, 92, 8, '2026-05-02 00:41', NULL, 39.3, 182, 23, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (225, 92, 11, 8, NULL, '2026-05-02 00:51', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (212, 92, 7, '2026-05-02 12:41', NULL, 40.1, 149, NULL, 'Sem alterações');
UPDATE internamento SET data_hora_fim = '2026-05-02 20:41' WHERE id_internamento = 18;
UPDATE episodio SET data_hora_fim = '2026-05-02 21:37' WHERE id_episodio = 92;

-- Episódio 93 — Luna (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (93, 24, '2026-04-27 15:36');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (226, 93, 1, 2, 33, '2026-04-27 15:36', 'Sintomas: conjuntivite. Diagnóstico: traqueobronquite. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (213, 93, 2, '2026-04-27 15:45', 31.44, 40.1, 76, 18, 'Dor à palpação abdominal');
UPDATE episodio SET data_hora_fim = '2026-04-27 16:24' WHERE id_episodio = 93;

-- Episódio 94 — Lua (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (94, 59, '2026-05-01 09:08');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (227, 94, 1, 6, 78, '2026-05-01 09:08', 'Sintomas: otite com corrimento. Diagnóstico: artrose. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (214, 94, 6, '2026-05-01 09:21', 7.37, 38.3, 209, 23, 'Ligeira desidratação');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (29, 94, 6, '2026-05-01 09:28', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (29, 4), (29, 5);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (75, 29, 4, 14, 50.8, '2026-05-01 13:27', '2026-05-01 13:28', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (76, 29, 5, 13, 54.9, '2026-05-01 12:25', '2026-05-01 13:14', 'Repetido para confirmação');
UPDATE episodio SET data_hora_fim = '2026-05-01 09:44' WHERE id_episodio = 94;

-- Episódio 95 — Kiko (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (95, 23, '2026-05-11 10:32');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (228, 95, 1, 5, 31, '2026-05-11 10:32', 'Sintomas: vómitos há 2 dias. Diagnóstico: animal saudável. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (64, 228, 5, 'relatorio_consulta_64.pdf', 'application/pdf', 637373, '/anexos/2026/05/ato_228/relatorio_consulta_64.pdf', '2026-05-11 11:05', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (65, 228, 5, 'foto_lesao_65.jpg', 'image/jpeg', 3634161, '/anexos/2026/05/ato_228/foto_lesao_65.jpg', '2026-05-11 10:46', 'Consulta — Kiko');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (215, 95, 5, '2026-05-11 10:50', 35.98, 39.7, 81, 23, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (229, 95, 6, 7, NULL, '2026-05-11 11:05', NULL);
UPDATE episodio SET data_hora_fim = '2026-05-11 12:15' WHERE id_episodio = 95;

-- Episódio 96 — Zeus (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (96, 4, '2026-05-15 10:06');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (230, 96, 1, 4, 9, '2026-05-15 10:06', 'Sintomas: ferida na pata. Diagnóstico: laceração cutânea. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (216, 96, 4, '2026-05-15 10:12', 5.34, 39.0, 162, 35, 'Animal alerta e responsivo');
UPDATE episodio SET data_hora_fim = '2026-05-15 11:18' WHERE id_episodio = 96;

-- Episódio 97 — Pintas (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (97, 56, '2026-05-25 09:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (231, 97, 1, 2, 75, '2026-05-25 09:07', 'Sintomas: dor abdominal. Diagnóstico: laceração cutânea. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (217, 97, 2, '2026-05-25 09:23', 29.78, 38.5, 73, NULL, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (232, 97, 5, 2, NULL, '2026-05-25 09:36', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (233, 97, 7, 2, NULL, '2026-05-25 09:47', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (66, 233, 2, 'rx_66.jpg', 'image/jpeg', 7250525, '/anexos/2026/05/ato_233/rx_66.jpg', '2026-05-25 10:09', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (30, 97, 2, '2026-05-25 10:01', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (30, 2), (30, 3), (30, 9), (30, 10), (30, 14);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (77, 30, 2, 12, 64.4, '2026-05-25 10:37', '2026-05-25 12:28', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (78, 30, 3, 13, 2.198, '2026-05-25 13:13', '2026-05-25 14:19', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (79, 30, 9, 12, 7.446, '2026-05-25 10:21', '2026-05-25 11:55', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (80, 30, 10, 14, 3.983, '2026-05-25 11:39', '2026-05-25 12:43', 'Repetido para confirmação');
UPDATE episodio SET data_hora_fim = '2026-05-25 11:06' WHERE id_episodio = 97;

-- Episódio 98 — Mia (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (98, 1, '2026-06-04 16:36');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (234, 98, 1, 2, 2, '2026-06-04 16:36', 'Sintomas: conjuntivite. Diagnóstico: artrose. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (218, 98, 2, '2026-06-04 16:45', 6.03, 38.0, 154, 29, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (235, 98, 2, 10, NULL, '2026-06-04 16:58', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (236, 98, 7, 2, NULL, '2026-06-04 17:14', NULL);
UPDATE episodio SET data_hora_fim = '2026-06-04 17:57' WHERE id_episodio = 98;

-- Episódio 99 — Pintas (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (99, 12, '2026-06-05 11:03');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (237, 99, 1, 3, 18, '2026-06-05 11:03', 'Sintomas: diarreia. Diagnóstico: infeção urinária. Plano: pensos a cada 48 h.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (67, 237, 3, 'foto_lesao_67.jpg', 'image/jpeg', 5031229, '/anexos/2026/06/ato_237/foto_lesao_67.jpg', '2026-06-05 12:29', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (219, 99, 3, '2026-06-05 11:11', 3.14, 40.7, 217, NULL, NULL);
UPDATE episodio SET data_hora_fim = '2026-06-05 12:04' WHERE id_episodio = 99;

-- Episódio 100 — Jade (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (100, 15, '2026-06-08 10:10');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (238, 100, 1, 3, 20, '2026-06-08 10:10', 'Sintomas: vacinação de rotina. Diagnóstico: artrose. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (220, 100, 3, '2026-06-08 10:29', 3.15, 38.6, 206, 36, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (239, 100, 5, 8, NULL, '2026-06-08 10:56', NULL);
UPDATE episodio SET data_hora_fim = '2026-06-08 11:20' WHERE id_episodio = 100;

-- Episódio 101 — Max (Ave)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (101, 73, '2026-06-09 11:10');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (240, 101, 1, 4, 99, '2026-06-09 11:10', 'Sintomas: otite com corrimento. Diagnóstico: gastroenterite aguda. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (221, 101, 4, '2026-06-09 11:29', 0.04, 39.9, 393, 38, NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (31, 101, 4, '2026-06-09 11:54', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (31, 2), (31, 3), (31, 6), (31, 7), (31, 8), (31, 9), (31, 14);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (81, 31, 3, 13, 0.048, '2026-06-09 13:56', '2026-06-09 14:18', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (82, 31, 6, 13, 34.5, '2026-06-09 12:38', '2026-06-09 13:07', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (83, 31, 7, 12, 13.2, '2026-06-09 15:09', '2026-06-09 15:50', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (84, 31, 8, 13, 81.5, '2026-06-09 14:51', '2026-06-09 16:33', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (85, 31, 9, 13, 6.153, '2026-06-09 13:09', '2026-06-09 14:38', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (86, 31, 14, 14, 9.9, '2026-06-09 12:37', '2026-06-09 14:03', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2026-06-09 12:21' WHERE id_episodio = 101;

-- Episódio 102 — Tobi (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (102, 31, '2026-06-12 16:30');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (241, 102, 1, 1, 44, '2026-06-12 16:30', 'Sintomas: tosse seca. Diagnóstico: artrose. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (222, 102, 1, '2026-06-12 16:42', 4.64, 38.7, 167, 24, 'Mucosas rosadas, TRC < 2 s');
UPDATE episodio SET data_hora_fim = '2026-06-12 17:56' WHERE id_episodio = 102;

-- Episódio 103 — Mia (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (103, 1, '2026-06-19 10:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (242, 103, 1, 4, 3, '2026-06-19 10:38', 'Sintomas: claudicação do membro posterior. Diagnóstico: traqueobronquite. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (223, 103, 4, '2026-06-19 10:49', 5.17, 38.0, 164, 33, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (243, 103, 2, 4, NULL, '2026-06-19 11:04', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (68, 243, 4, 'boletim_vacinas_68.pdf', 'application/pdf', 790889, '/anexos/2026/06/ato_243/boletim_vacinas_68.pdf', '2026-06-19 11:15', 'Imagem do exame');
UPDATE episodio SET data_hora_fim = '2026-06-19 12:05' WHERE id_episodio = 103;

-- Episódio 104 — Sombra (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (104, 29, '2026-06-22 12:30');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (244, 104, 1, 1, 42, '2026-06-22 12:30', 'Sintomas: otite com corrimento. Diagnóstico: obstrução intestinal. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (224, 104, 1, '2026-06-22 12:42', 34.06, 39.9, 66, 29, 'Dor à palpação abdominal');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (32, 104, 1, '2026-06-22 13:00', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (32, 1);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (87, 32, 1, 12, 106.5, '2026-06-22 14:31', '2026-06-22 15:47', NULL);
UPDATE episodio SET data_hora_fim = '2026-06-22 13:22' WHERE id_episodio = 104;

-- Episódio 105 — Kiko (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (105, 76, '2026-06-29 09:10');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (245, 105, 1, 3, 104, '2026-06-29 09:10', 'Sintomas: ingestão de corpo estranho. Diagnóstico: traqueobronquite. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (225, 105, 3, '2026-06-29 09:29', 2.53, 40.1, 177, 29, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (246, 105, 7, 3, NULL, '2026-06-29 09:53', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (69, 246, 3, 'rx_69.jpg', 'image/jpeg', 4282309, '/anexos/2026/06/ato_246/rx_69.jpg', '2026-06-29 10:21', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (247, 105, 2, 3, NULL, '2026-06-29 10:23', NULL);
UPDATE episodio SET data_hora_fim = '2026-06-29 10:57' WHERE id_episodio = 105;

-- Episódio 106 — Ruca (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (106, 61, '2026-06-29 14:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (248, 106, 1, 1, 81, '2026-06-29 14:38', 'Sintomas: tosse seca. Diagnóstico: artrose. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (226, 106, 1, '2026-06-29 14:50', 2.16, 38.6, 148, 37, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (33, 106, 1, '2026-06-29 14:56', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (33, 1), (33, 2), (33, 3);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (88, 33, 1, 12, 71.1, '2026-06-29 18:00', '2026-06-29 19:50', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (89, 33, 2, 13, 18.4, '2026-06-29 17:04', '2026-06-29 18:40', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (90, 33, 3, 13, 0.054, '2026-06-29 16:20', '2026-06-29 16:53', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2026-06-29 15:40' WHERE id_episodio = 106;

-- Episódio 107 — Mia (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (107, 1, '2026-07-01 15:39');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (249, 107, 1, 3, 4, '2026-07-01 15:39', 'Sintomas: dificuldade respiratória. Diagnóstico: laceração cutânea. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (227, 107, 3, '2026-07-01 15:57', 2.62, 38.2, 149, 23, 'Come com apetite');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (34, 107, 3, '2026-07-01 16:03', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (34, 13);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (91, 34, 13, 13, 2.232, '2026-07-01 17:10', '2026-07-01 17:28', NULL);
UPDATE episodio SET data_hora_fim = '2026-07-01 17:00' WHERE id_episodio = 107;

-- Episódio 108 — Nala (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (108, 44, '2026-07-08 09:03');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (250, 108, 1, 1, 61, '2026-07-08 09:03', 'Sintomas: vómitos há 2 dias. Diagnóstico: hipertiroidismo. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (70, 250, 1, 'relatorio_consulta_70.pdf', 'application/pdf', 298871, '/anexos/2026/07/ato_250/relatorio_consulta_70.pdf', '2026-07-08 10:22', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (71, 250, 1, 'documento_cliente_71.pdf', 'application/pdf', 839731, '/anexos/2026/07/ato_250/documento_cliente_71.pdf', '2026-07-08 09:46', 'Entregue pelo cliente');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (72, 250, 1, 'foto_lesao_72.jpg', 'image/jpeg', 4301421, '/anexos/2026/07/ato_250/foto_lesao_72.jpg', '2026-07-08 10:06', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (228, 108, 1, '2026-07-08 09:09', 37.19, 39.6, 129, 10, 'Come com apetite');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (35, 108, 1, '2026-07-08 09:31', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (35, 1), (35, 2), (35, 3);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (92, 35, 1, 13, 123.0, '2026-07-08 11:21', '2026-07-08 11:46', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (93, 35, 2, 12, 80.8, '2026-07-08 11:56', '2026-07-08 13:05', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (94, 35, 3, 14, 1.686, '2026-07-08 10:40', '2026-07-08 12:01', NULL);
UPDATE episodio SET data_hora_fim = '2026-07-08 09:53' WHERE id_episodio = 108;

-- Episódio 109 — Jade (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (109, 15, '2026-07-08 14:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (251, 109, 1, 1, NULL, '2026-07-08 14:38', 'Sintomas: check-up anual. Diagnóstico: otite externa. Plano: internamento para fluidoterapia.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (73, 251, 1, 'relatorio_consulta_73.pdf', 'application/pdf', 290644, '/anexos/2026/07/ato_251/relatorio_consulta_73.pdf', '2026-07-08 14:42', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (229, 109, 1, '2026-07-08 14:55', 2.54, 38.3, 258, NULL, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (252, 109, 4, 1, NULL, '2026-07-08 15:09', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (74, 252, 1, 'foto_ferida_74.jpg', 'image/jpeg', 4274256, '/anexos/2026/07/ato_252/foto_ferida_74.jpg', '2026-07-08 15:53', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (36, 109, 1, '2026-07-08 15:39', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (36, 6), (36, 7), (36, 8);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (95, 36, 6, 14, 61.8, '2026-07-08 17:24', '2026-07-08 17:51', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (96, 36, 7, 12, 15.2, '2026-07-08 19:05', '2026-07-08 19:38', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (97, 36, 8, 14, 653.0, '2026-07-08 18:32', '2026-07-08 19:47', NULL);
UPDATE episodio SET data_hora_fim = '2026-07-08 15:56' WHERE id_episodio = 109;

-- Episódio 110 — Zeus (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (110, 38, '2026-07-08 17:04');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (253, 110, 1, 3, 53, '2026-07-08 17:04', 'Sintomas: diarreia. Diagnóstico: animal saudável. Plano: análises de controlo em 1 mês.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (75, 253, 3, 'relatorio_consulta_75.pdf', 'application/pdf', 465091, '/anexos/2026/07/ato_253/relatorio_consulta_75.pdf', '2026-07-08 17:17', 'Consulta — Zeus');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (76, 253, 3, 'documento_cliente_76.pdf', 'application/pdf', 279595, '/anexos/2026/07/ato_253/documento_cliente_76.pdf', '2026-07-08 17:17', 'Consulta — Zeus');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (230, 110, 3, '2026-07-08 17:19', 7.55, 39.3, 60, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (254, 110, 10, 3, NULL, '2026-07-08 17:59', NULL);
UPDATE episodio SET data_hora_fim = '2026-07-08 18:56' WHERE id_episodio = 110;

-- Episódio 111 — Bolinha (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (111, 43, '2026-07-10 13:35');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (255, 111, 1, 5, 59, '2026-07-10 13:35', 'Sintomas: otite com corrimento. Diagnóstico: otite externa. Plano: pensos a cada 48 h.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (77, 255, 5, 'relatorio_consulta_77.pdf', 'application/pdf', 168639, '/anexos/2026/07/ato_255/relatorio_consulta_77.pdf', '2026-07-10 14:10', 'Consulta — Bolinha');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (231, 111, 5, '2026-07-10 13:48', 4.08, 38.2, 144, 25, 'Ligeira desidratação');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (19, 111, '2026-07-10 14:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (256, 111, 9, 5, NULL, '2026-07-10 15:07', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (78, 256, 5, 'relatorio_cirurgico_78.pdf', 'application/pdf', 493794, '/anexos/2026/07/ato_256/relatorio_cirurgico_78.pdf', '2026-07-10 15:58', 'Imagem do exame');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (79, 256, 5, 'foto_pos_op_79.jpg', 'image/jpeg', 3569786, '/anexos/2026/07/ato_256/foto_pos_op_79.jpg', '2026-07-10 16:35', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (232, 111, 9, '2026-07-10 19:07', 4.76, 38.0, 190, 39, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (233, 111, 9, '2026-07-11 15:07', NULL, 38.3, 151, 20, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (257, 111, 11, 9, NULL, '2026-07-11 15:17', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (234, 111, 10, '2026-07-12 04:07', NULL, 40.1, 155, 36, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (258, 111, 11, 10, NULL, '2026-07-12 04:17', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (235, 111, 7, '2026-07-12 17:07', NULL, 39.8, 201, 29, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (236, 111, 8, '2026-07-13 12:07', NULL, 40.3, 156, 37, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (259, 111, 5, 8, NULL, '2026-07-13 12:17', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (237, 111, 8, '2026-07-14 05:07', 7.44, 37.9, 147, NULL, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (238, 111, 7, '2026-07-15 01:07', 4.13, 39.8, 171, NULL, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (260, 111, 11, 7, NULL, '2026-07-15 01:17', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (239, 111, 7, '2026-07-15 19:07', NULL, 38.3, 181, 23, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (240, 111, 11, '2026-07-16 07:07', NULL, 39.2, 157, NULL, 'Ligeira desidratação');
UPDATE internamento SET data_hora_fim = '2026-07-16 19:07' WHERE id_internamento = 19;
UPDATE episodio SET data_hora_fim = '2026-07-16 20:03' WHERE id_episodio = 111;

-- Episódio 112 — Mia (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (112, 77, '2026-07-13 17:33');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (261, 112, 1, 6, 106, '2026-07-13 17:33', 'Sintomas: conjuntivite. Diagnóstico: doença renal crónica. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (80, 261, 6, 'relatorio_consulta_80.pdf', 'application/pdf', 403209, '/anexos/2026/07/ato_261/relatorio_consulta_80.pdf', '2026-07-13 18:46', 'Consulta — Mia');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (241, 112, 6, '2026-07-13 17:53', 1.49, 39.3, 294, NULL, 'Sem alterações');
UPDATE episodio SET data_hora_fim = '2026-07-13 18:10' WHERE id_episodio = 112;

-- Episódio 113 — Ruca (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (113, 61, '2026-07-14 10:09');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (262, 113, 1, 3, 82, '2026-07-14 10:09', 'Sintomas: otite com corrimento. Diagnóstico: conjuntivite bacteriana. Plano: internamento para fluidoterapia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (242, 113, 3, '2026-07-14 10:28', 2.15, 40.4, 211, 32, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (263, 113, 6, 3, NULL, '2026-07-14 11:05', NULL);
UPDATE episodio SET data_hora_fim = '2026-07-14 11:41' WHERE id_episodio = 113;

-- Episódio 114 — Tobi (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (114, 31, '2026-07-15 12:06');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (264, 114, 1, 3, 45, '2026-07-15 12:06', 'Sintomas: massa subcutânea. Diagnóstico: gastroenterite aguda. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (243, 114, 3, '2026-07-15 12:16', 6.03, 38.8, 156, 33, NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (20, 114, '2026-07-15 12:35');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (244, 114, 7, '2026-07-15 15:35', 4.23, 38.9, 183, NULL, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (245, 114, 7, '2026-07-16 13:35', 3.81, 37.7, 198, 40, 'Come com apetite');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (246, 114, 11, '2026-07-17 01:35', NULL, 39.3, 156, 27, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (247, 114, 11, '2026-07-18 00:35', NULL, 40.3, 146, 33, 'Mucosas rosadas, TRC < 2 s');
UPDATE internamento SET data_hora_fim = '2026-07-18 09:35' WHERE id_internamento = 20;
UPDATE episodio SET data_hora_fim = '2026-07-18 10:29' WHERE id_episodio = 114;

-- Episódio 115 — Max (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (115, 16, '2026-07-15 12:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (265, 115, 1, 1, 22, '2026-07-15 12:07', 'Sintomas: claudicação do membro posterior. Diagnóstico: otite externa. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (248, 115, 1, '2026-07-15 12:24', 3.52, 38.8, 179, NULL, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (37, 115, 1, '2026-07-15 12:53', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (37, 1);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (98, 37, 1, 13, 59.8, '2026-07-15 13:32', '2026-07-15 14:40', NULL);
UPDATE episodio SET data_hora_fim = '2026-07-15 14:00' WHERE id_episodio = 115;

-- Episódio 116 — Mia (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (116, 1, '2026-07-20 12:35');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (266, 116, 1, 6, 5, '2026-07-20 12:35', 'Sintomas: claudicação do membro posterior. Diagnóstico: otite externa. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (249, 116, 6, '2026-07-20 12:50', 3.15, 40.1, 185, 34, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (267, 116, 5, 10, NULL, '2026-07-20 13:12', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (268, 116, 2, 11, NULL, '2026-07-20 13:44', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (81, 268, 11, 'boletim_vacinas_81.pdf', 'application/pdf', 475445, '/anexos/2026/07/ato_268/boletim_vacinas_81.pdf', '2026-07-20 14:29', 'Imagem do exame');
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (21, 116, '2026-07-20 14:00');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (250, 116, 10, '2026-07-20 17:00', NULL, 40.1, 141, 25, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (269, 116, 11, 10, NULL, '2026-07-20 17:10', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (251, 116, 11, '2026-07-21 17:00', 3.37, 38.2, 146, NULL, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (270, 116, 4, 11, NULL, '2026-07-21 17:10', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (252, 116, 9, '2026-07-22 15:00', 4.5, 40.0, 158, 32, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (271, 116, 4, 9, NULL, '2026-07-22 15:10', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (82, 271, 9, 'foto_ferida_82.jpg', 'image/jpeg', 6129828, '/anexos/2026/07/ato_271/foto_ferida_82.jpg', '2026-07-22 16:13', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (253, 116, 7, '2026-07-23 05:00', NULL, 40.1, 193, 29, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (272, 116, 11, 7, NULL, '2026-07-23 05:10', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (254, 116, 7, '2026-07-23 22:00', 3.97, 37.7, 206, 25, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (255, 116, 8, '2026-07-24 17:00', NULL, 39.8, 220, 27, 'Ligeira desidratação');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (256, 116, 11, '2026-07-25 07:00', NULL, 39.1, 169, 23, 'Dor à palpação abdominal');
UPDATE internamento SET data_hora_fim = '2026-07-25 22:00' WHERE id_internamento = 21;
UPDATE episodio SET data_hora_fim = '2026-07-25 22:32' WHERE id_episodio = 116;

-- Episódio 117 — Lola (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (117, 58, '2026-07-27 13:52');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (273, 117, 1, 5, NULL, '2026-07-27 13:52', 'Sintomas: diarreia. Diagnóstico: gastroenterite aguda. Plano: pensos a cada 48 h.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (83, 273, 5, 'relatorio_consulta_83.pdf', 'application/pdf', 650114, '/anexos/2026/07/ato_273/relatorio_consulta_83.pdf', '2026-07-27 14:45', 'Consulta — Lola');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (257, 117, 5, '2026-07-27 14:00', 32.6, 39.5, 109, NULL, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (274, 117, 3, 5, NULL, '2026-07-27 14:17', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (38, 117, 5, '2026-07-27 14:46', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (38, 2), (38, 3), (38, 14);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (99, 38, 3, 14, 1.204, '2026-07-27 17:34', '2026-07-27 19:29', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (100, 38, 14, 12, 5.8, '2026-07-27 15:33', '2026-07-27 15:54', NULL);
UPDATE episodio SET data_hora_fim = '2026-07-27 16:09' WHERE id_episodio = 117;

-- Episódio 118 — Lola (Furão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (118, 54, '2026-08-04 21:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (275, 118, 1, 1, NULL, '2026-08-04 21:05', 'Sintomas: otite com corrimento. Diagnóstico: animal saudável. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (258, 118, 1, '2026-08-04 21:25', 0.82, 39.2, 222, 37, 'Ligeira desidratação');
UPDATE episodio SET data_hora_fim = '2026-08-04 22:17' WHERE id_episodio = 118;

-- Episódio 119 — Mia (Furão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (119, 46, '2026-08-05 14:26');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (276, 119, 1, 1, NULL, '2026-08-05 14:26', 'Sintomas: ferida na pata. Diagnóstico: hipertiroidismo. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (259, 119, 1, '2026-08-05 14:37', 1.1, 38.4, 235, 34, 'Animal alerta e responsivo');
UPDATE episodio SET data_hora_fim = '2026-08-05 15:13' WHERE id_episodio = 119;

-- Episódio 120 — Ruca (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (120, 61, '2026-08-06 15:04');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (277, 120, 1, 2, 83, '2026-08-06 15:04', 'Sintomas: dificuldade respiratória. Diagnóstico: otite externa. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (260, 120, 2, '2026-08-06 15:24', 2.18, 39.7, 189, 38, 'Mucosas rosadas, TRC < 2 s');
UPDATE episodio SET data_hora_fim = '2026-08-06 16:34' WHERE id_episodio = 120;

-- Episódio 121 — Lola (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (121, 58, '2026-08-11 16:01');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (278, 121, 1, 4, 77, '2026-08-11 16:01', 'Sintomas: prostração e falta de apetite. Diagnóstico: obstrução intestinal. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (261, 121, 4, '2026-08-11 16:15', 10.06, 37.8, 132, 24, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (279, 121, 3, 9, NULL, '2026-08-11 16:37', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (22, 121, '2026-08-11 16:47');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (262, 121, 8, '2026-08-11 18:47', 41.3, 37.9, 91, 15, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (263, 121, 10, '2026-08-12 12:47', NULL, 40.0, 128, 20, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (280, 121, 5, 10, NULL, '2026-08-12 12:57', NULL);
UPDATE internamento SET data_hora_fim = '2026-08-12 18:47' WHERE id_internamento = 22;
UPDATE episodio SET data_hora_fim = '2026-08-12 19:02' WHERE id_episodio = 121;

-- Episódio 122 — Lola (Furão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (122, 54, '2026-08-14 11:10');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (281, 122, 1, 2, 73, '2026-08-14 11:10', 'Sintomas: tosse seca. Diagnóstico: animal saudável. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (264, 122, 2, '2026-08-14 11:27', 0.74, 39.1, 250, 38, 'Sem alterações');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (39, 122, 2, '2026-08-14 11:33', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (39, 13);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (101, 39, 13, 14, 1.766, '2026-08-14 11:53', '2026-08-14 12:26', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (23, 122, '2026-08-14 11:49');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (265, 122, 7, '2026-08-14 16:49', 1.98, 40.5, 202, 35, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (282, 122, 5, 7, NULL, '2026-08-14 16:59', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (266, 122, 7, '2026-08-15 09:49', 1.82, 40.7, 200, 40, 'Animal alerta e responsivo');
UPDATE internamento SET data_hora_fim = '2026-08-15 10:49' WHERE id_internamento = 23;
UPDATE episodio SET data_hora_fim = '2026-08-15 11:04' WHERE id_episodio = 122;

-- Episódio 123 — Tobi (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (123, 31, '2026-08-31 16:26');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (283, 123, 1, 3, NULL, '2026-08-31 16:26', 'Sintomas: dificuldade respiratória. Diagnóstico: artrose. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (267, 123, 3, '2026-08-31 16:45', 6.0, 40.2, 202, 39, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (284, 123, 10, 3, NULL, '2026-08-31 16:57', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (40, 123, 3, '2026-08-31 17:15', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (40, 1), (40, 2), (40, 3), (40, 11), (40, 12);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (102, 40, 1, 14, 112.2, '2026-08-31 17:51', '2026-08-31 18:06', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (103, 40, 2, 13, 0.5, '2026-08-31 20:15', '2026-08-31 22:05', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (104, 40, 3, 14, 0.393, '2026-08-31 18:34', '2026-08-31 19:43', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (105, 40, 11, 12, 4.617, '2026-08-31 18:41', '2026-08-31 20:29', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (106, 40, 12, 12, 147.1, '2026-08-31 18:08', '2026-08-31 18:34', 'Amostra ligeiramente hemolisada');
UPDATE episodio SET data_hora_fim = '2026-08-31 18:27' WHERE id_episodio = 123;

-- Episódio 124 — Max (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (124, 16, '2026-09-07 15:02');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (285, 124, 1, 2, 23, '2026-09-07 15:02', 'Sintomas: prurido intenso. Diagnóstico: dermatite alérgica. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (268, 124, 2, '2026-09-07 15:13', 7.25, 39.8, 162, NULL, 'Dor à palpação abdominal');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (41, 124, 2, '2026-09-07 15:33', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (41, 6), (41, 7), (41, 8), (41, 9);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (107, 41, 6, 14, 40.7, '2026-09-07 19:09', '2026-09-07 20:10', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (108, 41, 7, 12, 9.4, '2026-09-07 16:12', '2026-09-07 17:58', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (109, 41, 8, 13, 366.7, '2026-09-07 17:58', '2026-09-07 18:01', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (110, 41, 9, 12, 4.84, '2026-09-07 17:24', '2026-09-07 19:07', 'Repetido para confirmação');
UPDATE episodio SET data_hora_fim = '2026-09-07 16:37' WHERE id_episodio = 124;

-- Episódio 125 — Kiko (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (125, 76, '2026-09-07 20:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (286, 125, 1, 2, NULL, '2026-09-07 20:38', 'Sintomas: prostração e falta de apetite. Diagnóstico: traqueobronquite. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (269, 125, 2, '2026-09-07 20:52', 5.83, 38.0, 181, 38, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (287, 125, 7, 2, NULL, '2026-09-07 21:19', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (84, 287, 2, 'relatorio_rx_84.pdf', 'application/pdf', 752279, '/anexos/2026/09/ato_287/relatorio_rx_84.pdf', '2026-09-07 21:55', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (288, 125, 2, 7, NULL, '2026-09-07 21:46', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (42, 125, 2, '2026-09-07 22:13', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (42, 13);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (111, 42, 13, 13, 3.781, '2026-09-07 22:45', '2026-09-07 23:31', NULL);
UPDATE episodio SET data_hora_fim = '2026-09-07 23:37' WHERE id_episodio = 125;

-- Episódio 126 — Mia (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (126, 1, '2026-09-14 12:26');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (289, 126, 1, 3, NULL, '2026-09-14 12:26', 'Sintomas: vómitos há 2 dias. Diagnóstico: infeção urinária. Plano: análises de controlo em 1 mês.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (85, 289, 3, 'documento_cliente_85.pdf', 'application/pdf', 596118, '/anexos/2026/09/ato_289/documento_cliente_85.pdf', '2026-09-14 12:35', 'Consulta — Mia');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (86, 289, 3, 'foto_lesao_86.jpg', 'image/jpeg', 4160025, '/anexos/2026/09/ato_289/foto_lesao_86.jpg', '2026-09-14 12:57', 'Consulta — Mia');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (270, 126, 3, '2026-09-14 12:32', 6.75, 39.5, 194, 24, 'Dor à palpação abdominal');
UPDATE episodio SET data_hora_fim = '2026-09-14 13:25' WHERE id_episodio = 126;

-- Episódio 127 — Zeus (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (127, 64, '2026-09-14 14:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (290, 127, 1, 5, 89, '2026-09-14 14:05', 'Sintomas: ingestão de corpo estranho. Diagnóstico: hipertiroidismo. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (87, 290, 5, 'foto_lesao_87.jpg', 'image/jpeg', 562802, '/anexos/2026/09/ato_290/foto_lesao_87.jpg', '2026-09-14 15:34', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (271, 127, 5, '2026-09-14 14:13', 15.44, 39.6, 134, 17, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (291, 127, 2, 7, NULL, '2026-09-14 14:50', NULL);
UPDATE episodio SET data_hora_fim = '2026-09-14 16:01' WHERE id_episodio = 127;

-- Episódio 128 — Canela (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (128, 6, '2026-09-16 09:33');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (292, 128, 1, 6, 12, '2026-09-16 09:33', 'Sintomas: check-up anual. Diagnóstico: traqueobronquite. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (272, 128, 6, '2026-09-16 09:44', 10.61, 38.9, 130, 10, NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (43, 128, 6, '2026-09-16 10:08', 'Urgente');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (43, 2), (43, 3), (43, 6), (43, 7), (43, 8), (43, 14);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (112, 43, 2, 13, 16.2, '2026-09-16 13:44', '2026-09-16 15:19', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (113, 43, 3, 14, 0.567, '2026-09-16 11:51', '2026-09-16 12:03', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (114, 43, 6, 14, 44.7, '2026-09-16 10:47', '2026-09-16 12:46', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (115, 43, 7, 12, 14.4, '2026-09-16 11:44', '2026-09-16 11:45', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (116, 43, 8, 14, 675.6, '2026-09-16 12:02', '2026-09-16 13:14', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (117, 43, 14, 14, 5.2, '2026-09-16 13:04', '2026-09-16 14:37', NULL);
UPDATE episodio SET data_hora_fim = '2026-09-16 11:04' WHERE id_episodio = 128;

-- Episódio 129 — Óscar (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (129, 2, '2026-09-21 10:06');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (293, 129, 1, 4, 6, '2026-09-21 10:06', 'Sintomas: massa subcutânea. Diagnóstico: animal saudável. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (273, 129, 4, '2026-09-21 10:21', 2.12, 37.9, 68, 17, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (294, 129, 5, 9, NULL, '2026-09-21 10:47', NULL);
UPDATE episodio SET data_hora_fim = '2026-09-21 11:06' WHERE id_episodio = 129;

-- Episódio 130 — Luna (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (130, 45, '2026-09-23 11:38');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (295, 130, 1, 1, 62, '2026-09-23 11:38', 'Sintomas: prurido intenso. Diagnóstico: laceração cutânea. Plano: cirurgia programada.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (274, 130, 1, '2026-09-23 11:45', 6.96, 39.2, 159, NULL, 'Dor à palpação abdominal');
UPDATE episodio SET data_hora_fim = '2026-09-23 12:51' WHERE id_episodio = 130;

-- Episódio 131 — Mia (Furão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (131, 46, '2026-09-29 15:00');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (296, 131, 1, 5, 66, '2026-09-29 15:00', 'Sintomas: conjuntivite. Diagnóstico: conjuntivite bacteriana. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (275, 131, 5, '2026-09-29 15:10', 1.56, 37.5, 200, 31, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (297, 131, 8, 5, NULL, '2026-09-29 15:47', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (88, 297, 5, 'relatorio_eco_88.pdf', 'application/pdf', 705710, '/anexos/2026/09/ato_297/relatorio_eco_88.pdf', '2026-09-29 16:16', 'Ecografia — Mia');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (89, 297, 5, 'eco_89.jpg', 'image/jpeg', 6819051, '/anexos/2026/09/ato_297/eco_89.jpg', '2026-09-29 15:50', 'Ecografia — Mia');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (298, 131, 5, 8, NULL, '2026-09-29 16:18', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (44, 131, 5, '2026-09-29 16:48', 'Controlo');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (44, 9), (44, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (118, 44, 9, 12, 7.315, '2026-09-29 20:33', '2026-09-29 21:26', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (119, 44, 10, 14, 2.548, '2026-09-29 19:52', '2026-09-29 20:36', 'Repetido para confirmação');
UPDATE episodio SET data_hora_fim = '2026-09-29 17:04' WHERE id_episodio = 131;

-- Episódio 132 — Pintas (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (132, 28, '2026-10-02 10:03');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (299, 132, 1, 6, 39, '2026-10-02 10:03', 'Sintomas: ferida na pata. Diagnóstico: animal saudável. Plano: cirurgia programada.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (90, 299, 6, 'relatorio_consulta_90.pdf', 'application/pdf', 385987, '/anexos/2026/10/ato_299/relatorio_consulta_90.pdf', '2026-10-02 11:20', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (276, 132, 6, '2026-10-02 10:09', 2.8, 40.5, 221, 43, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (300, 132, 5, 6, NULL, '2026-10-02 10:33', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (301, 132, 3, 11, NULL, '2026-10-02 11:13', NULL);
UPDATE episodio SET data_hora_fim = '2026-10-02 11:28' WHERE id_episodio = 132;

-- Episódio 133 — Max (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (133, 16, '2026-10-02 12:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (302, 133, 1, 4, 24, '2026-10-02 12:05', 'Sintomas: ferida na pata. Diagnóstico: doença renal crónica. Plano: cirurgia programada.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (91, 302, 4, 'relatorio_consulta_91.pdf', 'application/pdf', 430069, '/anexos/2026/10/ato_302/relatorio_consulta_91.pdf', '2026-10-02 12:54', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (277, 133, 4, '2026-10-02 12:13', 3.41, 40.1, 146, NULL, 'Sem alterações');
UPDATE episodio SET data_hora_fim = '2026-10-02 13:38' WHERE id_episodio = 133;

-- Episódio 134 — Bela (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (134, 25, '2026-10-09 12:05');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (303, 134, 1, 5, 35, '2026-10-09 12:05', 'Sintomas: conjuntivite. Diagnóstico: infeção urinária. Plano: internamento para fluidoterapia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (278, 134, 5, '2026-10-09 12:24', 39.46, 40.2, 101, 27, 'Sem alterações');
UPDATE episodio SET data_hora_fim = '2026-10-09 13:16' WHERE id_episodio = 134;

-- Episódio 135 — Riscas (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (135, 3, '2026-10-12 11:30');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (304, 135, 1, 2, 8, '2026-10-12 11:30', 'Sintomas: massa subcutânea. Diagnóstico: obstrução intestinal. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (279, 135, 2, '2026-10-12 11:46', 24.7, 38.8, 127, 28, 'Come com apetite');
UPDATE episodio SET data_hora_fim = '2026-10-12 12:35' WHERE id_episodio = 135;

-- Episódio 136 — Ruca (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (136, 61, '2026-10-13 15:07');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (305, 136, 1, 3, 84, '2026-10-13 15:07', 'Sintomas: tosse seca. Diagnóstico: artrose. Plano: limpeza auricular diária.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (280, 136, 3, '2026-10-13 15:12', 1.29, 40.4, 288, 55, 'Dor à palpação abdominal');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (45, 136, 3, '2026-10-13 15:21', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (45, 6), (45, 7), (45, 8), (45, 9), (45, 10);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (120, 45, 6, 13, 40.3, '2026-10-13 17:31', '2026-10-13 18:24', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (121, 45, 7, 12, 9.4, '2026-10-13 17:04', '2026-10-13 18:04', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (122, 45, 8, 13, 458.1, '2026-10-13 19:04', '2026-10-13 19:18', 'Amostra ligeiramente hemolisada');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (123, 45, 9, 14, 5.717, '2026-10-13 16:32', '2026-10-13 17:07', NULL);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (124, 45, 10, 12, 3.485, '2026-10-13 15:45', '2026-10-13 16:35', NULL);
UPDATE episodio SET data_hora_fim = '2026-10-13 15:39' WHERE id_episodio = 136;

-- Episódio 137 — Lua (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (137, 59, '2026-10-26 12:02');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (306, 137, 1, 4, 79, '2026-10-26 12:02', 'Sintomas: prostração e falta de apetite. Diagnóstico: obstrução intestinal. Plano: análises de controlo em 1 mês.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (281, 137, 4, '2026-10-26 12:15', 2.95, 39.7, 151, 40, 'Sem alterações');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (307, 137, 8, 4, NULL, '2026-10-26 12:44', NULL);

-- Episódio 138 — Luna (Cão)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (138, 68, '2026-10-26 14:35');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (308, 138, 1, 4, 93, '2026-10-26 14:35', 'Sintomas: vómitos há 2 dias. Diagnóstico: diabetes mellitus. Plano: pensos a cada 48 h.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (282, 138, 4, '2026-10-26 14:40', 5.77, 37.8, 111, 19, 'Ligeira desidratação');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (46, 138, 4, '2026-10-26 14:52', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (46, 11), (46, 12);

-- Episódio 139 — Estrela (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (139, 34, '2026-10-27 09:03');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (309, 139, 1, 3, 114, '2026-10-27 09:03', 'Sintomas: conjuntivite. Diagnóstico: hipertiroidismo. Plano: dieta gastrointestinal e reavaliação em 7 dias.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (283, 139, 3, '2026-10-27 09:17', 5.7, 39.1, 174, 34, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (310, 139, 2, 3, NULL, '2026-10-27 09:35', NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (311, 139, 3, 8, NULL, '2026-10-27 09:51', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (47, 139, 3, '2026-10-27 10:02', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (47, 1);

-- Episódio 140 — Matilde (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (140, 63, '2026-10-27 10:12');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (312, 140, 1, 5, NULL, '2026-10-27 10:12', 'Sintomas: ingestão de corpo estranho. Diagnóstico: obstrução intestinal. Plano: sem tratamento; próxima vacina em 1 ano.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (284, 140, 5, '2026-10-27 10:19', 4.14, 37.8, 190, 23, 'Come com apetite');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (313, 140, 8, 5, NULL, '2026-10-27 10:36', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (92, 313, 5, 'eco_92.jpg', 'image/jpeg', 6949295, '/anexos/2026/10/ato_313/eco_92.jpg', '2026-10-27 11:54', 'Imagem do exame');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (48, 140, 5, '2026-10-27 11:05', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (48, 11), (48, 12);
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (125, 48, 11, 12, 6.576, '2026-10-27 11:55', '2026-10-27 13:03', 'Repetido para confirmação');
INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido, data_hora_realizacao, data_hora_registo, notas) VALUES (126, 48, 12, 14, 153.4, '2026-10-27 12:44', '2026-10-27 12:46', NULL);

-- Episódio 141 — Bolinha (Outro)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (141, 67, '2026-10-28 09:03');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (314, 141, 1, 4, 113, '2026-10-28 09:03', 'Sintomas: vacinação de rotina. Diagnóstico: doença renal crónica. Plano: antibioterapia 10 dias (receita PEMV).');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (285, 141, 4, '2026-10-28 09:09', 39.65, 35.6, 129, 39, NULL);

-- Episódio 142 — Max (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (142, 16, '2026-11-02 12:03');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (315, 142, 1, 2, 112, '2026-11-02 12:03', 'Sintomas: otite com corrimento. Diagnóstico: laceração cutânea. Plano: anti-inflamatório 5 dias e repouso.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (286, 142, 2, '2026-11-02 12:18', 5.85, 38.0, 180, 39, 'Dor à palpação abdominal');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (316, 142, 7, 2, NULL, '2026-11-02 12:46', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (93, 316, 2, 'rx_93.png', 'image/png', 3659587, '/anexos/2026/11/ato_316/rx_93.png', '2026-11-02 12:52', 'Radiografia — Max');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (94, 316, 2, 'rx_94.png', 'image/png', 6495155, '/anexos/2026/11/ato_316/rx_94.png', '2026-11-02 14:03', 'Imagem do exame');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (317, 142, 3, 10, NULL, '2026-11-02 13:01', NULL);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (24, 142, '2026-11-02 13:12');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (287, 142, 8, '2026-11-02 17:12', 7.96, 39.9, 192, 29, 'Sem alterações');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (288, 142, 7, '2026-11-03 09:12', NULL, 37.9, 191, 22, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (289, 142, 9, '2026-11-04 03:12', NULL, 38.9, 148, NULL, NULL);
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (318, 142, 5, 9, NULL, '2026-11-04 03:22', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (290, 142, 8, '2026-11-04 16:12', NULL, 38.1, 193, NULL, 'Come com apetite');

-- Episódio 143 — Pirata (Gato)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (143, 57, '2026-11-02 15:33');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (319, 143, 1, 5, 111, '2026-11-02 15:33', 'Sintomas: vacinação de rotina. Diagnóstico: animal saudável. Plano: pensos a cada 48 h.');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (95, 319, 5, 'documento_cliente_95.pdf', 'application/pdf', 593367, '/anexos/2026/11/ato_319/documento_cliente_95.pdf', '2026-11-02 15:46', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (291, 143, 5, '2026-11-02 15:43', 6.47, 39.4, 156, 29, 'Ligeira desidratação');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (320, 143, 3, 5, NULL, '2026-11-02 15:54', NULL);
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (49, 143, 5, '2026-11-02 16:18', NULL);
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (49, 6), (49, 7), (49, 8), (49, 9), (49, 11), (49, 12);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (25, 143, '2026-11-02 16:50');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (321, 143, 9, 5, NULL, '2026-11-02 17:50', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (96, 321, 5, 'relatorio_cirurgico_96.pdf', 'application/pdf', 566346, '/anexos/2026/11/ato_321/relatorio_cirurgico_96.pdf', '2026-11-02 18:14', 'Cirurgia — Pirata');
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (97, 321, 5, 'consentimento_97.pdf', 'application/pdf', 620567, '/anexos/2026/11/ato_321/consentimento_97.pdf', '2026-11-02 19:02', 'Entregue pelo cliente');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (292, 143, 8, '2026-11-02 20:50', NULL, 38.8, 142, 38, NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (293, 143, 7, '2026-11-03 18:50', NULL, 39.4, 213, NULL, 'Mucosas rosadas, TRC < 2 s');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (322, 143, 4, 7, NULL, '2026-11-03 19:00', NULL);
INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload, descricao) VALUES (98, 322, 7, 'foto_ferida_98.jpg', 'image/jpeg', 7290989, '/anexos/2026/11/ato_322/foto_ferida_98.jpg', '2026-11-03 20:25', 'Imagem do exame');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (294, 143, 8, '2026-11-04 07:50', 6.04, 37.9, 192, 28, 'Dor à palpação abdominal');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (295, 143, 8, '2026-11-05 01:50', 6.5, 38.8, 155, 40, 'Animal alerta e responsivo');

-- Episódio 144 — Jade (Coelho)
INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio) VALUES (144, 15, '2026-11-04 11:12');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (323, 144, 1, 3, NULL, '2026-11-04 11:12', 'Sintomas: dor abdominal. Diagnóstico: laceração cutânea. Plano: insulinoterapia e monitorização de glicemia.');
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (296, 144, 3, '2026-11-04 11:25', 2.21, 40.9, 138, 33, 'Dor à palpação abdominal');
INSERT INTO pedido_laboratorial (id_pedido, id_episodio, id_veterinario, data_hora_pedido, notas) VALUES (50, 144, 3, '2026-11-04 11:45', 'Em jejum');
INSERT INTO linha_pedido (id_pedido, id_analise) VALUES (50, 6), (50, 7), (50, 8);
INSERT INTO internamento (id_internamento, id_episodio, data_hora_inicio) VALUES (26, 144, '2026-11-04 12:15');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (324, 144, 9, 3, NULL, '2026-11-04 13:15', NULL);
INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, peso, temperatura, freq_cardiaca, freq_respiratoria, notas) VALUES (297, 144, 9, '2026-11-04 14:15', 1.23, 40.4, 193, 30, 'Animal alerta e responsivo');
INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora, notas) VALUES (325, 144, 4, 9, NULL, '2026-11-04 14:25', NULL);

-- Desativações (depois de os registos associados existirem) --------------------
UPDATE colaborador SET ativo = FALSE WHERE id_pessoa IN (19, 20);
UPDATE cliente SET ativo = FALSE WHERE id_pessoa IN (31, 32, 33, 34);

COMMIT;

-- =============================================================================
-- CASOS-LIMITE
-- =============================================================================
-- Casos-limite permitidos, incluídos nos dados acima:
--   - episódios abertos e animais atualmente internados (sem alta);
--   - análises pedidas ainda sem resultado;
--   - consultas urgentes, sem marcação;
--   - marcações a que o animal faltou (sem consulta) e marcações futuras;
--   - marcações seguidas do mesmo veterinário (uma termina quando a outra começa);
--   - animais sem microchip, sem data de nascimento ou sem episódios;
--   - clientes sem animais e pessoas que são cliente e colaborador;
--   - espécie "Outro" para animais pouco comuns;
--   - observações só com alguns valores registados;
--   - colaboradores e clientes desativados depois de terem registos associados.
--
-- Casos-limite rejeitados pelas restrições e triggers (comentados, para não
-- impedir a inserção dos dados). Para os testar, retirar o comentário e
-- executar cada bloco; cada um deve dar erro e o ROLLBACK repõe o estado.
-- O T12 usa a view vw_analises_pendentes, criada no views.sql.
--
-- T01. RN14 — marcação sobreposta para o mesmo veterinário.
-- BEGIN;
-- INSERT INTO marcacao (id_marcacao, id_animal, id_veterinario, id_registo, data_hora_inicio, data_hora_fim)
-- SELECT 9999, id_animal, id_veterinario, id_registo,
--        data_hora_inicio + INTERVAL '10 minutes', data_hora_fim + INTERVAL '10 minutes'
--   FROM marcacao WHERE id_marcacao = 1;
-- ROLLBACK;

-- T02. RN13 — marcação com fim anterior ao início.
-- BEGIN;
-- INSERT INTO marcacao VALUES (9999, 1, 1, 15, TIMESTAMP '2027-01-04 10:00', TIMESTAMP '2027-01-04 09:30');
-- ROLLBACK;

-- T03. RN08 — marcação atribuída a um veterinário desativado.
-- BEGIN;
-- INSERT INTO marcacao
-- SELECT 9999, 1, c.id_pessoa, 15, TIMESTAMP '2027-01-04 08:00', TIMESTAMP '2027-01-04 08:30'
--   FROM colaborador AS c JOIN veterinario AS v ON v.id_pessoa = c.id_pessoa
--  WHERE NOT c.ativo;
-- ROLLBACK;

-- T04. RN15 — eliminar uma marcação que já originou uma consulta.
-- BEGIN;
-- DELETE FROM marcacao WHERE id_marcacao = (SELECT MIN(id_marcacao) FROM ato_clinico);
-- ROLLBACK;

-- T05. RN24 / RN25 — consulta registada por um enfermeiro.
-- BEGIN;
-- INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, data_hora)
-- SELECT 9999, e.id_episodio, 1, 7, e.data_hora_inicio + INTERVAL '1 hour'
--   FROM episodio AS e
--  WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
-- ROLLBACK;

-- T06. RN17 — consulta associada a uma marcação de outro animal.
-- BEGIN;
-- INSERT INTO ato_clinico (id_ato, id_episodio, id_servico, id_colaborador, id_marcacao, data_hora)
-- SELECT 9999, e.id_episodio, 1, 1,
--        (SELECT MIN(m.id_marcacao) FROM marcacao AS m
--          WHERE m.id_animal <> e.id_animal
--            AND NOT EXISTS (SELECT * FROM ato_clinico AS a WHERE a.id_marcacao = m.id_marcacao)),
--        e.data_hora_inicio + INTERVAL '1 hour'
--   FROM episodio AS e
--  WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
-- ROLLBACK;

-- T07. RN22 — observação num episódio encerrado.
-- BEGIN;
-- INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, temperatura)
-- SELECT 9999, e.id_episodio, 7, e.data_hora_fim, 38.5
--   FROM episodio AS e WHERE e.id_episodio = 1;
-- ROLLBACK;

-- T08. RN27 — observação com data anterior ao início do episódio.
-- BEGIN;
-- INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, temperatura)
-- SELECT 9999, e.id_episodio, 7, e.data_hora_inicio - INTERVAL '1 day', 38.5
--   FROM episodio AS e
--  WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
-- ROLLBACK;

-- T09. RN26 — observação registada por um técnico de laboratório.
-- BEGIN;
-- INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora, temperatura)
-- SELECT 9999, e.id_episodio, 12, e.data_hora_inicio + INTERVAL '1 hour', 38.5
--   FROM episodio AS e
--  WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
-- ROLLBACK;

-- T10. Observação sem nenhum valor registado.
-- BEGIN;
-- INSERT INTO observacao (id_observacao, id_episodio, id_colaborador, data_hora)
-- SELECT 9999, e.id_episodio, 7, e.data_hora_inicio + INTERVAL '1 hour'
--   FROM episodio AS e
--  WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
-- ROLLBACK;

-- T11. RN29 — anexo carregado antes da realização do ato.
-- BEGIN;
-- INSERT INTO anexo (id_anexo, id_ato, id_colaborador, nome, tipo_mime, tamanho_bytes, caminho, data_hora_upload)
-- SELECT 9999, a.id_ato, 7, 'teste.pdf', 'application/pdf', 1000, '/anexos/teste.pdf', a.data_hora - INTERVAL '1 hour'
--   FROM ato_clinico AS a
--  WHERE a.id_ato = (SELECT MAX(id_ato) FROM ato_clinico);
-- ROLLBACK;

-- T12. RN34 — resultado registado por quem não é técnico de laboratório
-- (numa análise pendente de um episódio aberto).
-- BEGIN;
-- INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido,
--                        data_hora_realizacao, data_hora_registo)
-- SELECT 9999, p.id_pedido, MIN(p.id_analise), 7, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
--   FROM vw_analises_pendentes AS p
--  WHERE p.id_pedido = (SELECT MIN(v.id_pedido)
--                         FROM vw_analises_pendentes AS v
--                         JOIN episodio AS e ON v.id_episodio = e.id_episodio
--                        WHERE e.data_hora_fim IS NULL)
--  GROUP BY p.id_pedido;
-- ROLLBACK;

-- T13. RN33 — resultado de uma análise que não consta do pedido (pedido de um
-- episódio aberto).
-- BEGIN;
-- INSERT INTO resultado (id_resultado, id_pedido, id_analise, id_colaborador, valor_obtido,
--                        data_hora_realizacao, data_hora_registo)
-- SELECT 9999, pl.id_pedido, al.id_analise, 12, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
--   FROM pedido_laboratorial AS pl, analise AS al
--  WHERE pl.id_pedido = (SELECT MIN(p2.id_pedido)
--                          FROM pedido_laboratorial AS p2
--                          JOIN episodio AS e ON p2.id_episodio = e.id_episodio
--                         WHERE e.data_hora_fim IS NULL)
--    AND al.id_analise = (SELECT MIN(a2.id_analise) FROM analise AS a2
--                          WHERE NOT EXISTS (SELECT * FROM linha_pedido AS lp
--                                             WHERE lp.id_pedido = pl.id_pedido
--                                               AND lp.id_analise = a2.id_analise));
-- ROLLBACK;

-- T14. RN21 — segundo episódio aberto para o mesmo animal.
-- BEGIN;
-- INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio)
-- SELECT 9999, e.id_animal, CURRENT_TIMESTAMP
--   FROM episodio AS e
--  WHERE e.id_episodio = (SELECT MAX(id_episodio) FROM episodio WHERE data_hora_fim IS NULL);
-- ROLLBACK;

-- T15. RN19 — encerrar um episódio sem consulta.
-- BEGIN;
-- INSERT INTO episodio (id_episodio, id_animal, data_hora_inicio)
-- SELECT 9999, MIN(an.id_animal), CURRENT_TIMESTAMP
--   FROM animal AS an
--  WHERE NOT EXISTS (SELECT * FROM episodio AS e WHERE e.id_animal = an.id_animal);
-- UPDATE episodio SET data_hora_fim = CURRENT_TIMESTAMP WHERE id_episodio = 9999;
-- ROLLBACK;

-- T16. RN20 — encerrar um episódio com internamento sem alta.
-- BEGIN;
-- UPDATE episodio SET data_hora_fim = CURRENT_TIMESTAMP
--  WHERE id_episodio = (SELECT MIN(id_episodio) FROM internamento WHERE data_hora_fim IS NULL);
-- ROLLBACK;

-- T17. RN04 — novo animal para um cliente desativado.
-- BEGIN;
-- INSERT INTO animal (id_animal, id_cliente, nome, especie, sexo)
-- SELECT 9999, MIN(id_pessoa), 'Teste', 'Gato', 'F' FROM cliente WHERE NOT ativo;
-- ROLLBACK;

-- T18. Espécie fora da lista de espécies aceites.
-- BEGIN;
-- INSERT INTO animal (id_animal, id_cliente, nome, especie, sexo)
-- SELECT 9999, MIN(id_pessoa), 'Teste', 'Dinossauro', 'F' FROM cliente WHERE ativo;
-- ROLLBACK;

-- T19. RN07 — registar como veterinário um colaborador com outra função.
-- BEGIN;
-- INSERT INTO veterinario VALUES (7, 'OMV9999');
-- ROLLBACK;

-- T20. RN02 — pessoa com um NIF já registado.
-- BEGIN;
-- INSERT INTO pessoa (id_pessoa, nome, nif, telefone)
-- SELECT 9999, 'Teste', nif, '912000000' FROM pessoa WHERE id_pessoa = 1;
-- ROLLBACK;

-- T21. RN01 / RN05 — eliminar um cliente com animais.
-- BEGIN;
-- DELETE FROM cliente WHERE id_pessoa = (SELECT MIN(id_cliente) FROM animal);
-- ROLLBACK;
