// 1. ANÁLISE
// -----------------------------------------------------------------------------
// Passa para MongoDB o EPISÓDIO CLÍNICO.
//
// Ficam no PostgreSQL:
//   - pessoa
//   - cliente
//   - colaborador
//   - veterinário
//   - função
//   - serviço
//   - pode_realizar
//   - animal
//   - análise
//   - marcação
//
// Porque o episódio clínico:
//   - É lido como um todo. O histórico clínico de um animal (Q11) e a
//     consulta de um episódio juntam, em SQL, 8 tabelas (episodio,
//     internamento, observacao, ato_clinico, anexo, pedido_laboratorial,
//     linha_pedido, resultado). Num documento, o episódio lê-se numa única
//     operação, sem JOINs.
//   - A estrutura varia de episódio para episódio. Uma consulta simples tem
//     um ato e uma observação; um internamento tem dezenas de observações,
//     atos com anexos e pedidos com várias análises. Nas observações só se
//     preenchem os sinais medidos (em SQL ficam colunas a NULL) e as análises
//     pendentes não têm resultado. O esquema flexível guarda apenas o que
//     existe.
//   - Cresce de forma limitada. Um episódio tem poucas observações, atos e
//     pedidos e, depois de fechado, deixa de mudar.
//   - Os seus elementos não existem fora dele. Uma observação, um ato, um
//     anexo, um pedido ou um resultado pertencem sempre a um só episódio e
//     são criados e eliminados com ele.
//
// Porque o resto permanece no PostgreSQL:
//   - São dados partilhados por muitos episódios (o mesmo animal, o
//     mesmo colaborador, o mesmo serviço): existem antes e depois de qualquer
//     episódio e são alterados independentemente.
//   - Dependem de integridade referencial e de regras que consultam outras
//     linhas, verificadas pelo próprio PostgreSQL: chaves estrangeiras (uma
//     marcação só pode referir um animal que existe) e os triggers das
//     marcações (só colaboradores ativos, sem sobreposição de horários do
//     mesmo veterinário). O MongoDB não tem chaves estrangeiras e o
//     $jsonSchema só valida o próprio documento.
//   - As marcações são escritas concorrentes sobre a mesma agenda: a regra
//     "sem sobreposição" compara várias linhas e tem de ser verificada e gravada
//     como um todo, numa transação ACID, para que duas marcações simultâneas
//     não passem ambas a verificação.
//
// 2. MODELO E CORRESPONDÊNCIA COM O POSTGRESQL
// -----------------------------------------------------------------------------
// Coleção "episodios": um documento por episódio clínico. As 8 tabelas do
// registo clínico passam a uma única coleção:
//
//   PostgreSQL            MongoDB                       Relação  Opção
//   episodio              documento de "episodios"      -        -
//   internamento          internamento (subdocumento)   1:0..1   embedding
//   observacao            observacoes (array)           1:N      embedding
//   ato_clinico           atos (array)                  1:N      embedding
//   anexo                 atos.anexos (array)           1:N      embedding
//   pedido_laboratorial   pedidos (array)               1:N      embedding
//   linha_pedido          pedidos.analises (array)      1:N      embedding
//   resultado             pedidos.analises.resultado    1:0..1   embedding
//   animal                animal                        N:1      referencing
//   colaborador           *.colaborador, *.tecnico      N:1      referencing
//   veterinario           pedidos.veterinario           N:1      referencing
//   servico               atos.servico                  N:1      referencing
//   analise               pedidos.analises              N:1      referencing
//   marcacao              atos.id_marcacao              0..1:1   referencing
//
// Embedding nas relações 1:1 e 1:N em que a entidade relacionada só existe
// dentro do episódio: é lida sempre com o episódio e tem o mesmo ciclo de vida.
// Referencing para as entidades que existem por si só, partilhadas por muitos
// episódios: embedding duplicaria os dados em cada episódio e obrigaria a
// atualizar todas as cópias quando mudassem.
//
// Junto ao id de cada referência guarda-se uma cópia apenas dos atributos
// usados pelas queries (ou que devem ficar congelados à data do registo):
//   - animal {id_animal, nome, especie, id_cliente}
//   - colaborador / tecnico {id_colaborador, nome}
//   - veterinario {id_veterinario, nome}
//   - servico {id_servico, designacao}
//   - analise {id_analise, nome, unidade_medida, valores de referência}
//   - marcacao: só o id
//
// A cópia evita uma junção entre as duas bases de dados, por isso estes
// atributos ficam duplicados. Dados que mudam (telefone, email, morada,
// "ativo") não são copiados, por isso as cópias não ficam desatualizadas.
//
// Identificadores: o _id de cada episódio é o id_episodio do PostgreSQL (e os
// subdocumentos mantêm os seus ids). Isto preserva a correspondência entre os
// dois sistemas, usada na migração e nos testes de consistência.
//
// Obrigatoriedade: é required o que era NOT NULL no PostgreSQL; as relações
// que podiam ter zero elementos não são required. Os campos sem valor são
// omitidos (em vez de NULL).
//
// 3. ALTERNATIVAS NOSQL
// -----------------------------------------------------------------------------
// Alternativa NoSQL (não implementada): as observações registadas pelos
// colaboradores ficam embedded no episódio, porque são poucas por episódio.
// Se a clínica passasse a recolher os sinais vitais diretamente dos monitores
// durante o internamento (temperatura, frequência cardíaca, frequência
// respiratória a cada poucos segundos), esses dados seriam mais adequados a
// uma base de dados time-series (TSDB):
//   - grande volume e escrita contínua (append-only), sem alterações nem
//     eliminações;
//   - consultas sempre por intervalo de tempo (ex.: média da temperatura de
//     5 em 5 minutos na última hora);
//   - compressão dos timestamps e políticas de retenção (ex.: guardar os
//     valores brutos durante 7 dias e as médias durante 1 ano).
// Embedded no episódio, estas medições fariam crescer o documento sem limite.
// O MongoDB também suporta time-series collections, que serviriam para um
// volume moderado; uma TSDB dedicada (InfluxDB, TimescaleDB) justifica-se
// pelas agregações contínuas e pela retenção por níveis (valores brutos ->
// médias), que o MongoDB não faz.

