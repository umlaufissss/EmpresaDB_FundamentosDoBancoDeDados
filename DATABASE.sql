-- Tabela: departamento
-- Armazena os departamentos dos funcionários.
CREATE TABLE departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL
);

-- Tabela: cargo
-- Armazena os cargos dos funcionários.
CREATE TABLE cargo (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    nome_cargo VARCHAR(100) NOT NULL
);

-- Tabela: funcionario
-- Armazena os funcionários, vinculados a cargo e departamento.
CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    id_cargo INT NOT NULL,
    id_departamento INT NOT NULL,
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo),
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

-- Tabela: cliente
-- Armazena os clientes, com tipo (PF para pessoa física, PJ para pessoa jurídica).
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    tipo_cliente CHAR(2) NOT NULL CHECK (tipo_cliente IN ('PF', 'PJ'))
);

-- Tabela: contrato
-- Armazena os contratos associados aos clientes, com tipo e status.
CREATE TABLE contrato (
    id_contrato INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_contrato VARCHAR(50) NOT NULL,
    status_contrato VARCHAR(20) NOT NULL CHECK (status_contrato IN ('ativo', 'encerrado')),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela: produto
-- Armazena os produtos com estoque atual.
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    estoque_atual INT NOT NULL DEFAULT 0 CHECK (estoque_atual >= 0)
) ;

-- Tabela: ordem_servico
-- Armazena as ordens de serviço, vinculadas ao cliente e ao funcionário responsável.
-- Inclui data de abertura, status e valor total.
CREATE TABLE ordem_servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_abertura DATE NOT NULL,
    status_os VARCHAR(20) NOT NULL CHECK (status_os IN ('aberta', 'finalizada', 'cancelada')),
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK (valor_total >= 0),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

-- Tabela: item_ordem_servico
-- Armazena os itens utilizados nas ordens de serviço (produtos e quantidades).
CREATE TABLE item_ordem_servico (
    id_item_os INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    FOREIGN KEY (id_os) REFERENCES ordem_servico(id_os),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Tabela: venda
-- Armazena as vendas, vinculadas ao cliente.
CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_venda DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK (valor_total >= 0),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela: item_venda
-- Armazena os itens das vendas (produtos, quantidades, preços unitários).
CREATE TABLE item_venda (
    id_item_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    valor_unitario DECIMAL(10, 2) NOT NULL CHECK (valor_unitario > 0),
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
) ;

