# Parking Control API

[![build status](https://github.com/rmoura/parking-control/workflows/Ruby/badge.svg)](https://github.com/rmoura/parking-control/actions?workflow=Ruby)

API para controle de estacionamento, onde deve ser possível:
* Registrar entrada, saída e pagamento;
* Liberar saída sem pagamento;
* Fornecer um histórico por placa.

## Sobre a aplicação

API está disponível no seguinte endereço: [https://rmoura-parking-control.herokuapp.com](https://rmoura-parking-control.herokuapp.com)

[![](storage/swagger.png) - Documentação API](https://rmoura-parking-control.herokuapp.com/api-docs)

Assim que novos testes forem desenvolvidos ou atualizados no path `spec/integration`, a documentação deve ser atualizada utilizando o comando:

```
$ bundle exec rake rswag:specs:swaggerize
```

Para melhores práticas e qualidade no desenvolvimento de código foi utilizado a `gem rubocop`, forçamdo a aplicação de melhores práticas e convenções de codificação. Para análise:

```
$ rubocop --require rubocop-rails
```

Para análise de vulnerabilidades foi utilizado a `gem brakeman`. O último relatório gerado está disponível no path `storage/brakeman.html`. Para gerar um novo:

```
$ brakeman -o storage/brakeman.html
```

A análise de cobertura de testes é atualizado assim que os testes são executados, o resultado da análise fica em `coverage/index.html`, podendo ser visualizado em um navegador, como o Google Chrome. Até o momento a cobertura dos testes é de 98.3%.

É possível subir esta aplicação em ambiente de testes/desenvolvimento utilizando o Docker. A utilização do Docker é opcional para desenvolvimento.

O deploy está sobre o serviço do Heroku com Docker.
Cada push ao Github é acionado o Github Actions. O workflow desenhado é, executar os testes automatizados desenvolvidos, validar o build e aí então realizar o deploy automaticamente no Heroku.

Esta API foi desenvolvida utilizando Ruby 2.7, Rails 6.0.2.2 e PostgreSQL 11.

Para os testes unitários o RSpec.

Foi implementado também um health check da aplicação.

## Dependências

Para a opção de não utilizar Docker, instalar:
* Ruby 2.7
* Postgres

Para a opção com Docker, instalar:
* Docker
* docker-compose

## Configuração com Docker

Iniciar processo de build e start dos containers para subir os serviços:

```
$ docker-compose up -d
```

Geração de tabelas e banco de dados:

```
$ docker-compose run app rake db:create
$ docker-compose run app rake db:migrate
```

Execução dos testes automatizados:

```
$ docker-compose run specs
```

Checar se aplicação subiu corretamente:

```
$ curl localhost:3000
```

O resultado deve ser:

```
{"healthy":true,"message":"OK"}
```

### Para execução dos testes com Rspec

```
$ docker-compose run spec
```
