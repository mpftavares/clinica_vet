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
// Coleção "episodios" — um documento por episódio clínico. Um episódio é
// lido como um todo (histórico clínico, Q11). Ficam EMBEDDED os dados
// que só existem dentro do episódio:
//   - internamento
//   - observações
//   - atos clínicos e, dentro de cada ato, os seus anexos
//   - pedidos laboratoriais -> análises pedidas (linha_pedido) -> resultado
//
// As 8 tabelas do registo clínico do PostgreSQL (episodio, internamento,
// observacao, ato_clinico, anexo, pedido_laboratorial, linha_pedido,
// resultado) passam a uma única coleção.
//
// Referências para o PostgreSQL: animal, colaborador, serviço e análise
// são entidades que existem por si só, independentemente do episódio,
// sendo referenciadas pelo id. Junto ao id guarda-se uma cópia apenas dos
// atributos usados pelas queries e que não mudam (ou que devem ficar congelados
// à data do registo):
//   - animal {id_animal, nome, especie, id_cliente}
//   - colaborador {nome}
//   - servico {designacao}
//   - analise {nome, unidade, valores de referência}
//
// Dados que mudam (telefone, email, morada, "ativo") não são copiados.
//
// Identificadores: o _id de cada episódio é o id_episodio do PostgreSQL (e os
// subdocumentos mantêm os seus ids). Isto preserva a correspondência entre os
// dois sistemas, usada na migração e nos testes de consistência.
//
// Obrigatoriedade: é required o que era NOT NULL no PostgreSQL.
// Não são required os campos que aceitavam NULL nem as relações que podiam
// ter zero elementos.
// Os campos sem valor são omitidos (em vez de NULL como em SQL).
//
// Alternativa NoSQL (não implementada): as observações registadas pelos
// colaboradores ficam embedded no episódio, porque são poucas por episódio.
// Se a clínica passasse a recolher os sinais vitais diretamente dos monitores
// durante o internamento (temperatura, frequência cardíaca, frequência
// respiratória a cada poucos segundos), esses dados seriam mais adequados a
// uma base de dados time-series:
//   - grande volume e escrita contínua (append-only), sem alterações nem
//     eliminações;
//   - consultas sempre por intervalo de tempo (ex.: média da temperatura de
//     5 em 5 minutos na última hora);
//   - compressão dos timestamps e políticas de retenção (ex.: guardar os
//     valores brutos durante 7 dias e as médias durante 1 ano).
// Embedded no episódio, estas medições fariam crescer o documento sem limite.
// O MongoDB também suporta time-series collections, que serviriam para um
// volume moderado; uma base de dados time-series dedicada (InfluxDB, TimescaleDB) 
// justifica-se pelas agregações contínuas e pela retenção por níveis 
// (valores brutos -> médias), que o MongoDB não faz.

db = db.getSiblingDB('clinica_vet');

db.episodios.drop();

// Referência a um colaborador (usada nas observações, nos atos e nos
// resultados): id para o PostgreSQL e cópia do nome para identificar quem fez
// o quê nos resultados das queries.
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
				// Observações: só os valores medidos são guardados (em SQL, cada
				// linha tem várias colunas a NULL). Mesmos limites dos CHECK.
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
