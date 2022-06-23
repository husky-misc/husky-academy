# Husky Academy

Olá seja bem-vindo(a) ao nosso teste técnico.

## Escopo

O desafio consiste em fazer a implementação de um objeto capaz de representar uma chave PIX usando a [linguagem Ruby](https://www.ruby-lang.org/en/about/).

Para isso você precisará ler a especificação oficial sobre os diferentes tipos de chaves no [DICT API](https://www.bcb.gov.br/content/estabilidadefinanceira/pix/API-DICT.html#tag/Key) e usar esse conhecimento para fazer os testes do arquivo `pix_key/spec/pix_key_spec.rb` passarem.

### Critérios de avaliação

O teste foi pensando para avaliar os seguintes atributos: clareza, qualidade e eficiência do código. Por conta disso, tente entregar algo que atenda a esses critérios.

## Preparando ambiente de dev

1. Instale o [Ruby `3.1.2`](https://www.ruby-lang.org/en/documentation/installation/).
2. Faça um clone deste repositório: `git clone git@github.com:husky-misc/husky-academy.git`
3. Acesse a pasta `pix_key`.
4. Execute `bin/setup`.

## Executando os testes unitários

1. Acesse a pasta `pix_key`.
2. Execute `bin/rake`.

## Sobre a suite de testes

Os testes foram escritos usando `Rspec`. Caso não conheça a ferramenta, acesse a [documentação oficial](https://relishapp.com/rspec/) ou procure por outros tutorias.

**Observação:** O `Rspec` tem quatro módulos: `rspec-core`, `rspec-expectations`, `rspec-mocks` e `rspec-rails`. Apenas os dois primeiros são necessários para entender os testes.

## Submetendo o seu teste para avaliação

1. Preencha o `me.json` com os seus dados.
2. Garanta que a sua branch local `main` contenha seu último commit.
3. Execute o comando `ruby prepare_to_submit.rb`
4. Faça upload do arquivo com final `.bundle` nesse form: [https://forms.gle/2Bwqm9G3Mzv3nUaD7](https://forms.gle/2Bwqm9G3Mzv3nUaD7).
5. Boa sorte! o/

### Atenção:

1. Não faça fork, nem torne o seu repositório público.
   > O __*Husky Academy*__ tem como objetivo capacitar as pessoas durante o processo seletivo, então, por favor, **não compartilhe seu código**. Permita que cada participante viva sua própria experiência de crescimento e aprendizagem.
2. Tenha certeza que o código está executável (sem erros de sintaxe) e que todos os testes estão passando.
3. Altere apenas os arquivos `pix_key/lib/pix_key.rb` e o `me.json`.
4. **Apenas um upload será permitido**. Caso contrário, há o risco de avaliarmos a versão incorreta do seu código.
