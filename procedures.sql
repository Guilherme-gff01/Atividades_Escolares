-- inserir deparamento

DELIMITER //
CREATE PROCEDURE inserir_departamento(
	IN nome_departamento VARCHAR(220),
    IN sigla_departamento VARCHAR(45),
    IN chefe_departamento_id INT,
    IN ativo_departamento BOOLEAN
)
BEGIN
	INSERT INTO departamentos (nome, sigla, chefe_departamento_id, ativo)
	VALUES (nome_departamento, sigla_departamento, chefe_departamento_id, ativo_departamento);
END //
DELIMITER ;


-- inserir vendedor 

DELIMITER //
CREATE PROCEDURE inserir_vendedor(
	IN nome_vendedor VARCHAR(220),
    IN rg_vendedor VARCHAR(7),
    IN data_admissao_vendedor DATE,
    IN ativo_vendedor BOOLEAN,
    IN departamento_id INT
)
BEGIN
	INSERT INTO vendedores (nome, rg, data_admissao, ativo, departamento_id)
	VALUES (nome_vendedor, rg_vendedor, data_admissao_vendedor, ativo_vendedor, departamento_id);
END //
DELIMITER ;


-- atualizar vendedor 

DELIMITER //
CREATE PROCEDURE atualizar_vendedor(
	IN vendedor_id INT,
    IN nome_vendedor VARCHAR(220),
    IN rg_vendedor VARCHAR(7),
    IN data_admissao_vendedor DATE,
    IN ativo_vendedor BOOLEAN,
    IN departamento_id INT
)
BEGIN
	UPDATE vendedores
	SET nome = nome_vendedor,
	    rg = rg_vendedor,
	    data_admissao = data_admissao_vendedor,
	    ativo = ativo_vendedor,
	    departamento_id = departamento_id
	WHERE id_vendedor = vendedor_id;
END //
DELIMITER ;


-- atualizar produto 

DELIMITER //
CREATE PROCEDURE atualizar_produto(
	IN produto_id INT,
    IN nome_produto VARCHAR(220),
    IN valor_unitario DECIMAL(10,2),
    IN qtd_estoque INT,
    IN departamento_id INT
)
BEGIN
	UPDATE produtos
	SET nome = nome_produto,
	    valor_unitario = valor_unitario,
	    qtd_estoque = qtd_estoque,
	    departamento_id = departamento_id
	WHERE id_produto = produto_id;
END //
DELIMITER ;



--  inserir registros de vendas juntamente com os itens de venda relacionados

DELIMITER //
CREATE PROCEDURE inserir_venda_e_itens(
	IN total_venda DECIMAL(10,2),
    IN data_venda DATETIME,
    IN status_comissao BOOLEAN,
    IN percent_comissao DECIMAL(10,2),
    IN vendedor_id INT,
    IN departamento_id INT,
    IN produto_id INT,
    IN quantidade_produto INT,
    IN valor_unitario DECIMAL(10,2),
    IN subtotal DECIMAL(10,2)
)
BEGIN
	DECLARE registro_venda_id INT;

	START TRANSACTION;

	INSERT INTO registro_vendas (total_venda, data_venda, status_comissao, percent_comissao, vendedor_id, departamento_id)
	VALUES (total_venda, data_venda, status_comissao, percent_comissao, vendedor_id, departamento_id);

	SET registro_venda_id = LAST_INSERT_ID();

	INSERT INTO itens (registro_venda_id, produto_id, quantidade_produto, valor_unitario, subtotal)
	VALUES (registro_venda_id, produto_id, quantidade_produto, valor_unitario, subtotal);

	COMMIT;
END //
DELIMITER ;
