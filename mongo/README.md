### Correção à Entrega 2

Na Entrega 2, este README indicava que o procedimento `sp_dar_alta` era usado
na Q19. Isso não é verdade: a Q19 adia uma marcação e o procedimento não é
chamado em nenhuma query. O erro foi causado por alterações às
queries pela autora após este README ser gerado. O
procedimento continua definido em `procedures.sql`.

## Entrega 3 — MongoDB

### Ficheiros

| Ficheiro | Conteúdo |
|---|---|
| `mongo/model.js` | Criação da coleção `episodios` com o validador `$jsonSchema`. Os comentários contêm a análise e as justificações: que dados passam para MongoDB e porquê, correspondência com as tabelas do PostgreSQL (embedding vs referencing) e alternativas NoSQL. |
| `mongo/migrate/data_export.sql` | Exporta o registo clínico do PostgreSQL em JSON, um documento por episódio (`row_to_json`, `json_agg`). |
| `mongo/migrate/migrate.sh` | Migração completa em macOS/Linux (cria a coleção, exporta, importa e corre os testes de consistência). |
| `mongo/migrate/migrate.bat` | O mesmo para Windows. |
| `mongo/migrate/episodios.json` | Ficheiro gerado pela migração (um documento JSON por linha). |
| `mongo/tests/consistency.sql` | Testes de consistência do lado do PostgreSQL (18 contagens). |
| `mongo/tests/consistency.js` | As mesmas 18 contagens do lado do MongoDB. |
| `mongo/crud.js` | Criar, consultar, alterar e eliminar um episódio. |
| `mongo/queries.js` | 12 queries (11 aggregation pipelines e 1 `find`), equivalentes às queries SQL da Entrega 2. |

### Modelo

Uma coleção, `episodios`, com um documento por episódio clínico. Ficam
embedded o internamento, as observações, os atos clínicos (com os anexos) e
os pedidos laboratoriais (com as análises pedidas e os resultados): as 8
tabelas do registo clínico passam a uma única coleção. Animal, colaborador,
serviço, análise e marcação ficam no PostgreSQL e são referenciados pelo id,
com uma cópia dos atributos que não mudam (ex.: nome do animal). O `_id` de
cada documento é o `id_episodio` do PostgreSQL.

As justificações estão nos comentários de `mongo/model.js`.

### Requisitos

- A base de dados `clinica_vet` da Entrega 2, criada e povoada.
- MongoDB 7 ou superior (testado em MongoDB 8.0), a correr em
  `localhost:27017`.
- `mongosh` e MongoDB Database Tools (`mongoimport`). No macOS:
  `brew install mongosh mongodb-database-tools`.
- `psql` (cliente de linha de comandos do PostgreSQL).
- (Opcional) MongoDB Compass, para consultar os documentos.

### Migração

Na pasta do repositório:

```bash
sh mongo/migrate/migrate.sh        # macOS / Linux
mongo\migrate\migrate.bat          # Windows
```

O script executa 4 passos:

1. `mongosh` corre `mongo/model.js`: apaga e recria a coleção `episodios`
   com o validador (a migração pode repetir-se).
2. `psql` corre `data_export.sql` e grava `episodios.json`.
3. `mongoimport` importa `episodios.json` para a coleção.
4. Corre `consistency.sql` e `consistency.js` e compara os resultados; o
   script termina com erro se algum teste for diferente.

Se o PostgreSQL usar outro utilizador ou outra base de dados, indicá-los
antes do comando (o `psql` pede a password, se for necessária):

```bash
PGUSER=postgres sh mongo/migrate/migrate.sh
PGDATABASE=outra_base MONGO_URI=mongodb://outro_servidor:27017 sh mongo/migrate/migrate.sh
```

Resultado esperado: `144 document(s) imported successfully. 0 document(s)
failed to import.` e, no fim, `Todos os testes iguais (18).`

A importação é feita com o `mongoimport` e não com o Compass: os valores
`NUMERIC` redondos (ex.: 40.0) seriam gravados pelo Compass como `int`, e o
validador exige `double`.

