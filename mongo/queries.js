// Cada query é equivalente em MongoDB a uma query SQL da Entrega 2

// Q01. Animais com mais de três episódios clínicos nos últimos 12 meses.
db.episodios.aggregate([
	{
		$match: {
			data_hora_inicio: {
				$gte: new Date(new Date().setMonth(new Date().getMonth() - 12)),
			},
		},
	},
	{
		$group: {
			_id: {
				id_animal: '$animal.id_animal',
				animal: '$animal.nome',
				especie: '$animal.especie',
				id_cliente: '$animal.id_cliente',
			},
			n_episodios: { $sum: 1 },
		},
	},
	{ $match: { n_episodios: { $gt: 3 } } },
	{
		$project: {
			_id: 0,
			id_animal: '$_id.id_animal',
			animal: '$_id.animal',
			especie: '$_id.especie',
			id_cliente: '$_id.id_cliente',
			n_episodios: '$n_episodios',
		},
	},
	{ $sort: { n_episodios: -1, animal: 1 } },
]);

// Q02. Veterinários que realizaram mais consultas em cada mês (últimos 12
// meses), com o número de consultas com marcação e de urgências sem marcação.
db.episodios.aggregate([
	{ $unwind: '$atos' },
	{
		$match: {
			'atos.servico.designacao': 'Consulta',
			'atos.data_hora': {
				$gte: new Date(new Date().setMonth(new Date().getMonth() - 12)),
			},
		},
	},
	{
		$group: {
			_id: {
				ano: { $year: '$atos.data_hora' },
				mes: { $month: '$atos.data_hora' },
				id_veterinario: '$atos.colaborador.id_colaborador',
				veterinario: '$atos.colaborador.nome',
			},
			total: { $sum: 1 },
			com_marcacao: {
				$sum: { $cond: [{ $gt: ['$atos.id_marcacao', null] }, 1, 0] },
			},
		},
	},
	{
		$group: {
			_id: { ano: '$_id.ano', mes: '$_id.mes' },
			maximo: { $max: '$total' },
			veterinarios: {
				$push: {
					veterinario: '$_id.veterinario',
					total: '$total',
					com_marcacao: '$com_marcacao',
				},
			},
		},
	},
	{ $unwind: '$veterinarios' },
	{ $match: { $expr: { $eq: ['$veterinarios.total', '$maximo'] } } },
	{
		$project: {
			_id: 0,
			ano: '$_id.ano',
			mes: '$_id.mes',
			veterinario: '$veterinarios.veterinario',
			total: '$veterinarios.total',
			com_marcacao: '$veterinarios.com_marcacao',
			urgencias: {
				$subtract: ['$veterinarios.total', '$veterinarios.com_marcacao'],
			},
		},
	},
	{ $sort: { ano: 1, mes: 1, veterinario: 1 } },
]);

// Q05. Animais que, durante o internamento, tiveram observações com
// temperatura acima de 40 ºC, e análises pedidas nesses episódios.
db.episodios.aggregate([
	{ $match: { internamento: { $exists: true } } },
	{ $addFields: { temp_maxima: { $max: '$observacoes.temperatura' } } },
	{ $unwind: { path: '$pedidos', preserveNullAndEmptyArrays: true } },
	{ $unwind: { path: '$pedidos.analises', preserveNullAndEmptyArrays: true } },
	{ $unwind: '$observacoes' },
	{
		$match: {
			'observacoes.temperatura': { $gt: 40 },
			$expr: {
				$gte: ['$observacoes.data_hora', '$internamento.data_hora_inicio'],
			},
			$or: [
				{ 'internamento.data_hora_fim': { $exists: false } },
				{
					$expr: {
						$lte: ['$observacoes.data_hora', '$internamento.data_hora_fim'],
					},
				},
			],
		},
	},
	{
		$group: {
			_id: {
				id_animal: '$animal.id_animal',
				animal: '$animal.nome',
				especie: '$animal.especie',
				id_episodio: '$_id',
				temp_maxima: '$temp_maxima',
				analise_pedida: '$pedidos.analises.nome',
			},
		},
	},
	{
		$project: {
			_id: 0,
			id_animal: '$_id.id_animal',
			animal: '$_id.animal',
			especie: '$_id.especie',
			id_episodio: '$_id.id_episodio',
			temp_maxima: '$_id.temp_maxima',
			analise_pedida: '$_id.analise_pedida',
		},
	},
	{ $sort: { animal: 1, id_episodio: 1, analise_pedida: 1 } },
]);

