# Painel Fiscal RO

CRUD em Ruby on Rails para acompanhamento de processos fiscais em uma triagem inspirada na rotina da SEFIN-RO.

## Funcionalidades

- Cadastro, edição, listagem, detalhe e exclusão de processos.
- Filtros por número, contribuinte, CPF/CNPJ e status.
- Indicadores de total, processos em análise, vencidos e valor estimado.
- Validações de campos obrigatórios, listas de domínio e prazo.
- Dados iniciais para demonstração em `db/seeds.rb`.

## Rodando o projeto

Com o terminal dentro da pasta `painel_fiscal_ro`:

```bash
bundle install
bin/rails db:migrate
bin/rails db:seed
bin/rails server
```

Se o Windows falhar por causa de acento no caminho da pasta, use os comandos abaixo:

```bash
ruby -e "require_relative 'config/environment'; ActiveRecord::Base.connection_pool.migration_context.migrate"
ruby -e "require_relative 'config/environment'; load 'db/seeds.rb'"
ruby script/server_local.rb
```

Depois acesse `http://127.0.0.1:3000`.

## Testes

```bash
bin/rails test
```

No mesmo caso de caminho com acento no Windows:

```bash
ruby -e "require_relative 'test/test_helper'; load 'test/models/processo_test.rb'; load 'test/controllers/processos_controller_test.rb'"
```
