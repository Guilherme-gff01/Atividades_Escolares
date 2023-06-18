select * from departamentos;
select * from vendedores;
select * from registro_vendas;
select * from produtos;
select * from itens ;

-- 1 - Relação dos vendedores da loja (nome, RG, data de admissão e nome do departamento em que está alocado).


-- Essa consulta irá retornar os seguintes campos nome do vendedor, RG, data de admissão e nome do departamento em que o vendedor está alocado.Isso atraves da conexão dentre 
-- duas tabelas, departamentos e vendedores
SELECT v.nome, v.rg, v.data_admissao, d.nome AS nome_departamento
FROM vendedores v
INNER JOIN departamentos d ON v.departamento_id = d.id_departamento;

-- 2 - Quais são os departamentos da loja (sigla e nome) e com quais produtos cada um opera.

-- SELECT d.sigla, d.nome AS nome_departamento, p.nome AS nome_produto
-- FROM departamentos d
-- LEFT JOIN vendedores v ON d.id_departamento = v.departamento_id
-- LEFT JOIN registro_vendas rv ON d.id_departamento = rv.departamento_id
-- LEFT JOIN itens i ON rv.id_registro_venda = i.registro_venda_id
-- LEFT JOIN produtos p ON i.produto_id = p.id_produto
-- GROUP BY d.sigla, d.nome, p.nome;

-- Essa consulta irá retornar os seguintes campos: sigla do departamento, nome do departamento e nome do produto.
-- É importante notar que um departamento pode operar com vários produtos e, portanto, pode haver várias linhas para o mesmo departamento com produtos diferentes.
SELECT d.sigla, d.nome AS nome_departamento, p.nome AS nome_produto from produtos as p JOIN departamentos as d ON p.departamento_id = d.id_departamento;


-- 3 - Dada a matrícula de um vendedor, listar as vendas efetuadas por ele para um período entre 2 datas.


-- substituir o rg pelo rg do vendedor desejado e 'DATA_INICIAL' e 'DATA_FINAL' pelas datas de início e fim do período desejado.
-- A consulta retornará o ID da venda, o total da venda e a data da venda para as vendas efetuadas pelo vendedor específico dentro do período especificado. 
-- as datas selecionadas pelo operador between e com a condicional and em relação ao rg do vendedor.

SELECT rv.id_registro_venda, rv.total_venda, rv.data_venda
FROM registro_vendas rv
JOIN vendedores v ON rv.vendedor_id = v.id_vendedor
WHERE v.rg = '1234567'
	AND rv.data_venda BETWEEN '2022-05-01' AND '2022-05-07';
    
   
-- 4 - A partir de um registro de venda identificar quais produtos foram vendidos, em que quantidade, o subtotal por produto e qual o preço de venda total do Registro.


-- pelo ID do registro de venda específico que você deve realizar a consulta. 
-- A consulta retornará o nome do produto, a quantidade vendida, o subtotal por produto e o preço de venda total do registro de venda especificado. Sendo necessario 
-- dois joins, um com a tabela itens e produtos, sendo filtrado pedo id do registro de venda. 

SELECT p.nome AS nome_produto, i.quantidade_produto, i.subtotal, rv.total_venda
FROM registro_vendas rv
JOIN itens i ON rv.id_registro_venda = i.registro_venda_id
JOIN produtos p ON i.produto_id = p.id_produto
WHERE rv.id_registro_venda = '8';



-- 5 - Qual a quantidade existente de cada produto no estoque da loja e o respectivo preço atual de venda.


--  irá retornar o nome do produto, a quantidade existente no estoque e o preço atual de venda de todos os produtos na tabela "produtos".
SELECT p.nome AS nome_produto, p.qtd_estoque, p.valor_unitario
FROM produtos p;

-- 6 - Qual o departamento com maior volume de vendas por mês (em reais).

-- irá agrupar as vendas por mês e departamento, calculando o volume total de vendas em reais para cada combinação.
-- ordenará os resultados em ordem decrescente de volume de vendas e selecionará apenas o primeiro registro,
-- que corresponde ao departamento com o maior volume de vendas em um determinado mês.

SELECT MONTH(rv.data_venda) AS mes, d.nome AS nome_departamento, SUM(rv.total_venda) AS volume_vendas
FROM registro_vendas rv
JOIN departamentos d ON rv.departamento_id = d.id_departamento
GROUP BY MONTH(rv.data_venda), d.nome
ORDER BY volume_vendas DESC
LIMIT 1;


-- 7 - Relatório mensal de vendas efetuadas e comissões pagas por departamento (com detalhes de cada venda).

-- Essa consulta irá retornar o número do mês, o nome do departamento, o ID do registro de venda, o total da venda, 
-- o percentual de comissão e o valor da comissão para cada venda realizada.
-- Os resultados são ordenados por mês, nome do departamento e ID do registro de venda.