// Q06. Serviços com mais anexos nos últimos seis meses e espaço ocupado, por
// tipo de anexo.
db.episodios.aggregate([
	{ $unwind: '$atos' },
	{ $unwind: '$atos.anexos' },
	{
		$match: {
			'atos.anexos.data_hora_upload': {
				$gte: new Date(new Date().setMonth(new Date().getMonth() - 6)),
			},
		},
	},
	{
		$group: {
			_id: {
				servico: '$atos.servico.designacao',
				tipo_mime: '$atos.anexos.tipo_mime',
			},
			n_anexos: { $sum: 1 },
			bytes: { $sum: '$atos.anexos.tamanho_bytes' },
		},
	},
	{
		$group: {
			_id: '$_id.servico',
			total_servico: { $sum: '$n_anexos' },
			tipos: {
				$push: {
					tipo_mime: '$_id.tipo_mime',
					n_anexos: '$n_anexos',
					bytes: '$bytes',
				},
			},
		},
	},
	{ $unwind: '$tipos' },
	{
		$project: {
			_id: 0,
			servico: '$_id',
			tipo_mime: '$tipos.tipo_mime',
			n_anexos: '$tipos.n_anexos',
			espaco_mb: { $round: [{ $divide: ['$tipos.bytes', 1048576] }, 2] },
			total_servico: '$total_servico',
		},
	},
	{ $sort: { total_servico: -1, servico: 1, n_anexos: -1 } },
]);

// Q07. Percentagem de resultados fora dos valores de referência, por análise,
// nos últimos seis meses.
db.episodios.aggregate([
	{ $unwind: '$pedidos' },
	{ $unwind: '$pedidos.analises' },
	{
		$match: {
			'pedidos.analises.resultado.data_hora_registo': {
				$gte: new Date(new Date().setMonth(new Date().getMonth() - 6)),
			},
		},
	},
	{
		$group: {
			_id: {
				id_analise: '$pedidos.analises.id_analise',
				analise: '$pedidos.analises.nome',
				unidade_medida: '$pedidos.analises.unidade_medida',
			},
			n_resultados: { $sum: 1 },
			fora_referencia: {
				$sum: {
					$cond: [
						{
							$or: [
								{
									$lt: [
										'$pedidos.analises.resultado.valor_obtido',
										'$pedidos.analises.valor_ref_min',
									],
								},
								{
									$and: [
										{ $gt: ['$pedidos.analises.valor_ref_max', null] },
										{
											$gt: [
												'$pedidos.analises.resultado.valor_obtido',
												'$pedidos.analises.valor_ref_max',
											],
										},
									],
								},
							],
						},
						1,
						0,
					],
				},
			},
		},
	},
	{
		$project: {
			_id: 0,
			analise: '$_id.analise',
			unidade_medida: '$_id.unidade_medida',
			n_resultados: '$n_resultados',
			fora_referencia: '$fora_referencia',
			pct_fora: {
				$round: [
					{
						$multiply: [
							100,
							{ $divide: ['$fora_referencia', '$n_resultados'] },
						],
					},
					1,
				],
			},
		},
	},
	{ $sort: { pct_fora: -1, analise: 1 } },
]);

// Q08. Técnicos de laboratório com mais resultados registados nos últimos seis
// meses e tempo médio entre o pedido e o registo (em horas).
db.episodios.aggregate([
	{ $unwind: '$pedidos' },
	{ $unwind: '$pedidos.analises' },
	{
		$match: {
			'pedidos.analises.resultado.data_hora_registo': {
				$gte: new Date(new Date().setMonth(new Date().getMonth() - 6)),
			},
		},
	},
	{
		$group: {
			_id: {
				id_tecnico: '$pedidos.analises.resultado.tecnico.id_colaborador',
				tecnico: '$pedidos.analises.resultado.tecnico.nome',
			},
			n_resultados: { $sum: 1 },
			tempo_medio_ms: {
				$avg: {
					$subtract: [
						'$pedidos.analises.resultado.data_hora_registo',
						'$pedidos.data_hora_pedido',
					],
				},
			},
		},
	},
	{
		$project: {
			_id: 0,
			tecnico: '$_id.tecnico',
			n_resultados: '$n_resultados',
			tempo_medio_horas: {
				$round: [{ $divide: ['$tempo_medio_ms', 3600000] }, 2],
			},
		},
	},
	{ $sort: { n_resultados: -1, tecnico: 1 } },
]);

// Q09. Episódios abertos há mais de 24 horas, com o animal e a indicação de
// internamento ativo.
db.episodios.aggregate([
	{
		$match: {
			data_hora_fim: { $exists: false },
			data_hora_inicio: { $lt: new Date(Date.now() - 24 * 3600000) },
		},
	},
	{
		$project: {
			_id: 0,
			episodio: '$_id',
			inicio: '$data_hora_inicio',
			horas_aberto: {
				$round: [
					{ $divide: [{ $subtract: ['$$NOW', '$data_hora_inicio'] }, 3600000] },
					1,
				],
			},
			animal: '$animal.nome',
			especie: '$animal.especie',
			id_cliente: '$animal.id_cliente',
			internado: {
				$and: [
					{ $gt: ['$internamento', null] },
					{ $not: [{ $gt: ['$internamento.data_hora_fim', null] }] },
				],
			},
		},
	},
	{ $sort: { inicio: 1 } },
]);

