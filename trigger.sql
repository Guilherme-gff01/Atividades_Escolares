-- ----------------------------------------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER log_produtos BEFORE DELETE ON produtos
FOR EACH ROW
BEGIN
INSERT INTO produtos_log (id_produto,nome,valor_unitario,qtd_estoque,departamento_id ,data_exclusao)
VALUES (OLD.id_produto,OLD.nome,OLD.valor_unitario,OLD.qtd_estoque,OLD.departamento_id ,NOW());
END //
DELIMITER ;

-- ----------------------------------------------------------------------------------------------------
DELIMITER //

CREATE TRIGGER delete_registro BEFORE DELETE ON registro_vendas
FOR EACH ROW
BEGIN
DELETE FROM itens WHERE registro_venda_id = OLD.id_registro_venda;
END //

DELIMITER ;

-- --------------------------------------------------------------------------------------------------
-- Trigger para atualizar o valor unitário do produto quando seu estoque for atualizado
DELIMITER //
CREATE TRIGGER atualizar_valor_unitario_produto AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.qtd_estoque > 0 THEN
        SET NEW.valor_unitario = NEW.valor_unitario * (NEW.qtd_estoque + OLD.qtd_estoque) / NEW.qtd_estoque;
    ELSE
        SET NEW.valor_unitario = 0;
    END IF;
END;

DELIMITER ;
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- Trigger para calcular a comissão de um vendedor em um registro de venda
DELIMITER //
CREATE TRIGGER calcular_comissao_vendedor AFTER INSERT ON registro_vendas
FOR EACH ROW
BEGIN
    DECLARE comissao DECIMAL(10,2);
    SET comissao = NEW.total_venda * NEW.percent_comissao / 100;
    
    UPDATE vendedores
    SET comissao = comissao + NEW.total_venda
    WHERE id_vendedor = NEW.vendedor_id;
END;

DELIMITER ;
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- Trigger para atualizar o estoque de produtos após uma venda
DELIMITER //
CREATE TRIGGER atualiza_estoque_produto AFTER INSERT ON itens
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET qtd_estoque = qtd_estoque - NEW.quantidade_produto
    WHERE id_produto = NEW.produto_id;
END;

DELIMITER ;
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- Trigger para calcular o subtotal de um item de venda
DELIMITER //
CREATE TRIGGER calcular_subtotal_item BEFORE INSERT ON itens
FOR EACH ROW
BEGIN
    SET NEW.subtotal = NEW.quantidade_produto * NEW.valor_unitario;
END;
DELIMITER ;
-- --------------------------------------------------------------------------------------------------