### Testes de consistência

Os dois ficheiros fazem as mesmas 18 contagens, que têm de dar o mesmo valor
nas duas bases de dados:

| Grupo | Testes |
|---|---|
| Entidades (cada tabela → documento, subdocumento ou array) | episódios (144), internamentos (26), observações (297), atos (325), anexos (98), pedidos (50), análises pedidas (146), resultados (126), animais com episódios (72) |
| Casos-limite (NULL no PostgreSQL → campo ausente no MongoDB) | episódios abertos (8), internamentos sem alta (3), atos com marcação (114), análises sem resultado (20) |
| Valores | soma dos tamanhos dos anexos, soma dos valores obtidos, resultados fora dos valores de referência (40), episódios de 2025 (71) e de 2026 (73) |

Correm no passo 4 da migração ou isoladamente:

```bash
psql -q -At -d clinica_vet -f mongo/tests/consistency.sql
mongosh --quiet --file mongo/tests/consistency.js
```

### Dados

Os dados do MongoDB são os da Entrega 2, migrados: não há dados criados
apenas no MongoDB. A migração cobre os casos que as queries usam e os
casos-limite do modelo:

| Caso | Quantidade | Usado em |
|---|---|---|
| Episódios (jan. 2025 a nov. 2026), 72 animais de 8 espécies | 144 | Q01, Q16 |
| Episódios abertos (sem `data_hora_fim`) | 8 | Q09 |
| Internamentos, dos quais sem alta | 26 (3) | Q05, Q10, Q13 |
| Observações sem peso (só os sinais medidos são guardados) | 108 de 297 | Q11 |
| Atos com marcação / sem marcação (urgências) | 114 / 211 | Q02 |
| Atos com anexos | 76 | Q06 |
| Episódios sem pedidos laboratoriais | 94 | Q05 (LEFT JOIN) |
| Análises pedidas sem resultado (pendentes) | 20 | Q14 |
| Análises sem valor de referência mínimo (SDMA) | 7 | Q07 |
| Resultados fora dos valores de referência | 40 | Q07 |

### CRUD

`mongo/crud.js` cria um episódio de teste (`_id` 1000), consulta-o, acrescenta
uma observação e encerra-o, e por fim elimina-o, deixando a coleção como
estava. Para executar, no `mongosh` (Terminal ou barra *_MONGOSH* do Compass):

```javascript
use clinica_vet
```

e copiar e colar cada comando, pela ordem.

| Operação | Comando | No PostgreSQL |
|---|---|---|
| Create | `insertOne`: episódio com a consulta e a primeira observação embedded | 3 INSERT (episodio, ato_clinico, observacao) |
| Read | `find` | SELECT com JOINs |
| Update | `updateOne` com `$push` (nova observação) e `$set` (data de fim), numa só operação | INSERT em observacao e UPDATE de episodio |
| Delete | `deleteOne`: o ato e as observações são eliminados com o documento | DELETE nas tabelas filhas e depois em episodio |

Tipos: o `mongosh` guarda um número sem casas decimais como `int` e um número
com casas decimais como `double`, que são os tipos que o validador espera. Um
valor redondo num campo `double` (peso, temperatura, valores das análises)
tem de ser escrito com `Double(39)`; `39` seria guardado como `int` e a
escrita rejeitada.

### Queries

`mongo/queries.js` tem as queries da Entrega 2 que usam o registo clínico,
com o mesmo número. Executam-se como o CRUD: `use clinica_vet` e copiar e
colar cada query (o `mongosh` mostra 20 documentos de cada vez; `it` mostra
os seguintes).

