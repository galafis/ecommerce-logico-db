-- =============================================
-- Consultas SQL Complexas - E-commerce
-- Formacao SQL DB Specialist - DIO
-- Autor: Gabriel Demetrios Lafis
-- =============================================

USE ecommerce;

-- =============================================
-- 1. Recuperacao simples com SELECT
-- Pergunta: Quais sao todos os produtos disponiveis e seus valores?
-- =============================================
SELECT Nome, Categoria, Valor, Avaliacao
FROM Produto
ORDER BY Categoria, Nome;

-- =============================================
-- 2. Filtros com WHERE
-- Pergunta: Quais produtos eletronicos custam mais de R$300?
-- =============================================
SELECT Nome, Valor, Avaliacao
FROM Produto
WHERE Categoria = 'Eletronico' AND Valor > 300.00
ORDER BY Valor DESC;

-- =============================================
-- 3. Atributos derivados com expressoes
-- Pergunta: Qual o valor total de cada item no pedido (quantidade x valor unitario) e o valor com desconto de 10%?
-- =============================================
SELECT 
    pp.idPedido,
    p.Nome AS NomeProduto,
    pp.Quantidade,
    pp.ValorUnitario,
    (pp.Quantidade * pp.ValorUnitario) AS ValorTotal,
    ROUND((pp.Quantidade * pp.ValorUnitario) * 0.90, 2) AS ValorComDesconto10Pct
FROM Pedido_Produto pp
INNER JOIN Produto p ON pp.idProduto = p.idProduto
ORDER BY pp.idPedido;

-- =============================================
-- 4. Ordenacao com ORDER BY
-- Pergunta: Quais clientes PF estao cadastrados, ordenados por data de nascimento?
-- =============================================
SELECT 
    cpf.Nome,
    cpf.CPF,
    cpf.DataNascimento,
    c.Email,
    c.Cidade,
    c.Estado
FROM ClientePF cpf
INNER JOIN Cliente c ON cpf.idCliente = c.idCliente
ORDER BY cpf.DataNascimento ASC;

-- =============================================
-- 5. Quantos pedidos foram feitos por cada cliente?
-- Uso de GROUP BY, COUNT e HAVING
-- =============================================
SELECT 
    c.idCliente,
    COALESCE(cpf.Nome, cpj.RazaoSocial) AS NomeCliente,
    c.TipoCliente,
    COUNT(ped.idPedido) AS TotalPedidos
FROM Cliente c
LEFT JOIN ClientePF cpf ON c.idCliente = cpf.idCliente
LEFT JOIN ClientePJ cpj ON c.idCliente = cpj.idCliente
LEFT JOIN Pedido ped ON c.idCliente = ped.idCliente
GROUP BY c.idCliente, cpf.Nome, cpj.RazaoSocial, c.TipoCliente
HAVING COUNT(ped.idPedido) >= 1
ORDER BY TotalPedidos DESC;

-- =============================================
-- 6. Algum vendedor tambem e fornecedor?
-- Uso de INNER JOIN entre tabelas diferentes pelo CNPJ
-- =============================================
SELECT 
    v.NomeFantasia AS Vendedor,
    v.CNPJ,
    f.RazaoSocial AS Fornecedor
FROM VendedorTerceiro v
INNER JOIN Fornecedor f ON v.CNPJ = f.CNPJ;

-- =============================================
-- 7. Relacao de produtos, fornecedores e estoques
-- Uso de multiplos JOINs
-- =============================================
SELECT 
    p.Nome AS Produto,
    p.Categoria,
    f.RazaoSocial AS Fornecedor,
    pf.Quantidade AS QtdFornecida,
    e.Local AS Estoque,
    pe.Quantidade AS QtdEmEstoque,
    pe.QuantidadeMinima
FROM Produto p
INNER JOIN Produto_Fornecedor pf ON p.idProduto = pf.idProduto
INNER JOIN Fornecedor f ON pf.idFornecedor = f.idFornecedor
LEFT JOIN Produto_Estoque pe ON p.idProduto = pe.idProduto
LEFT JOIN Estoque e ON pe.idEstoque = e.idEstoque
ORDER BY p.Nome, f.RazaoSocial;

-- =============================================
-- 8. Relacao de nomes dos fornecedores e nomes dos produtos
-- =============================================
SELECT 
    f.RazaoSocial AS Fornecedor,
    GROUP_CONCAT(p.Nome ORDER BY p.Nome SEPARATOR ', ') AS Produtos
FROM Fornecedor f
INNER JOIN Produto_Fornecedor pf ON f.idFornecedor = pf.idFornecedor
INNER JOIN Produto p ON pf.idProduto = p.idProduto
GROUP BY f.RazaoSocial
ORDER BY f.RazaoSocial;

