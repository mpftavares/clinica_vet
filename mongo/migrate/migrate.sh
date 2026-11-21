#!/bin/sh
# =============================================================================
# IBD 2026/27 — Entrega 3 — Clínica Veterinária
# migrate.sh : migra o registo clínico do PostgreSQL para o MongoDB
#             (coleção "episodios").
#
# Este ficheiro foi integralmente gerado pelo assistente de inteligência
# artificial Claude, da Anthropic.
#
# Execução (macOS / Linux), a partir de qualquer pasta:
#     sh mongo/migrate/migrate.sh
#
# Requisitos: psql (PostgreSQL), mongosh e mongoimport (MongoDB Database
# Tools) no PATH; a base clinica_vet criada e populada (schema.sql, data.sql).
#
# Passos:
#   1. mongosh    corre mongo/model.js: apaga e recria a coleção episodios
#                 com o validador $jsonSchema (a migração pode repetir-se).
#   2. psql       corre data_export.sql e grava episodios.json, com um
#                 documento JSON por episódio e por linha.
#   3. mongoimport importa episodios.json para a coleção episodios.
#
# Ligações (alterar aqui se necessário):
#   PGDATABASE    base de dados PostgreSQL (o psql usa também PGHOST, PGPORT,
#                 PGUSER e PGPASSWORD, se estiverem definidas)
#   MONGO_URI     servidor MongoDB
# =============================================================================

PGDATABASE="${PGDATABASE:-clinica_vet}"
MONGO_URI="${MONGO_URI:-mongodb://localhost:27017}"

# Termina no primeiro comando que falhar.
set -e

# Pasta deste script (mongo/migrate/), para os caminhos não dependerem de onde é
# executado.
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "1/3 Criar a coleção episodios (mongo/model.js)"
mongosh "$MONGO_URI" --quiet --file "$DIR/../model.js"

echo "2/3 Exportar o PostgreSQL para episodios.json (data_export.sql)"
# ON_ERROR_STOP=1: o psql termina com erro se alguma instrução SQL falhar.
psql -q -At -v ON_ERROR_STOP=1 -d "$PGDATABASE" \
     -f "$DIR/data_export.sql" -o "$DIR/episodios.json"
echo "    $(wc -l < "$DIR/episodios.json" | tr -d ' ') documentos exportados"

echo "3/3 Importar episodios.json para o MongoDB (mongoimport)"
mongoimport --uri "$MONGO_URI/clinica_vet" --collection episodios \
            --file "$DIR/episodios.json"

echo "Migração concluída."