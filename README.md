# Projeto Logico de Banco de Dados - E-commerce

## Descricao

Este projeto implementa o esquema logico de banco de dados para um cenario de **e-commerce**, desenvolvido como parte da Formacao SQL DB Specialist da [DIO](https://www.dio.me/).

O projeto abrange desde a criacao do esquema relacional (DDL) ate a persistencia de dados (DML) e consultas SQL complexas, aplicando conceitos de mapeamento do modelo EER para o modelo relacional.

## Esquema Logico

O banco de dados contempla as seguintes entidades e relacionamentos:

- **Cliente**: Com especializacao em Pessoa Fisica (PF) e Pessoa Juridica (PJ) - mutuamente exclusivos
- **Produto**: Catalogo de produtos com categorias
- **Pedido**: Pedidos realizados pelos clientes com status de acompanhamento
- **Pagamento**: Suporte a multiplas formas de pagamento por cliente (cartao, boleto, PIX, etc.)
- **Entrega**: Controle de entregas com status e codigo de rastreio
- **Fornecedor**: Fornecedores dos produtos
- **Estoque**: Locais de armazenamento com controle de quantidade
- **Vendedor Terceiro**: Vendedores terceirizados que comercializam produtos na plataforma

### Refinamentos Implementados

1. **Cliente PJ e PF**: Uma conta pode ser PJ ou PF, mas nao ambas simultaneamente (especializacao exclusiva)
2. **Pagamento**: Um cliente pode cadastrar mais de uma forma de pagamento
3. **Entrega**: Possui status (Enviado, Em transito, Entregue, Cancelado) e codigo de rastreio

## Estrutura do Projeto

```
ecommerce-logico-db/
|-- README.md
|-- schema.sql          # Script DDL - Criacao do esquema do banco
|-- data.sql            # Script DML - Persistencia de dados de teste
|-- queries.sql         # Consultas SQL complexas
```

## Consultas Implementadas

As queries SQL abordam os seguintes topicos:

- **SELECT**: Recuperacoes simples de dados
- **WHERE**: Filtros condicionais
- **Expressoes**: Atributos derivados calculados
- **ORDER BY**: Ordenacao de resultados
- **HAVING**: Filtros sobre grupos agregados
- **JOIN**: Juncoes entre tabelas para analises complexas

### Perguntas Respondidas pelas Queries

1. Quantos pedidos foram feitos por cada cliente?
2. Algum vendedor tambem e fornecedor?
3. Relacao de produtos, fornecedores e estoques
4. Relacao de nomes dos fornecedores e nomes dos produtos
5. Qual o valor total gasto por cada cliente?
6. Quais produtos tem estoque abaixo do minimo?
7. Qual a media de valor dos pedidos por status?
8. Quais clientes PJ fizeram mais de 2 pedidos?

## Tecnologias

- MySQL 8.0+
- SQL (DDL, DML, DQL)

## Como Executar

1. Crie o banco de dados executando o script `schema.sql`
2. Popule o banco com dados de teste executando `data.sql`
3. Execute as consultas em `queries.sql` para analise dos dados

## Autor

**Gabriel Demetrios Lafis** - [GitHub](https://github.com/galafis)

---

Desenvolvido como parte da **Formacao SQL DB Specialist** - [DIO](https://www.dio.me/)
