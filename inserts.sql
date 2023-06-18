
-- INSERÇÕES PARA A TABELA DEPARTAMENTOS
INSERT INTO departamentos (nome, sigla, chefe_departamento_id, ativo) VALUES
('Vendas', 'VD', 1, true),
('Recursos Humanos', 'RH', 2, true),
('Tecnologia da Informação', 'TI', 3, true),
('Marketing', 'MK', 4, true),
('Financeiro', 'FN', 5, true),
('Compras', 'CP', 6, true),
('Logística', 'LG', 7, true),
('Produção', 'PR', 8, true);

-- INSERÇÕES PARA A TABELA VENDEDORES
INSERT INTO vendedores (nome, rg, data_admissao, ativo, departamento_id) VALUES
('Ana Silva', '1234567', '2020-01-01', true, 1),
('Bruno Santos', '7654321', '2018-05-01', true, 2),
('Carlos Souza', '9876543', '2017-08-01', true, 3),
('Daniel Oliveira', '5432167', '2019-11-01', true, 4),
('Elaine Costa', '2468013', '2021-03-01', true, 5),
('Fábio Lima', '1357902', '2016-09-01', true, 6),
('Gabriela Torres', '8765432', '2015-06-01', true, 7),
('Hugo Pereira', '3456789', '2022-02-01', true, 8),
-- ----------------------------------------------------------
('Isabela Almeida', '9876540', '2023-01-01', true, 1),
('João Santos', '5678901', '2023-02-01', true, 2),
('Laura Ferreira', '4321567', '2023-03-01', true, 3),
('Marcelo Silva', '6789012', '2023-04-01', true, 4),
('Natalia Oliveira', '3214567', '2023-05-01', true, 5),
('Pedro Souza', '8901234', '2023-06-01', true, 6),
('Rafaela Costa', '6543210', '2023-07-01', true, 7),
('Samuel Lima', '9012345', '2023-08-01', true, 8);


-- INSERÇÕES PARA A TABELA REGISTRO_VENDAS
INSERT INTO registro_vendas (total_venda, data_venda, status_comissao, percent_comissao, vendedor_id, departamento_id) VALUES
(77.70, '2022-05-01 10:30:00', true, 10.00, 1, 1),
(89.90, '2022-05-02 11:45:00', false, 8.00, 2, 2),
(399.80, '2022-05-03 13:20:00', true, 12.00, 3, 3),
(183.60, '2022-05-04 15:10:00', false, 5.00, 4, 4),
(197.70, '2022-05-05 16:30:00', true, 15.00, 5, 5),
(119.80, '2022-05-06 09:00:00', false, 7.00, 6, 6),
(129.90, '2022-05-07 10:30:00', true, 10.00, 7, 7),
(359.80, '2022-05-08 11:45:00', false, 8.00, 8, 8),
-- ----------------------------------------------------------------------
(129.90, '2023-05-09 10:30:00', true, 10.00, 9, 1),
(29.90, '2023-05-10 11:45:00', false, 8.00, 10, 2),
(299.90, '2023-05-11 13:20:00', true, 12.00, 11, 3),
(39.90, '2023-05-12 15:10:00', false, 5.00, 12, 4),
(79.90, '2023-05-13 16:30:00', true, 15.00, 13, 5),
(49.90, '2023-05-14 09:00:00', false, 7.00, 14, 6),
(149.90, '2023-05-15 10:30:00', true, 10.00, 15, 7),
(34.90, '2023-05-16 11:45:00', false, 8.00, 16, 8);



-- INSERÇÕES PARA A TABELA PRODUTOS

INSERT INTO produtos (nome, valor_unitario, qtd_estoque,departamento_id)
VALUES 
    ('Camiseta', 25.90, 100,1),
    ('Calça Jeans', 89.90, 50,2),
    ('Tênis', 199.90, 30,3),
    ('Blusa', 45.90, 80,4),
    ('Saia', 65.90, 40,5),
    ('Bermuda', 59.90, 60,6),
    ('Vestido', 129.90, 20,7),
    ('Jaqueta', 179.90, 10,8),
    -- -----------------------------------------------------------------
    ('Óculos de Sol', 129.90, 50,1),
    ('Chinelo', 29.90, 100,2),
    ('Relógio', 299.90, 20,3),
    ('Boné', 39.90, 80,4),
    ('Sandália', 79.90, 60,5),
    ('Colar', 49.90, 40,6),
    ('Bolsa', 149.90, 30,7),
    ('Cinto', 34.90, 70,8),
    ('Brinco', 19.90, 90,1),
    ('Pulseira', 24.90, 70,2),
    ('Anel', 39.90, 60,3),
    ('Perfume', 199.90, 25,4),
    ('Gravata', 49.90, 50,5),
    ('Sapato', 189.90, 15,6),
    ('Camisa', 79.90, 40,7),
    ('Calça Social', 99.90, 30,8);

-- INSERÇÕES PARA A TABELA ITENS

INSERT INTO itens (registro_venda_id, produto_id, quantidade_produto, valor_unitario, subtotal)
VALUES
    (1, 1, 3, 25.90, 77.70),
    (2, 2, 1, 89.90, 89.90),
    (3, 3, 2, 199.90, 399.80),
    (4, 4, 4, 45.90, 183.60),
    (5, 5, 3, 65.90, 197.70),
    (6, 6, 2, 59.90, 119.80),
    (7, 7, 1, 129.90, 129.90),
    (8, 8, 2, 179.90, 359.80),
    -- --------------------------------------------------------------------
    (9,9,1,129.90,129.90),
    (10,10,1,29.90,29.90),
    (11,11,1,299.90,299.90),
    (12,12,1,39.90,39.90),
    (13,13,1,79.90,79.90),
    (14,14,1, 49.90, 49.90),
    (15,15,1,149.90,149.90),
    (16,16,1,34.90,34.90);
