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
rem   4. testes      corre mongo\tests\consistency.sql (PostgreSQL) e
rem                  mongo\tests\consistency.js (MongoDB), que fazem as mesmas
rem                  contagens, e compara os dois resultados (fc); termina com
rem                  erro se forem diferentes.
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

echo 1/4 Criar a colecao episodios (mongo\model.js)
mongosh "%MONGO_URI%" --quiet --file "%DIR%..\model.js" || goto :erro

echo 2/4 Exportar o PostgreSQL para episodios.json (data_export.sql)
rem ON_ERROR_STOP=1: o psql termina com erro se alguma instrucao SQL falhar.
psql -q -At -v ON_ERROR_STOP=1 -d "%PGDATABASE%" -f "%DIR%data_export.sql" -o "%DIR%episodios.json" || goto :erro

echo 3/4 Importar episodios.json para o MongoDB (mongoimport)
mongoimport --uri "%MONGO_URI%/clinica_vet" --collection episodios --file "%DIR%episodios.json" || goto :erro

echo 4/4 Testes de consistencia (mongo\tests\consistency.sql e .js)
rem Os resultados vao para ficheiros temporarios (%TEMP%), apagados no fim.
set "PG_TXT=%TEMP%\consistency_pg.txt"
set "MONGO_TXT=%TEMP%\consistency_mongo.txt"
psql -q -At -v ON_ERROR_STOP=1 -d "%PGDATABASE%" -f "%DIR%..\tests\consistency.sql" -o "%PG_TXT%" || goto :erro
mongosh "%MONGO_URI%" --quiet --file "%DIR%..\tests\consistency.js" > "%MONGO_TXT%" || goto :erro
echo     PostgreSQL:
type "%PG_TXT%"
rem fc /w compara os dois ficheiros ignorando diferencas de espacos e de fim
rem de linha; devolve erro se houver alguma linha diferente.
fc /w "%PG_TXT%" "%MONGO_TXT%" > nul
if errorlevel 1 (
    echo     MongoDB:
    type "%MONGO_TXT%"
    echo     Ha testes com valores diferentes.
    del "%PG_TXT%" "%MONGO_TXT%"
    goto :erro
)
del "%PG_TXT%" "%MONGO_TXT%"
echo     Todos os testes iguais no MongoDB.

echo Migracao concluida.
exit /b 0

:erro
echo Erro: a migracao parou no passo acima.
exit /b 1