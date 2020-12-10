# Users API

## Introdução

`Users API` é uma RESTful JSON API em Ruby on Rails contendo um CRUD de usuários, com autenticação, autorização e testes automatizados.

A documentação da API se encontra no `Postman`, acessível pela seguinte URL: <https://documenter.getpostman.com/view/6576121/TVmTcEpb>

## Ferramentas

As *gems* utilizadas foram:

- [rails](https://github.com/rails/rails)
- [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth)
- [pundit](https://github.com/varvet/pundit)
- [rspec](https://github.com/rspec/rspec-rails)
- [dotenv-rails](https://github.com/bkeepers/dotenv) - usado para carregar as variáveis de ambiente
- [factory_bot](https://github.com/thoughtbot/factory_bot_rails) - responsável por fabricar os objetos em tempo de execução nos testes
- [faker](https://github.com/faker-ruby/faker) - utilizado para criação de dados fictícios em tempo de execução nos testes
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) - contém diversos utilitários para testes *one-liner*, permitindo a escrita de menos código nos testes
- [simplecov](https://github.com/simplecov-ruby/simplecov) - usado para coletar e gerar um relatório da cobertura dos testes

## Instruções

Os pré-requisitos para rodar o projeto são:
- `ruby` versão 2.7.1
- `rails` versão 6.0.3.4
- `bundler`

### Instalando as dependências

Rode o comando abaixo para instalar as dependências:

```
bundle install
```

### Banco de dados

O banco de dados utilizado é o `PostgreSQL`.

Se estiver executando o projeto pela primeira vez, execute os seguintes comandos para fazer o setup do banco de dados:

- Crie o banco
    
    ```
    bin/rake db:create
    ```

- Rode as *migrations*:

    ```
    bin/rake db:migrate
    ```

- Popule o banco com os *seeds*:

    ```
    bin/rake db:seed
    ```

### Rodando o projeto

Para rodar a aplicação execute o seguinte comando:

```
bin/rails server
```

### Testes
Os testes são realizados com o auxílio das *gems* `rspec`, `factory_bot`, `faker` e `shoulda-matchers`.

Para executar os testes, rode o comando abaixo:
```
bundle exec rspec
```