SELECT MONTH(rv.data_venda) AS mes, d.nome AS nome_departamento, rv.id_registro_venda, rv.total_venda, rv.percent_comissao, rv.total_venda * (rv.percent_comissao / 100) AS comissao
FROM registro_vendas rv
JOIN departamentos d ON rv.departamento_id = d.id_departamento
ORDER BY mes, nome_departamento, rv.id_registro_venda;





-- 8 - Dado um vendedor, identificar se o mesmo é chefe de departamento e a partir de que data ele assumiu esta chefia.

-- pelo ID do vendedor específico que você deseja consultar.
-- A consulta irá retornar o nome do vendedor, o nome do departamento, o ID do vendedor que é chefe do departamento.
-- foi realizado uma sub-consulta para selecionar todas as datas em que os chefes assumiram a direção assim caso o id não corresponda aparecera vazio

-- SELECT v.nome AS nome_vendedor, d.nome AS nome_departamento, d.chefe_departamento_id
-- FROM vendedores v
-- JOIN departamentos d ON v.id_vendedor = d.chefe_departamento_id
-- WHERE d.id_departamento = '4';


SELECT v.nome AS nome_vendedor, d.nome AS nome_departamento, d.chefe_departamento_id
FROM vendedores v
JOIN departamentos d ON v.id_vendedor = d.chefe_departamento_id
WHERE v.data_admissao = (SELECT v.data_admissao from departamentos d  INNER JOIN 
            vendedores v ON v.id_vendedor = d.chefe_departamento_id
            WHERE d.chefe_departamento_id = '4');


-- ================================================================================================================================

-- 1 - Selecionar o nome do departamento, o nome do vendedor e a data de venda das vendas que tiveram um subtotal maior que 100:


SELECT departamentos.nome AS nome_departamento, vendedores.nome, registro_vendas.data_venda
FROM registro_vendas
JOIN vendedores ON registro_vendas.vendedor_id = vendedores.id_vendedor
JOIN departamentos ON registro_vendas.departamento_id = departamentos.id_departamento
JOIN itens ON registro_vendas.id_registro_venda = itens.registro_venda_id
WHERE itens.subtotal > 100;

-- 2 - Selecionar o nome do vendedor, o nome do produto e o subtotal de cada item vendido:

SELECT vendedores.nome, produtos.nome AS nome_produto, itens.subtotal
FROM itens
JOIN produtos ON itens.produto_id = produtos.id_produto
JOIN registro_vendas ON itens.registro_venda_id = registro_vendas.id_registro_venda
JOIN vendedores ON registro_vendas.vendedor_id = vendedores.id_vendedor;

-- 3 - Selecionar o nome do produto, o valor unitário e a quantidade vendida em cada venda registrada:

SELECT produtos.nome, produtos.valor_unitario, itens.quantidade_produto
FROM itens
JOIN produtos ON itens.produto_id = produtos.id_produto
JOIN registro_vendas ON itens.registro_venda_id = registro_vendas.id_registro_venda;

-- 4 - Selecionar o nome do departamento, o nome do vendedor e o valor total das vendas realizadas por ele:

SELECT departamentos.nome AS nome_departamento, vendedores.nome, SUM(registro_vendas.total_venda) AS valor_total_vendas
FROM registro_vendas
JOIN vendedores ON registro_vendas.vendedor_id = vendedores.id_vendedor
JOIN departamentos ON registro_vendas.departamento_id = departamentos.id_departamento
GROUP BY departamentos.nome, vendedores.nome;

-- 5 - Selecionar o nome do departamento, o nome do vendedor e a data de venda das vendas que tiveram comissão de mais de 10%:
SELECT departamentos.nome AS nome_departamento, vendedores.nome, registro_vendas.data_venda,registro_vendas.percent_comissao
FROM registro_vendas
JOIN vendedores ON registro_vendas.vendedor_id = vendedores.id_vendedor
JOIN departamentos ON registro_vendas.departamento_id = departamentos.id_departamento
WHERE registro_vendas.percent_comissao > 10;

-- 6 - Selecionar o nome do produto, o nome do departamento ao qual pertence e a quantidade em estoque:

SELECT produtos.nome, departamentos.nome AS nome_departamento, produtos.qtd_estoque
FROM produtos
JOIN departamentos ON produtos.departamento_id = departamentos.id_departamento;

-- 7 - Selecionar o nome do departamento, o total de vendas registradas e a média do total de vendas:

SELECT departamentos.nome, COUNT(registro_vendas.id_registro_venda) AS total_vendas, ROUND(AVG(registro_vendas.total_venda), 2) AS media_vendas
FROM departamentos
JOIN registro_vendas ON departamentos.id_departamento = registro_vendas.departamento_id
GROUP BY departamentos.nome;

-- 8 -  Todos os itens referentes a cada registro de venda
SELECT rv.id_registro_venda, p.nome AS nome_produto, i.quantidade_produto, i.valor_unitario, i.subtotal
FROM registro_vendas rv
JOIN itens i ON rv.id_registro_venda = i.registro_venda_id
JOIN produtos p ON i.produto_id = p.id_produto
ORDER BY rv.id_registro_venda;