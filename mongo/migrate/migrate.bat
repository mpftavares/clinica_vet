@echo off
rem ============================================================================
rem IBD 2026/27 - Entrega 3 - Clinica Veterinaria
rem migrate.bat : migra o registo clinico do PostgreSQL para o MongoDB
rem              (colecao "episodios"). Versao Windows de migrate.sh.
rem
rem Este ficheiro foi integralmente gerado pelo assistente de inteligencia
rem artificial Claude, da Anthropic.
rem
rem Execucao (Windows), a partir de qualquer pasta:
rem     mongo\migrate\migrate.bat
rem
rem Requisitos: psql (PostgreSQL), mongosh e mongoimport (MongoDB Database
rem Tools) no PATH; a base clinica_vet criada e populada (schema.sql, data.sql).
rem
rem Passos:
rem   1. mongosh     corre mongo\model.js: apaga e recria a colecao episodios
rem                  com o validador $jsonSchema (a migracao pode repetir-se).
rem   2. psql        corre data_export.sql e grava episodios.json, com um
rem                  documento JSON por episodio e por linha.
rem   3. mongoimport importa episodios.json para a colecao episodios.
rem
rem Ligacoes (alterar aqui se necessario):
rem   PGDATABASE     base de dados PostgreSQL (o psql usa tambem PGHOST,
rem                  PGPORT, PGUSER e PGPASSWORD, se estiverem definidas)
rem   MONGO_URI      servidor MongoDB
rem ============================================================================

setlocal
if "%PGDATABASE%"=="" set "PGDATABASE=clinica_vet"
if "%MONGO_URI%"=="" set "MONGO_URI=mongodb://localhost:27017"

rem Pasta deste script (mongo\migrate\), para os caminhos nao dependerem de onde
rem e executado.
set "DIR=%~dp0"

rem O psql escreve o ficheiro em UTF-8 (nomes com acentos).
set "PGCLIENTENCODING=UTF8"

echo 1/3 Criar a colecao episodios (mongo\model.js)
mongosh "%MONGO_URI%" --quiet --file "%DIR%..\model.js" || goto :erro

echo 2/3 Exportar o PostgreSQL para episodios.json (data_export.sql)
rem ON_ERROR_STOP=1: o psql termina com erro se alguma instrucao SQL falhar.
psql -q -At -v ON_ERROR_STOP=1 -d "%PGDATABASE%" -f "%DIR%data_export.sql" -o "%DIR%episodios.json" || goto :erro

echo 3/3 Importar episodios.json para o MongoDB (mongoimport)
mongoimport --uri "%MONGO_URI%/clinica_vet" --collection episodios --file "%DIR%episodios.json" || goto :erro

echo Migracao concluida.
exit /b 0

:erro
echo Erro: a migracao parou no passo acima.
exit /b 1