-- =============================================
-- 9. Qual o valor total gasto por cada cliente?
-- Uso de SUM, JOIN e subquery
-- =============================================
SELECT 
    c.idCliente,
    COALESCE(cpf.Nome, cpj.RazaoSocial) AS NomeCliente,
    c.TipoCliente,
    COUNT(DISTINCT ped.idPedido) AS TotalPedidos,
    COALESCE(SUM(pp.Quantidade * pp.ValorUnitario), 0) AS ValorTotalProdutos,
    COALESCE(SUM(DISTINCT ped.Frete), 0) AS TotalFrete,
    COALESCE(SUM(pp.Quantidade * pp.ValorUnitario), 0) + COALESCE(SUM(DISTINCT ped.Frete), 0) AS ValorTotalGeral
FROM Cliente c
LEFT JOIN ClientePF cpf ON c.idCliente = cpf.idCliente
LEFT JOIN ClientePJ cpj ON c.idCliente = cpj.idCliente
LEFT JOIN Pedido ped ON c.idCliente = ped.idCliente
LEFT JOIN Pedido_Produto pp ON ped.idPedido = pp.idPedido
WHERE ped.StatusPedido != 'Cancelado' OR ped.StatusPedido IS NULL
GROUP BY c.idCliente, cpf.Nome, cpj.RazaoSocial, c.TipoCliente
ORDER BY ValorTotalGeral DESC;

-- =============================================
-- 10. Quais produtos tem estoque abaixo do minimo?
-- Uso de WHERE com comparacao entre colunas
-- =============================================
SELECT 
    p.Nome AS Produto,
    p.Categoria,
    e.Local AS Estoque,
    pe.Quantidade AS QtdAtual,
    pe.QuantidadeMinima AS QtdMinima,
    (pe.QuantidadeMinima - pe.Quantidade) AS Deficit
FROM Produto_Estoque pe
INNER JOIN Produto p ON pe.idProduto = p.idProduto
INNER JOIN Estoque e ON pe.idEstoque = e.idEstoque
WHERE pe.Quantidade < pe.QuantidadeMinima
ORDER BY Deficit DESC;

-- =============================================
-- 11. Qual a media de valor dos pedidos por status?
-- Uso de AVG, GROUP BY
-- =============================================
SELECT 
    ped.StatusPedido,
    COUNT(ped.idPedido) AS QuantidadePedidos,
    ROUND(AVG(sub.ValorTotal), 2) AS MediaValorPedido,
    ROUND(MIN(sub.ValorTotal), 2) AS MenorPedido,
    ROUND(MAX(sub.ValorTotal), 2) AS MaiorPedido
FROM Pedido ped
INNER JOIN (
    SELECT idPedido, SUM(Quantidade * ValorUnitario) AS ValorTotal
    FROM Pedido_Produto
    GROUP BY idPedido
) sub ON ped.idPedido = sub.idPedido
GROUP BY ped.StatusPedido
ORDER BY MediaValorPedido DESC;

-- =============================================
-- 12. Quais clientes PJ fizeram mais de 2 pedidos?
-- Uso de HAVING com filtro especifico
-- =============================================
SELECT 
    cpj.RazaoSocial,
    cpj.NomeFantasia,
    cpj.CNPJ,
    COUNT(ped.idPedido) AS TotalPedidos
FROM ClientePJ cpj
INNER JOIN Pedido ped ON cpj.idCliente = ped.idCliente
GROUP BY cpj.idCliente, cpj.RazaoSocial, cpj.NomeFantasia, cpj.CNPJ
HAVING COUNT(ped.idPedido) > 2
ORDER BY TotalPedidos DESC;

-- =============================================
-- 13. Status das entregas com informacoes do pedido e cliente
-- Uso de multiplos JOINs
-- =============================================
SELECT 
    ent.CodigoRastreio,
    ent.StatusEntrega,
    COALESCE(cpf.Nome, cpj.RazaoSocial) AS Cliente,
    ped.StatusPedido,
    ent.DataEnvio,
    ent.DataEntrega,
    CASE 
        WHEN ent.DataEntrega IS NOT NULL 
        THEN DATEDIFF(ent.DataEntrega, ent.DataEnvio)
        ELSE DATEDIFF(NOW(), ent.DataEnvio)
    END AS DiasEntrega
FROM Entrega ent
INNER JOIN Pedido ped ON ent.idPedido = ped.idPedido
INNER JOIN Cliente c ON ped.idCliente = c.idCliente
LEFT JOIN ClientePF cpf ON c.idCliente = cpf.idCliente
LEFT JOIN ClientePJ cpj ON c.idCliente = cpj.idCliente
ORDER BY ent.DataEnvio DESC;

-- =============================================
-- 14. Formas de pagamento mais utilizadas
-- =============================================
SELECT 
    pg.TipoPagamento,
    COUNT(ppg.idPedido) AS TotalUsos,
    ROUND(SUM(ppg.ValorPago), 2) AS ValorTotalPago
FROM Pagamento pg
INNER JOIN Pedido_Pagamento ppg ON pg.idPagamento = ppg.idPagamento
GROUP BY pg.TipoPagamento
ORDER BY TotalUsos DESC;
