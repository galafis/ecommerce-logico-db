-- =============================================
-- Projeto Logico de Banco de Dados - E-commerce
-- Formacao SQL DB Specialist - DIO
-- Autor: Gabriel Demetrios Lafis
-- =============================================

-- Criacao do banco de dados
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- =============================================
-- Tabela: Cliente
-- =============================================
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    TipoCliente ENUM('PF', 'PJ') NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Telefone VARCHAR(20),
    Endereco VARCHAR(255),
    Cidade VARCHAR(100),
    Estado CHAR(2),
    CEP VARCHAR(10),
    DataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Tabela: ClientePF (Pessoa Fisica)
-- =============================================
CREATE TABLE ClientePF (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    DataNascimento DATE,
    CONSTRAINT fk_clientepf_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =============================================
-- Tabela: ClientePJ (Pessoa Juridica)
-- =============================================
CREATE TABLE ClientePJ (
    idCliente INT PRIMARY KEY,
    RazaoSocial VARCHAR(200) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    NomeFantasia VARCHAR(200),
    CONSTRAINT fk_clientepj_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =============================================
-- Tabela: Produto
-- =============================================
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(200) NOT NULL,
    Categoria ENUM('Eletronico', 'Vestuario', 'Alimentos', 'Moveis', 'Brinquedos', 'Livros') NOT NULL,
    Descricao TEXT,
    Valor DECIMAL(10,2) NOT NULL,
    Avaliacao DECIMAL(2,1) DEFAULT 0,
    CONSTRAINT chk_valor CHECK (Valor >= 0)
);

-- =============================================
-- Tabela: Fornecedor
-- =============================================
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(200) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Telefone VARCHAR(20),
    Email VARCHAR(100)
);

-- =============================================
-- Tabela: Produto_Fornecedor (Relacao N:M)
-- =============================================
CREATE TABLE Produto_Fornecedor (
    idProduto INT,
    idFornecedor INT,
    Quantidade INT NOT NULL DEFAULT 0,
    PRIMARY KEY (idProduto, idFornecedor),
    CONSTRAINT fk_pf_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_pf_fornecedor FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

-- =============================================
-- Tabela: Estoque
-- =============================================
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Local VARCHAR(200) NOT NULL,
    Cidade VARCHAR(100),
    Estado CHAR(2)
);

-- =============================================
-- Tabela: Produto_Estoque (Relacao N:M)
-- =============================================
CREATE TABLE Produto_Estoque (
    idProduto INT,
    idEstoque INT,
    Quantidade INT NOT NULL DEFAULT 0,
    QuantidadeMinima INT DEFAULT 10,
    PRIMARY KEY (idProduto, idEstoque),
    CONSTRAINT fk_pe_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_pe_estoque FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque)
);

-- =============================================
-- Tabela: VendedorTerceiro
-- =============================================
CREATE TABLE VendedorTerceiro (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(200) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Local VARCHAR(200),
    NomeFantasia VARCHAR(200)
);

-- =============================================
-- Tabela: Produto_Vendedor (Relacao N:M)
-- =============================================
CREATE TABLE Produto_Vendedor (
    idProduto INT,
    idVendedor INT,
    Quantidade INT NOT NULL DEFAULT 0,
    PRIMARY KEY (idProduto, idVendedor),
    CONSTRAINT fk_pv_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_pv_vendedor FOREIGN KEY (idVendedor) REFERENCES VendedorTerceiro(idVendedor)
);

-- =============================================
-- Tabela: Pedido
-- =============================================
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    StatusPedido ENUM('Em processamento', 'Confirmado', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Em processamento',
    Descricao VARCHAR(255),
    Frete DECIMAL(10,2) DEFAULT 0,
    DataPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =============================================
-- Tabela: Pedido_Produto (Relacao N:M)
-- =============================================
CREATE TABLE Pedido_Produto (
    idPedido INT,
    idProduto INT,
    Quantidade INT NOT NULL DEFAULT 1,
    ValorUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idPedido, idProduto),
    CONSTRAINT fk_pp_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    CONSTRAINT fk_pp_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- =============================================
-- Tabela: Pagamento
-- =============================================
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    TipoPagamento ENUM('Cartao de Credito', 'Cartao de Debito', 'Boleto', 'PIX', 'Transferencia') NOT NULL,
    NumeroCartao VARCHAR(20),
    Bandeira VARCHAR(50),
    Validade DATE,
    CONSTRAINT fk_pagamento_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =============================================
-- Tabela: Pedido_Pagamento
-- =============================================
CREATE TABLE Pedido_Pagamento (
    idPedido INT,
    idPagamento INT,
    ValorPago DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idPedido, idPagamento),
    CONSTRAINT fk_ppag_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    CONSTRAINT fk_ppag_pagamento FOREIGN KEY (idPagamento) REFERENCES Pagamento(idPagamento)
);

-- =============================================
-- Tabela: Entrega
-- =============================================
CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    StatusEntrega ENUM('Enviado', 'Em transito', 'Entregue', 'Cancelado') DEFAULT 'Enviado',
    CodigoRastreio VARCHAR(50) NOT NULL,
    DataEnvio DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataEntrega DATETIME,
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
        ON DELETE CASCADE ON UPDATE CASCADE
);
