--Na tabela Products:
--
--1) Quantos são os produtos que são da CategoryID 2?
select count (*) as "Quantidade de produtos com o category_id = 2"
from products p
where p.category_id = 2
;

--
--2) Quantos produtos com SupplierID idêntico ao CategoryID e que custam mais do que 10?
select count (*) as "Quantidade de produtos com o supplier_id e category_id identicos e custam mais do que 10"
from products p
where p.supplier_id = p.category_id and p.unit_price > 10
;

--
--3) Liste todos os nomes de produtos, suas *"Units"* e seus respectivos preços distintos
--que pertecem às categorias 1, 2 e 7.
select p.product_name, p.quantity_per_unit, p.unit_price
from products p
where p.category_id in (1, 2, 7)
;

--
--4) Liste os 5 primeiros nomes de produtos que começam com "A" ou tenham "h" no meio do nome.
--Retorne em português os nomes das colunas.
select
	p.product_id as "ID do produto",
	p.product_name  as "Nome do produto",
	p.supplier_id as "ID do fornecedor",
	p.category_id as "ID da categoria",
	p.quantity_per_unit as "Quantidade por unidade",
	p.unit_price as "Preco por unidade",
	p.units_in_stock as "Unidades em estoque",
	p.units_on_order as "Unidades sob encomenda",
	p.reorder_level as "Nivel de reabastecimento",
	p.discontinued as "Interrompido"
from products p
where p.product_name like 'A%' or p.product_name like '%h%'
limit 5
;

--
--5) Dê a média de preços de todos os produtos das categorias entre 1 e 5. Arredonde para 1 casa decimal.
--
select round(avg(p.unit_price)::numeric, 1)
from products p
where p.category_id in (1, 5)
;

--6) Liste a média de preços e a quantidade de produtos distintos por SupplierID; ordene pela média
--de preço, do maior para o menor, e só mostre os 5 primeiros.
select
	p.supplier_id as "SupplierID",
	round(avg(p.unit_price)::numeric, 2) as "Media de precos",
	count(p.product_id) as "Quantidade de produtos"
from products p
group by p.supplier_id
order by (avg(p.unit_price))
limit 5
;