| Query | Pergunta | Resultados |
|---|---|---|
| Q01 | Animais com mais de três episódios nos últimos 12 meses | 6 |
| Q02 | Veterinários com mais consultas em cada mês (12 meses), com e sem marcação | 27 |
| Q05 | Internamentos com temperatura acima de 40 ºC e análises pedidas | 22 |
| Q06 | Serviços com mais anexos nos últimos seis meses, por tipo | 11 |
| Q07 | Percentagem de resultados fora dos valores de referência (6 meses) | 12 |
| Q08 | Técnicos com mais resultados e tempo médio de resposta (6 meses) | 3 |
| Q09 | Episódios abertos há mais de 24 horas | 8 |
| Q10 | Duração média dos internamentos e atos por internamento, por espécie | 5 |
| Q11 | Histórico clínico de um animal (`find` dos seus episódios) | 6 episódios |
| Q13 | Animais atualmente internados | 3 |
| Q14 | Pedidos com análises sem resultado | 12 |
| Q16 | Animais e episódios por espécie | 8 |

Os resultados foram comparados com os das queries SQL equivalentes: o mesmo
número de linhas e os mesmos valores. Os valores da tabela correspondem à
data de entrega; as queries usam períodos relativos à data atual ("últimos 12
meses", episódios abertos há mais de 24 horas), por isso os resultados mudam
com o tempo, como no SQL.

**Diferenças em relação ao SQL**

- O nome e o telefone do cliente não estão no MongoDB: a Q01, a Q09 e a Q13
  devolvem o `id_cliente`. Obtê-los seria uma junção feita pela aplicação
  com o PostgreSQL.
- Os intervalos de tempo (INTERVAL) são devolvidos em horas.
- Q11: o SQL devolve uma lista de eventos de todos os tipos, ordenada por
  data; no MongoDB, cada episódio do animal é um documento com tudo o que
  aconteceu nele, por isso basta procurar os episódios, sem junções. Os
  episódios saem por ordem cronológica e, dentro de cada um, os eventos estão
  agrupados por tipo.

**Queries da Entrega 2 que não têm equivalente em MongoDB**

- Q03, Q12, Q15 e Q17: usam marcações e dados dos clientes, que ficaram no
  PostgreSQL.
- Q18 a Q20: criam, alteram e eliminam marcações.
- Q04: precisa da função do colaborador (enfermeiro), que não é copiada para
  o MongoDB.

**Operadores**

Das aulas: `$match`, `$group` (com `$sum`, `$avg`, `$max` e `$push`),
`$unwind`, `$project`, `$addFields`, `$sort`, `$gt`, `$gte`, `$lt`, `$lte` e
`$or`; os atributos a mostrar depois de um `$group` fazem parte do `_id` do
grupo, como as colunas do GROUP BY.

Da documentação do MongoDB, para cálculos que o SQL faz no SELECT:

| Operador | Equivalente em SQL | Queries |
|---|---|---|
| `$expr` (só mencionado nas aulas) | comparar duas colunas no WHERE | Q02, Q05 |
| `$exists` | IS NULL / IS NOT NULL (NULL no PostgreSQL = campo ausente) | Q05, Q09, Q13, Q14 |
| `$year`, `$month` | EXTRACT | Q02 |
| `$subtract`, `$divide`, `$multiply`, `$round` | aritmética e ROUND | Q02, Q06–Q10, Q13, Q14 |
| `'$$NOW'` | CURRENT_TIMESTAMP | Q09, Q13, Q14 |
| `$cond` | CASE WHEN | Q02, Q07, Q10 |
| `$and`, `$not`, `$eq` | AND, NOT, = dentro de expressões | Q02, Q07, Q09, Q10 |
| `preserveNullAndEmptyArrays` | LEFT JOIN | Q05, Q10 |

## Uso de inteligência artificial

Este README, o ficheiro de testes de integridade (`testes_integridade.sql`) e
os dados de teste (`data.sql`) foram integralmente gerados pelo assistente de
inteligência artificial Claude, da Anthropic.

Na Entrega 3, foram também integralmente gerados pelo Claude o script de
exportação (`mongo/migrate/data_export.sql`), os scripts de migração
(`mongo/migrate/migrate.sh` e `migrate.bat`) e os testes de consistência
(`mongo/tests/consistency.sql` e `consistency.js`).