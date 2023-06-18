CREATE DATABASE LOJA_DEPARTAMENTOS;
USE LOJA_DEPARTAMENTOS;

CREATE TABLE departamentos(
	id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(220),
    sigla VARCHAR(45),
    chefe_departamento_id INT,
    ativo BOOLEAN
);

CREATE TABLE vendedores(
	id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(220),
    rg VARCHAR(7),
    data_admissao DATE,
    ativo BOOLEAN,
    
    -- ESTRANGEIRAS
    departamento_id INT
);

CREATE TABLE registro_vendas(
	id_registro_venda int primary key auto_increment,
    total_venda DECIMAL(10,2),
    data_venda DATETIME,
    status_comissao boolean,
    percent_comissao DECIMAL(10,2),
    
    -- ESTRANGEIRAS
    vendedor_id INT,
	departamento_id INT
    
);


CREATE TABLE produtos(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(220),
    valor_unitario DECIMAL(10,2),
    qtd_estoque INT,

    departamento_id INT
);





CREATE TABLE itens(
	registro_venda_id INT,
    produto_id INT,
	-- ---------------------
    quantidade_produto int,
	valor_unitario DECIMAL(10,2),
	subtotal DECIMAL(10,2)
    
);



-- ALTER TABLE DEPARTAMENTOS VENDEDORES
ALTER TABLE vendedores
ADD CONSTRAINT FK_departamento_vendedores
FOREIGN KEY (departamento_id) REFERENCES departamentos(id_departamento);

-- ALTER TABLE DEPARTAMENTOS REGISTRO_VENDAS
ALTER TABLE registro_vendas
ADD CONSTRAINT FK_departamento_registro_vendas
FOREIGN KEY (departamento_id) REFERENCES departamentos(id_departamento);

-- ALTER TABLE VENDEDOR REGISTRO_VENDAS
ALTER TABLE registro_vendas
ADD CONSTRAINT FK_vendedores_registro_vendas
FOREIGN KEY (vendedor_id) REFERENCES vendedores(id_vendedor);

-- ALTER TABLE REGISTRO_VENDAS INTENS
ALTER TABLE itens
ADD CONSTRAINT FK_resgistro_vendas_itens
FOREIGN KEY (registro_venda_id) REFERENCES registro_vendas(id_registro_venda );

-- ALTER TABLE REGISTRO_VENDAS INTENS
ALTER TABLE itens
ADD CONSTRAINT FK_produto_itens
FOREIGN KEY (produto_id) REFERENCES produtos(id_produto);


-- ALTER TABLE REGISTRO_VENDAS INTENS
ALTER TABLE produtos
ADD CONSTRAINT FK_produto_departamentos
FOREIGN KEY (departamento_id) REFERENCES departamentos(id_departamento);


CREATE TABLE produtos_log(
	id_log INT PRIMARY KEY AUTO_INCREMENT,
	id_produto INT,
    nome VARCHAR(220),
    valor_unitario DECIMAL(10,2),
    qtd_estoque INT,
    departamento_id INT,
    data_exclusao DATE
);