// Q10. Duração média dos internamentos terminados nos últimos 12 meses, por
// espécie, e número médio de atos realizados durante cada internamento.
db.episodios.aggregate([
	{
		$match: {
			'internamento.data_hora_fim': {
				$gte: new Date(new Date().setMonth(new Date().getMonth() - 12)),
			},
		},
	},
	{
		$addFields: {
			duracao_horas: {
				$divide: [
					{
						$subtract: [
							'$internamento.data_hora_fim',
							'$internamento.data_hora_inicio',
						],
					},
					3600000,
				],
			},
		},
	},
	{ $unwind: { path: '$atos', preserveNullAndEmptyArrays: true } },
	{
		$addFields: {
			durante: {
				$cond: [
					{
						$and: [
							{ $gte: ['$atos.data_hora', '$internamento.data_hora_inicio'] },
							{ $lte: ['$atos.data_hora', '$internamento.data_hora_fim'] },
						],
					},
					1,
					0,
				],
			},
		},
	},
	{
		$group: {
			_id: {
				id_episodio: '$_id',
				especie: '$animal.especie',
				duracao_horas: '$duracao_horas',
			},
			n_atos: { $sum: '$durante' },
		},
	},
	{
		$group: {
			_id: '$_id.especie',
			n_internamentos: { $sum: 1 },
			duracao_media_horas: { $avg: '$_id.duracao_horas' },
			media_atos: { $avg: '$n_atos' },
		},
	},
	{
		$project: {
			_id: 0,
			especie: '$_id',
			n_internamentos: '$n_internamentos',
			duracao_media_horas: { $round: ['$duracao_media_horas', 1] },
			media_atos: { $round: ['$media_atos', 1] },
		},
	},
	{ $sort: { duracao_media_horas: -1 } },
]);

// Q11. Histórico clínico de um animal (id 1), por ordem cronológica:
// atos clínicos, observações e resultados laboratoriais de todos os episódios.
db.episodios.find({ 'animal.id_animal': 1 }).sort({ data_hora_inicio: 1 });

// Q13. Animais atualmente internados, com as horas de internamento.
db.episodios.aggregate([
	{
		$match: {
			data_hora_fim: { $exists: false },
			internamento: { $exists: true },
			'internamento.data_hora_fim': { $exists: false },
		},
	},
	{
		$project: {
			_id: 0,
			animal: '$animal.nome',
			especie: '$animal.especie',
			id_cliente: '$animal.id_cliente',
			inicio_internamento: '$internamento.data_hora_inicio',
			horas_internado: {
				$round: [
					{
						$divide: [
							{ $subtract: ['$$NOW', '$internamento.data_hora_inicio'] },
							3600000,
						],
					},
					1,
				],
			},
		},
	},
	{ $sort: { inicio_internamento: 1 } },
]);

// Q14. Pedidos laboratoriais com análises ainda sem resultado, do mais
// antigo para o mais recente.
db.episodios.aggregate([
	{ $unwind: '$pedidos' },
	{ $unwind: '$pedidos.analises' },
	{ $match: { 'pedidos.analises.resultado': { $exists: false } } },
	{
		$group: {
			_id: {
				id_pedido: '$pedidos.id_pedido',
				data_hora_pedido: '$pedidos.data_hora_pedido',
				animal: '$animal.nome',
				especie: '$animal.especie',
				veterinario: '$pedidos.veterinario.nome',
			},
			analises_pendentes: { $sum: 1 },
			analises: { $push: '$pedidos.analises.nome' },
		},
	},
	{
		$project: {
			_id: 0,
			id_pedido: '$_id.id_pedido',
			data_hora_pedido: '$_id.data_hora_pedido',
			animal: '$_id.animal',
			especie: '$_id.especie',
			veterinario: '$_id.veterinario',
			analises_pendentes: '$analises_pendentes',
			analises: '$analises',
			horas_espera: {
				$round: [
					{
						$divide: [
							{ $subtract: ['$$NOW', '$_id.data_hora_pedido'] },
							3600000,
						],
					},
					1,
				],
			},
		},
	},
	{ $sort: { data_hora_pedido: 1 } },
]);

// Q16. Atividade por espécie dos animais com episódios: animais e episódios.
db.episodios.aggregate([
	{
		$group: {
			_id: { especie: '$animal.especie', id_animal: '$animal.id_animal' },
			episodios: { $sum: 1 },
		},
	},
	{
		$group: {
			_id: '$_id.especie',
			animais: { $sum: 1 },
			episodios: { $sum: '$episodios' },
		},
	},
	{
		$project: {
			_id: 0,
			especie: '$_id',
			animais: '$animais',
			episodios: '$episodios',
		},
	},
	{ $sort: { episodios: -1, especie: 1 } },
]);
