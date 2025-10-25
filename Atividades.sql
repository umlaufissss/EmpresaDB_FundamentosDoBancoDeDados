-- 1)
SELECT c.nome_cliente, co.tipo_contrato, f.nome_funcionario, ord.data_abertura
FROM ordem_servico ord
JOIN cliente c ON c.id_cliente = ord.id_cliente
JOIN contrato co ON co.id_cliente = c.id_cliente
JOIN funcionario f ON f.id_funcionario = ord.id_funcionario
GROUP BY c.nome_cliente, co.tipo_contrato, f.nome_funcionario, ord.data_abertura;

-- 2)
SELECT p.nome_produto, p.estoque_atual, iord.quantidade,
            COALESCE(SUM(iord.quantidade), 0) AS quantidade_utilizada
FROM item_ordem_servico iord
RIGHT JOIN produto p ON p.id_produto = iord.id_produto
GROUP BY p.nome_produto, p.estoque_atual, iord.quantidade;

-- 3)
SELECT c.nome_cliente,
            COUNT(DISTINCT con.id_contrato) AS totalDeContratos,
            COUNT(DISTINCT os.id_os) AS totalDeOrdensDeServico
FROM cliente c
LEFT JOIN contrato con ON con.id_cliente = c.id_cliente
LEFT JOIN ordem_servico os ON os.id_cliente = c.id_cliente
GROUP BY c.nome_cliente;

-- 4)
SELECT f.nome_funcionario, c.nome_cargo, d.nome_departamento,
            COUNT(DISTINCT os.id_os) AS ordens_executadas
FROM ordem_servico os
JOIN funcionario f ON f.id_funcionario = os.id_funcionario
JOIN cargo c ON c.id_cargo = f.id_cargo
JOIN departamento d ON d.id_departamento = f.id_departamento
GROUP BY f.nome_funcionario, c.nome_cargo, d.nome_departamento;

-- 5)
SELECT c.nome_cliente,
            SUM(os.valor_total) AS ValorEmOrdem,
            SUM(v.valor_total) AS ValorEmGastos
FROM ordem_servico os 
JOIN cliente c ON c.id_cliente = os.id_cliente
JOIN venda v ON v.id_cliente = c.id_cliente
GROUP BY c.nome_cliente
ORDER BY ValorEmOrdem DESC;

-- 6)
SELECT c.nome_cliente
FROM cliente c
JOIN ordem_servico os ON os.id_cliente = c.id_cliente
LEFT JOIN venda v ON v.id_cliente = c.id_cliente
WHERE c.tipo_cliente = 'PF'
AND os.status_os = 'finalizada'
GROUP BY c.id_cliente, c.nome_cliente 
HAVING COUNT(os.id_os) >=1 AND COUNT(v.id_venda) = 0;

-- 7)
SELECT f.nome_funcionario, ca.nome_cargo, 
            COUNT(itos.id_item_os) AS TotaldeProdutos
FROM funcionario f
JOIN cargo ca ON ca.id_cargo = f.id_cargo
JOIN ordem_servico os ON os.id_funcionario = f.id_funcionario
JOIN item_ordem_servico itos ON itos.id_os = os.id_os
GROUP BY f.nome_funcionario, ca.nome_cargo;

-- 8)
SELECT p.nome_produto, 
            SUM(itos.quantidade) AS QuantidadeOrdens,
            SUM(itve.quantidade) AS QuantidadeVendas,
            SUM(itos.quantidade + itve.quantidade) AS TotalGeral
FROM produto p
LEFT JOIN item_ordem_servico itos ON itos.id_produto = p.id_produto
LEFT JOIN item_venda itve ON itve.id_produto = p.id_produto
GROUP BY p.nome_produto;

-- 9)
SELECT c.nome_cliente, co.tipo_contrato
FROM cliente c
JOIN contrato co ON co.id_cliente = c.id_cliente
LEFT JOIN ordem_servico os ON os.id_cliente = c.id_cliente
WHERE c.tipo_cliente = 'PJ'
AND co.status_contrato = 'ativo'
AND co.status_contrato != 'cancelado'
GROUP BY c.nome_cliente, co.tipo_contrato;
-- 10)
SELECT f.nome_funcionario AS Funcionário, avg(os.valor_total) AS ValorMédio
FROM ordem_servico os
JOIN funcionario f ON f.id_funcionario = os.id_funcionario
WHERE os.status_os = 'finalizada'
GROUP BY f.nome_funcionario;

-- 11)
SELECT p.nome_produto, itve.valor_unitario*itve.quantidade AS  ValorTotalGasto
FROM item_venda itve
JOIN produto p ON p.id_produto = itve.id_produto
WHERE itve.valor_unitario*itve.quantidade > (SELECT AVG(itve.valor_unitario*itve.quantidade)
                      FROM item_venda itve)
GROUP BY p.nome_produto, ValorTotalGasto;

-- 12)
SELECT c.nome_cliente, v.valor_total AS ValorDaVenda,
CASE WHEN (v.valor_total > (SELECT AVG(v.valor_total) FROM venda v)) THEN 'Acima da Média'
     ELSE 'Abaixo da Média' END AS Comparação
FROM venda v
JOIN cliente c ON c.id_cliente = v.id_cliente
GROUP BY c.nome_cliente, v.valor_total;

-- 13)
SELECT c.nome_cliente
FROM cliente c
JOIN venda v ON v.id_cliente = c.id_cliente
LEFT JOIN item_venda itve ON itve.id_venda = v.id_venda
JOIN produto p ON p.id_produto = itve.id_produto
LEFT JOIN item_ordem_servico itos ON itos.id_produto = p.id_produto

