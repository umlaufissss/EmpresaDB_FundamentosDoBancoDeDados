-- Inserção de dados para empresa_db (MySQL)

-- Tabela: departamento
INSERT INTO departamento (nome_departamento) VALUES
('TI'),
('Manutenção'),
('Vendas'),
('Administrativo');

-- Tabela: cargo
INSERT INTO cargo (nome_cargo) VALUES
('Técnico'),
('Gerente'),
('Vendedor'),
('Analista');

-- Tabela: funcionario
INSERT INTO funcionario (nome_funcionario, id_cargo, id_departamento) VALUES
('João Silva', 1, 1),
('Maria Oliveira', 2, 2),
('Pedro Santos', 3, 3),
('Ana Costa', 1, 2),
('Lucas Pereira', 4, 4);

-- Tabela: cliente
INSERT INTO cliente (nome_cliente, tipo_cliente) VALUES
('Carlos Almeida', 'PF'),
('Empresa XYZ Ltda', 'PJ'),
('Fernanda Lima', 'PF'),
('Comércio ABC S/A', 'PJ'),
('José Souza', 'PF'),
('Paula Mendes', 'PF'); -- Cliente sem vendas, mas com OS finalizada

-- Tabela: contrato
INSERT INTO contrato (id_cliente, tipo_contrato, status_contrato) VALUES
(1, 'Manutenção Mensal', 'ativo'),
(2, 'Suporte Anual', 'ativo'),
(2, 'Consultoria', 'encerrado'),
(3, 'Manutenção Avulsa', 'encerrado'),
(4, 'Suporte Premium', 'ativo'),
(5, 'Manutenção Mensal', 'ativo');

-- Tabela: produto
INSERT INTO produto (nome_produto, estoque_atual) VALUES
('Monitor LED', 15),  -- Estoque crítico (< 20)
('Teclado Mecânico', 30),  -- Estoque baixo (20-50)
('Mouse Óptico', 100),  -- Estoque normal (> 50)
('Impressora', 45),  -- Estoque baixo
('Cabo HDMI', 60);  -- Estoque normal

-- Tabela: ordem_servico
INSERT INTO ordem_servico (id_cliente, id_funcionario, data_abertura, status_os, valor_total) VALUES
(1, 1, '2025-06-01', 'finalizada', 500.00),
(2, 2, '2025-07-15', 'aberta', 300.00),
(3, 1, '2025-08-20', 'cancelada', 0.00),
(4, 4, '2025-05-10', 'aberta', 750.00), -- Aberta há mais de 60 dias
(5, 3, '2025-09-01', 'finalizada', 1200.00),
(6, 1, '2025-10-01', 'finalizada', 400.00); -- Cliente PF sem vendas

-- Tabela: item_ordem_servico
INSERT INTO item_ordem_servico (id_os, id_produto, quantidade) VALUES
(1, 1, 2), -- Monitor LED
(1, 3, 5), -- Mouse Óptico
(2, 2, 3), -- Teclado Mecânico
(4, 4, 1), -- Impressora
(5, 3, 10), -- Mouse Óptico
(6, 1, 1); -- Monitor LED

-- Tabela: venda
INSERT INTO venda (id_cliente, data_venda, valor_total) VALUES
(1, '2025-08-10', 1500.00),
(2, '2025-09-05', 2000.00),
(3, '2025-07-20', 800.00),
(4, '2025-10-01', 3000.00),
(NULL, '2025-10-15', 500.00); -- Venda sem cliente (para FULL JOIN)

-- Tabela: item_venda
INSERT INTO item_venda (id_venda, id_produto, quantidade, valor_unitario) VALUES
(1, 1, 3, 300.00), -- Monitor LED
(1, 2, 2, 150.00), -- Teclado Mecânico
(2, 3, 20, 50.00), -- Mouse Óptico
(3, 1, 1, 300.00), -- Monitor LED
(4, 4, 2, 1000.00), -- Impressora
(5, 5, 5, 100.00); -- Cabo HDMI

