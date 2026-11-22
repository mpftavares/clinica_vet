# IBD 2026/27 — Clínica Veterinária

Base de dados para a gestão clínica de uma clínica veterinária: clientes,
animais, colaboradores, marcações, episódios clínicos, atos clínicos, anexos,
observações, internamentos, pedidos laboratoriais e resultados.

- **Entrega 2:** implementação relacional em PostgreSQL.
- **Entrega 3:** persistência poliglota — o registo clínico (episódios) passa
  para MongoDB; os dados mestre ficam no PostgreSQL.

Autora: Mariana Tavares — Faculdade de Ciências da Universidade de Lisboa

## Entrega 2 — PostgreSQL

### Ficheiros

| Ficheiro | Conteúdo |
|---|---|
| `schema.sql` | Tabelas, restrições de integridade, funções auxiliares e triggers. Inclui as alterações ao modelo ER face à Entrega 1. |
| `data.sql` | Script de inserção automática dos dados de teste (INSERTs estáticos, cerca de 1650 registos). |
| `procedures.sql` | 1 função (`fn_episodios_abertos`, usada na Q09) e 1 procedimento (`sp_dar_alta`, que não é usado nas queries — ver [Correção](#correção-à-entrega-2)). |
| `views.sql` | 5 views. |
| `queries.sql` | 20 queries (17 leituras, incluindo as 10 questões da Entrega 1; criação, alteração e eliminação). |
| `testes_integridade.sql` | 21 operações inválidas que demonstram as restrições e os triggers. |
| `vet_clinic.drawio` | Diagrama ER (versão editável atualizada). |

### Requisitos

- PostgreSQL 14 ou superior (testado em PostgreSQL 16).
- DBeaver (ou outro cliente SQL, como pgAdmin ou `psql`).

### Criação e povoamento da base de dados (DBeaver)

1. **Criar a base de dados** (apenas da primeira vez): na ligação ao
   PostgreSQL, botão direito em *Bases de dados* → *Criar nova base de dados*,
   com o nome `clinica_vet`.
2. **Abrir um editor SQL sobre a base de dados:** expandir `clinica_vet` →
   *Esquemas*, botão direito em `public` → *Editor SQL* → *Abrir script SQL*
   (F3) e escolher o ficheiro.
3. **Executar cada ficheiro como script** (*Executar script SQL*, Alt+X — e não
   Ctrl+Enter, que executa apenas a instrução onde está o cursor), por esta
   ordem:

   | Passo | Ficheiro | Resultado |
   |---|---|---|
   | 1 | `schema.sql` | Tabelas, restrições, funções auxiliares e triggers |
   | 2 | `data.sql` | Dados de teste (cerca de 1650 registos) |
   | 3 | `procedures.sql` | Função e procedimento usados nas queries |
   | 4 | `views.sql` | As 5 views |
   | 5 | `queries.sql` | As 20 queries |
   | 6 | `testes_integridade.sql` | (Opcional) operações inválidas que devem dar erro |

4. **Confirmar:** `SELECT COUNT(*) FROM ato_clinico;` deve devolver 325.

Em alternativa, na linha de comandos, na pasta dos ficheiros:

```bash
createdb -U <utilizador> clinica_vet
psql -U <utilizador> -d clinica_vet -f schema.sql
psql -U <utilizador> -d clinica_vet -f data.sql
psql -U <utilizador> -d clinica_vet -f procedures.sql
psql -U <utilizador> -d clinica_vet -f views.sql
psql -U <utilizador> -d clinica_vet -f queries.sql
```

`<utilizador>` é o utilizador administrador do PostgreSQL: `postgres` no Windows
e no Linux; no macOS com Homebrew, é o utilizador do sistema e a opção
`-U <utilizador>` pode ser omitida.