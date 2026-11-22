// =============================================================================
// IBD 2026/27 — Entrega 3 — Clínica Veterinária
// consistency.js : contagens de verificação da migração, do lado do MongoDB.
//                  São as mesmas contagens de consistency.sql (PostgreSQL);
//                  os dois resultados têm de ser iguais.
//
// Este ficheiro foi integralmente gerado pelo assistente de inteligência
// artificial Claude, da Anthropic.
//
// Execução (uma linha "teste|valor" por teste, pela mesma ordem do .sql):
//     mongosh --quiet --file consistency.js
// Corre no passo 4 de mongo/migrate/migrate.sh, que o compara com o
// resultado de consistency.sql: as linhas têm de ser iguais.
//
// Correspondência usada nas contagens:
//   tabela episodio            -> documentos da coleção episodios
//   tabela internamento        -> subdocumento internamento
//   tabelas observacao, ato_clinico, pedido_laboratorial
//                             -> arrays observacoes, atos, pedidos
//   tabela anexo               -> array atos.anexos
//   tabela linha_pedido        -> array pedidos.analises
//   tabela resultado           -> subdocumento pedidos.analises.resultado
//   valor NULL                 -> campo ausente ($exists: false)
// =============================================================================

db = db.getSiblingDB("clinica_vet");

// Escreve uma linha no formato "teste|valor".
function mostrar(teste, valor) {
  print(teste + "|" + valor);
}

// Devolve o valor do campo "total" do único documento produzido por uma
// pipeline que termina num $group, ou 0 se a pipeline não produzir documentos.
function total(pipeline) {
  const r = db.episodios.aggregate(pipeline).toArray();
  return r.length > 0 ? r[0].total : 0;
}

// Conta os elementos de um array em todos os documentos. $ifNull trata o
// array ausente (ex.: episódio sem pedidos) como vazio, porque $size falha
// num campo que não existe.
function contarElementos(array) {
  return total([
    { $group: { _id: null, total: { $sum: { $size: { $ifNull: ["$" + array, []] } } } } }
  ]);
}

// ---------------------------------------------------------------------------
// Contagens por entidade
// ---------------------------------------------------------------------------

// 1. Cada linha de episodio é um documento.
mostrar("episodios", db.episodios.countDocuments({}));

// 2. Internamento (1:1) é um subdocumento: conta-se onde existe.
mostrar("internamentos", db.episodios.countDocuments({ internamento: { $exists: true } }));

// 3, 4. Observações e atos são arrays do episódio.
mostrar("observacoes", contarElementos("observacoes"));
mostrar("atos", contarElementos("atos"));

// 5. Anexos estão dentro dos atos: $unwind abre os atos (um documento por
//    ato) e depois soma-se o tamanho do array anexos de cada ato.
mostrar("anexos", total([
  { $unwind: "$atos" },
  { $group: { _id: null, total: { $sum: { $size: { $ifNull: ["$atos.anexos", []] } } } } }
]));

// 6. Pedidos são um array do episódio.
mostrar("pedidos", contarElementos("pedidos"));

// 7. Cada linha de linha_pedido é um elemento de pedidos.analises.
mostrar("analises_pedidas", total([
  { $unwind: "$pedidos" },
  { $group: { _id: null, total: { $sum: { $size: { $ifNull: ["$pedidos.analises", []] } } } } }
]));

// 8. Cada resultado é um subdocumento de uma análise pedida.
mostrar("resultados", total([
  { $unwind: "$pedidos" },
  { $unwind: "$pedidos.analises" },
  { $match: { "pedidos.analises.resultado": { $exists: true } } },
  { $count: "total" }
]));

// 9. Animais distintos com pelo menos um episódio.
mostrar("animais_com_episodios", db.episodios.distinct("animal.id_animal").length);

// ---------------------------------------------------------------------------
// Casos-limite (NULL no PostgreSQL = campo ausente no MongoDB)
// ---------------------------------------------------------------------------

// 10. Episódio aberto: sem data_hora_fim.
mostrar("episodios_abertos", db.episodios.countDocuments({ data_hora_fim: { $exists: false } }));

// 11. Internamento sem alta: o subdocumento existe, mas sem data_hora_fim.
mostrar("internamentos_sem_alta", db.episodios.countDocuments({
  internamento: { $exists: true },
  "internamento.data_hora_fim": { $exists: false }
}));

// 12. Atos associados a uma marcação.
mostrar("atos_com_marcacao", total([
  { $unwind: "$atos" },
  { $match: { "atos.id_marcacao": { $exists: true } } },
  { $count: "total" }
]));

// 13. Análises pedidas ainda sem resultado (pendentes).
mostrar("analises_sem_resultado", total([
  { $unwind: "$pedidos" },
  { $unwind: "$pedidos.analises" },
  { $match: { "pedidos.analises.resultado": { $exists: false } } },
  { $count: "total" }
]));

// ---------------------------------------------------------------------------
// Valores
// ---------------------------------------------------------------------------

// 14. Soma dos tamanhos dos anexos (int).
mostrar("soma_tamanho_anexos", Number(total([
  { $unwind: "$atos" },
  { $unwind: "$atos.anexos" },
  { $group: { _id: null, total: { $sum: "$atos.anexos.tamanho_bytes" } } }
])));

// 15. Soma dos valores obtidos (double), com 3 casas decimais como o
//     NUMERIC(10,3) do PostgreSQL.
mostrar("soma_valor_obtido", total([
  { $unwind: "$pedidos" },
  { $unwind: "$pedidos.analises" },
  { $group: { _id: null, total: { $sum: "$pedidos.analises.resultado.valor_obtido" } } }
]).toFixed(3));

// 16. Resultados fora dos valores de referência copiados para a análise.
//     Um limite ausente (ex.: SDMA sem mínimo) não conta, como o NULL na
//     comparação em SQL: $ifNull devolve null para o campo ausente e o
//     limite só é comparado se não for null.
mostrar("resultados_fora_referencia", total([
  { $unwind: "$pedidos" },
  { $unwind: "$pedidos.analises" },
  { $match: { "pedidos.analises.resultado": { $exists: true } } },
  { $match: { $expr: { $or: [
      { $and: [
          { $ne: [{ $ifNull: ["$pedidos.analises.valor_ref_min", null] }, null] },
          { $lt: ["$pedidos.analises.resultado.valor_obtido", "$pedidos.analises.valor_ref_min"] }
      ] },
      { $and: [
          { $ne: [{ $ifNull: ["$pedidos.analises.valor_ref_max", null] }, null] },
          { $gt: ["$pedidos.analises.resultado.valor_obtido", "$pedidos.analises.valor_ref_max"] }
      ] }
  ] } } },
  { $count: "total" }
]));

// 17, 18. Episódios por ano de início: confirma que as datas foram migradas
//         como date e com o valor certo. Os intervalos estão em UTC, tal
//         como as datas escritas pelo export.
mostrar("episodios_2025", db.episodios.countDocuments({
  data_hora_inicio: { $gte: ISODate("2025-01-01T00:00:00Z"), $lt: ISODate("2026-01-01T00:00:00Z") }
}));
mostrar("episodios_2026", db.episodios.countDocuments({
  data_hora_inicio: { $gte: ISODate("2026-01-01T00:00:00Z"), $lt: ISODate("2027-01-01T00:00:00Z") }
}));