db = db.getSiblingDB('clinica_vet');

db.episodios.drop();

// Referência a um colaborador (observações, atos e resultados).
const refColaborador = {
	bsonType: 'object',
	required: ['id_colaborador', 'nome'],
	properties: {
		id_colaborador: { bsonType: 'int' },
		nome: { bsonType: 'string' },
	},
};

// Tipos: VARCHAR -> string, INT -> int, NUMERIC -> double, TIMESTAMP -> date
db.createCollection('episodios', {
	validator: {
		$jsonSchema: {
			bsonType: 'object',
			required: ['_id', 'animal', 'data_hora_inicio'],
			properties: {
				_id: { bsonType: 'int', description: 'id_episodio do PostgreSQL' },
				animal: {
					bsonType: 'object',
					required: ['id_animal', 'nome', 'especie', 'id_cliente'],
					properties: {
						id_animal: { bsonType: 'int' },
						nome: { bsonType: 'string' },
						especie: {
							enum: [
								'Cão',
								'Gato',
								'Coelho',
								'Furão',
								'Ave',
								'Roedor',
								'Réptil',
								'Outro',
							],
						},
						id_cliente: { bsonType: 'int' },
					},
				},
				data_hora_inicio: { bsonType: 'date' },
				data_hora_fim: { bsonType: 'date' }, // ausente = aberto
				internamento: {
					bsonType: 'object',
					required: ['id_internamento', 'data_hora_inicio'],
					properties: {
						id_internamento: { bsonType: 'int' },
						data_hora_inicio: { bsonType: 'date' },
						data_hora_fim: { bsonType: 'date' }, // ausente = sem alta
					},
				},
				// Observações: mesmos limites dos CHECK.
				observacoes: {
					bsonType: 'array',
					items: {
						bsonType: 'object',
						required: ['id_observacao', 'data_hora', 'colaborador'],
						properties: {
							id_observacao: { bsonType: 'int' },
							data_hora: { bsonType: 'date' },
							colaborador: refColaborador,
							peso: { bsonType: 'double', minimum: 0.01 }, // ck_obs_peso
							temperatura: { bsonType: 'double', minimum: 0, maximum: 99 }, // ck_obs_temp
							freq_cardiaca: { bsonType: 'int', minimum: 0 }, // ck_obs_fc
							freq_respiratoria: { bsonType: 'int', minimum: 0 }, // ck_obs_fr
							notas: { bsonType: 'string' },
						},
					},
				},
				atos: {
					bsonType: 'array',
					items: {
						bsonType: 'object',
						required: ['id_ato', 'data_hora', 'servico', 'colaborador'],
						properties: {
							id_ato: { bsonType: 'int' },
							data_hora: { bsonType: 'date' },
							servico: {
								bsonType: 'object',
								required: ['id_servico', 'designacao'],
								properties: {
									id_servico: { bsonType: 'int' },
									designacao: { bsonType: 'string' },
								},
							},
							colaborador: refColaborador,
							id_marcacao: { bsonType: 'int' }, // referência para PostgreSQL
							notas: { bsonType: 'string' },
							anexos: {
								bsonType: 'array',
								items: {
									bsonType: 'object',
									required: [
										'id_anexo',
										'nome',
										'tipo_mime',
										'tamanho_bytes',
										'caminho',
										'data_hora_upload',
										'id_colaborador',
									],
									properties: {
										id_anexo: { bsonType: 'int' },
										nome: { bsonType: 'string' },
										tipo_mime: { bsonType: 'string' },
										tamanho_bytes: { bsonType: 'int', minimum: 1 }, // ck_anexo_tamanho
										caminho: { bsonType: 'string' },
										data_hora_upload: { bsonType: 'date' },
										descricao: { bsonType: 'string' },
										id_colaborador: { bsonType: 'int' },
									},
								},
							},
						},
					},
				},
				pedidos: {
					bsonType: 'array',
					items: {
						bsonType: 'object',
						required: ['id_pedido', 'data_hora_pedido', 'veterinario'],
						properties: {
							id_pedido: { bsonType: 'int' },
							data_hora_pedido: { bsonType: 'date' },
							veterinario: {
								bsonType: 'object',
								required: ['id_veterinario', 'nome'],
								properties: {
									id_veterinario: { bsonType: 'int' },
									nome: { bsonType: 'string' },
								},
							},
							notas: { bsonType: 'string' },
							// Cada elemento corresponde a uma linha_pedido
							analises: {
								bsonType: 'array',
								items: {
									bsonType: 'object',
									required: ['id_analise', 'nome', 'unidade_medida'],
									properties: {
										id_analise: { bsonType: 'int' },
										nome: { bsonType: 'string' },
										unidade_medida: { bsonType: 'string' },
										// Valores de referência congelados à data do pedido:
										// um resultado antigo continua a ser avaliado com os
										// valores em vigor quando foi pedido.
										valor_ref_min: { bsonType: 'double' },
										valor_ref_max: { bsonType: 'double' },
										// Ausente enquanto a análise está pendente (RF23).
										// Embedded na linha: cada linha tem no máximo um
										// resultado (UNIQUE (id_pedido, id_analise)).
										resultado: {
											bsonType: 'object',
											required: [
												'id_resultado',
												'tecnico',
												'valor_obtido',
												'data_hora_realizacao',
												'data_hora_registo',
											],
											properties: {
												id_resultado: { bsonType: 'int' },
												tecnico: refColaborador,
												valor_obtido: { bsonType: 'double' },
												data_hora_realizacao: { bsonType: 'date' },
												data_hora_registo: { bsonType: 'date' },
												notas: { bsonType: 'string' },
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	},
	validationLevel: 'strict', // valida todas as inserções e alterações
	validationAction: 'error', // rejeita as escritas inválidas
});

print('Coleções criadas: ' + db.getCollectionNames().sort().join(', '));
