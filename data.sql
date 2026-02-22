-- =============================================
-- Dados de Teste - E-commerce
-- Formacao SQL DB Specialist - DIO
-- =============================================

USE ecommerce;

-- Clientes PF
INSERT INTO Cliente (TipoCliente, Email, Telefone, Endereco, Cidade, Estado, CEP) VALUES
('PF', 'maria@email.com', '41999001001', 'Rua das Flores 100', 'Curitiba', 'PR', '80010000'),
('PF', 'joao@email.com', '11998002002', 'Av Paulista 500', 'Sao Paulo', 'SP', '01310100'),
('PF', 'ana@email.com', '21997003003', 'Rua Copacabana 200', 'Rio de Janeiro', 'RJ', '22070001'),
('PF', 'carlos@email.com', '31996004004', 'Av Afonso Pena 300', 'Belo Horizonte', 'MG', '30130000');

INSERT INTO ClientePF (idCliente, Nome, CPF, DataNascimento) VALUES
(1, 'Maria Silva', '12345678901', '1990-05-15'),
(2, 'Joao Santos', '23456789012', '1985-08-22'),
(3, 'Ana Oliveira', '34567890123', '1992-12-01'),
(4, 'Carlos Souza', '45678901234', '1988-03-10');

-- Clientes PJ
INSERT INTO Cliente (TipoCliente, Email, Telefone, Endereco, Cidade, Estado, CEP) VALUES
('PJ', 'techcorp@empresa.com', '41330001001', 'Rua Industrial 500', 'Curitiba', 'PR', '81200000'),
('PJ', 'megastore@empresa.com', '11330002002', 'Av Comercial 1000', 'Sao Paulo', 'SP', '04543000'),
('PJ', 'datasoft@empresa.com', '21330003003', 'Rua Tecnologia 250', 'Rio de Janeiro', 'RJ', '20040020');

INSERT INTO ClientePJ (idCliente, RazaoSocial, CNPJ, NomeFantasia) VALUES
(5, 'TechCorp Ltda', '12345678000101', 'TechCorp'),
(6, 'MegaStore SA', '23456789000102', 'MegaStore'),
(7, 'DataSoft Ltda', '34567890000103', 'DataSoft');

-- Produtos
INSERT INTO Produto (Nome, Categoria, Descricao, Valor, Avaliacao) VALUES
('Notebook Gamer', 'Eletronico', 'Notebook com 16GB RAM e SSD 512GB', 4500.00, 4.5),
('Smartphone Pro', 'Eletronico', 'Smartphone 128GB com camera 108MP', 2800.00, 4.2),
('Camiseta Algodao', 'Vestuario', 'Camiseta 100 porcento algodao tamanho M', 59.90, 4.0),
('Arroz Integral 5kg', 'Alimentos', 'Arroz integral organico', 28.50, 4.8),
('Mesa de Escritorio', 'Moveis', 'Mesa em L para escritorio', 890.00, 4.3),
('Boneco Articulado', 'Brinquedos', 'Boneco de acao colecionavel', 149.90, 3.9),
('Livro SQL Avancado', 'Livros', 'Guia completo de SQL para profissionais', 89.90, 4.7),
('Teclado Mecanico', 'Eletronico', 'Teclado mecanico RGB switch blue', 350.00, 4.6),
('Monitor 27 pol', 'Eletronico', 'Monitor IPS 27 polegadas 144Hz', 1800.00, 4.4),
('Mouse Gamer', 'Eletronico', 'Mouse com sensor optico 16000 DPI', 250.00, 4.1);

-- Fornecedores
INSERT INTO Fornecedor (RazaoSocial, CNPJ, Telefone, Email) VALUES
('TechDistribuidora SA', '11111111000111', '11400001111', 'vendas@techdist.com'),
('AlimentosBR Ltda', '22222222000122', '21400002222', 'contato@alimentosbr.com'),
('MoveisTop Ltda', '33333333000133', '41400003333', 'vendas@moveistop.com'),
('LivrosMundo SA', '44444444000144', '31400004444', 'comercial@livrosmundo.com'),
('EletroGlobal SA', '55555555000155', '11400005555', 'vendas@eletroglobal.com');

-- Produto_Fornecedor
INSERT INTO Produto_Fornecedor (idProduto, idFornecedor, Quantidade) VALUES
(1, 1, 100), (2, 1, 200), (1, 5, 50),
(3, 1, 500), (4, 2, 1000), (5, 3, 80),
(6, 1, 300), (7, 4, 200), (8, 5, 150),
(9, 5, 100), (10, 5, 250);

-- Estoques
INSERT INTO Estoque (Local, Cidade, Estado) VALUES
('Centro de Distribuicao Sul', 'Curitiba', 'PR'),
('Centro de Distribuicao Sudeste', 'Sao Paulo', 'SP'),
('Centro de Distribuicao Nordeste', 'Recife', 'PE');

