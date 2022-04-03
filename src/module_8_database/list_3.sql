--1) Obtenha uma tabela que contenha o id do pedido e o valor total do mesmo.
--
select
	res."Codigo pedido",
	sum(res."Preco produto") as "Valor Total"
from (
	select
		p.cod_ped as "Codigo pedido",
		(ip.qtd_ped * p2.unid_prod) as "Preco produto"
	from pedido p
	inner join item_pedido ip
		on p.cod_ped = ip.cod_ped
	inner join produto p2
		on ip.cod_prod = p2.cod_prod
) as res
group by res."Codigo pedido"
;

--2) Obtenha uma lista dos 10 clientes que realizaram o maior número de pedidos, bem como o
--número de pedidos de cada, ordenados em ordem decrescente de nº de pedidos.
--
select
	res.cod_cli,
	count(res.cod_cli) as "number_pedidos",
	string_agg(res.cod_ped::text, ', ' order by res.cod_ped) as "pedidos"
from (
select
	c.cod_cli,
	c.nome_cli,
	p.cod_ped
from cliente c
inner join pedido p
	on c.cod_cli = p.cod_cli
) as res
group by res.cod_cli
--order by "number_pedidos" desc
;

--3) Obtenha uma tabela que contenha o id e o valor total do pedido e o nome do cliente que o realizou.
--
select res2."ID do pedido", res2."Preco total", c.nome_cli as "Nome do cliente"
from (
	select res."ID do pedido", sum(res."Preco do produto") as "Preco total"
	from (
		select
			p.cod_ped as "ID do pedido",
			(ip.qtd_ped * p2.unid_prod) as "Preco do produto"
		from pedido p
		inner join item_pedido ip
			on ip.cod_ped = p.cod_ped
		inner join produto p2
			on p2.cod_prod = ip.cod_prod
	) as res
	group by (res."ID do pedido")
) as res2
inner join pedido p3
	on p3.cod_ped = res2."ID do pedido"
inner join cliente c
	on p3.cod_cli = c.cod_cli
;

--4) Obtenha uma tabela que contenha o país do cliente e o valor da compra que ele realizou.
--
--5) Obtenha uma tabela que contenha uma lista dos países dos clientes e o valor total de compras
--realizadas em cada um dos países. Ordene a tabela, na order descrescente, considerando o valor
--total de compras realizadas por país.
--
--6) Obtenha uma tabela com o valor médio das vendas em cada mês (ordenados do mês com mais vendas
--para o mês com menos vendas).