-- Produto_Estoque
INSERT INTO Produto_Estoque (idProduto, idEstoque, Quantidade, QuantidadeMinima) VALUES
(1, 1, 30, 10), (1, 2, 50, 15), (2, 1, 80, 20),
(2, 2, 100, 25), (3, 1, 200, 50), (3, 2, 300, 50),
(4, 1, 500, 100), (4, 3, 400, 100), (5, 1, 20, 5),
(6, 2, 150, 30), (7, 1, 8, 10), (7, 2, 60, 15),
(8, 1, 40, 10), (9, 2, 25, 10), (10, 1, 70, 20);

-- Vendedores Terceiros
INSERT INTO VendedorTerceiro (RazaoSocial, CNPJ, Local, NomeFantasia) VALUES
('InfoShop Ltda', '66666666000166', 'Curitiba - PR', 'InfoShop'),
('GadgetStore SA', '77777777000177', 'Sao Paulo - SP', 'GadgetStore'),
('EletroGlobal SA', '55555555000155', 'Sao Paulo - SP', 'EletroGlobal');

-- Produto_Vendedor
INSERT INTO Produto_Vendedor (idProduto, idVendedor, Quantidade) VALUES
(1, 1, 15), (2, 1, 25), (8, 2, 40),
(9, 2, 20), (10, 2, 35), (2, 3, 30),
(8, 3, 20);

-- Pagamentos
INSERT INTO Pagamento (idCliente, TipoPagamento, NumeroCartao, Bandeira, Validade) VALUES
(1, 'Cartao de Credito', '4111111111111111', 'Visa', '2028-12-01'),
(1, 'PIX', NULL, NULL, NULL),
(2, 'Cartao de Credito', '5222222222222222', 'MasterCard', '2027-06-01'),
(2, 'Boleto', NULL, NULL, NULL),
(3, 'Cartao de Debito', '4333333333333333', 'Visa', '2029-03-01'),
(4, 'PIX', NULL, NULL, NULL),
(5, 'Cartao de Credito', '5444444444444444', 'MasterCard', '2028-09-01'),
(5, 'Transferencia', NULL, NULL, NULL),
(6, 'Boleto', NULL, NULL, NULL),
(7, 'Cartao de Credito', '4555555555555555', 'Visa', '2027-12-01');

-- Pedidos
INSERT INTO Pedido (idCliente, StatusPedido, Descricao, Frete) VALUES
(1, 'Entregue', 'Pedido de eletronicos', 25.00),
(1, 'Enviado', 'Pedido de livro', 12.00),
(2, 'Confirmado', 'Pedido de vestuario e alimentos', 18.50),
(3, 'Em processamento', 'Pedido de moveis', 85.00),
(3, 'Entregue', 'Pedido de eletronicos', 30.00),
(4, 'Cancelado', 'Pedido cancelado pelo cliente', 0.00),
(5, 'Entregue', 'Pedido corporativo de equipamentos', 50.00),
(5, 'Enviado', 'Pedido corporativo de acessorios', 35.00),
(5, 'Confirmado', 'Terceiro pedido TechCorp', 40.00),
(6, 'Entregue', 'Pedido MegaStore', 45.00),
(7, 'Em processamento', 'Pedido DataSoft', 22.00);

-- Pedido_Produto
INSERT INTO Pedido_Produto (idPedido, idProduto, Quantidade, ValorUnitario) VALUES
(1, 1, 1, 4500.00), (1, 10, 1, 250.00),
(2, 7, 2, 89.90),
(3, 3, 3, 59.90), (3, 4, 2, 28.50),
(4, 5, 1, 890.00),
(5, 2, 1, 2800.00), (5, 8, 1, 350.00),
(6, 9, 1, 1800.00),
(7, 1, 5, 4500.00), (7, 9, 3, 1800.00),
(8, 8, 10, 350.00), (8, 10, 10, 250.00),
(9, 2, 3, 2800.00),
(10, 1, 2, 4500.00), (10, 2, 2, 2800.00),
(11, 7, 5, 89.90), (11, 8, 2, 350.00);

-- Pedido_Pagamento
INSERT INTO Pedido_Pagamento (idPedido, idPagamento, ValorPago) VALUES
(1, 1, 4775.00),
(2, 2, 191.80),
(3, 3, 255.20),
(4, 5, 975.00),
(5, 5, 3180.00),
(7, 7, 27950.00),
(8, 8, 6035.00),
(9, 7, 8440.00),
(10, 9, 14645.00),
(11, 10, 1171.50);

-- Entregas
INSERT INTO Entrega (idPedido, StatusEntrega, CodigoRastreio, DataEnvio, DataEntrega) VALUES
(1, 'Entregue', 'BR123456789AA', '2026-02-10 08:00:00', '2026-02-15 14:30:00'),
(2, 'Em transito', 'BR234567890BB', '2026-02-20 09:15:00', NULL),
(5, 'Entregue', 'BR345678901CC', '2026-02-05 10:00:00', '2026-02-09 16:45:00'),
(7, 'Entregue', 'BR456789012DD', '2026-02-01 07:30:00', '2026-02-06 11:20:00'),
(8, 'Em transito', 'BR567890123EE', '2026-02-21 08:45:00', NULL),
(10, 'Entregue', 'BR678901234FF', '2026-02-08 09:00:00', '2026-02-12 15:00:00');
