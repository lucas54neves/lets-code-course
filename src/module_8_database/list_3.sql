--1) Obtenha uma tabela que contenha o id do pedido e o valor total do mesmo.
--
select
	result1.order_id,
	sum(result1.total_price)
from (
	select
		o.order_id,
		od.unit_price * od.quantity * (1 - od.discount) as "total_price"
	from orders o
	inner join order_details od
		on od.order_id = o.order_id
) as result1
group by result1.order_id
;

--2) Obtenha uma lista dos 10 clientes que realizaram o maior número de pedidos, bem como o
--número de pedidos de cada, ordenados em ordem decrescente de nº de pedidos.
--
select
	c.customer_id,
	count(o.order_id) as "number_of_orders"
from customers c
inner join orders o
	on o.customer_id = c.customer_id
group by c.customer_id
order by
	"number_of_orders" desc
limit 10
;

--3) Obtenha uma tabela que contenha o id e o valor total do pedido e o nome do cliente que o realizou.
--
select
	result1.order_id,
	sum(result1.price),
	result1.contact_name
from (
	select
		o.order_id,
		c.contact_name,
		(od.unit_price * od.quantity) * (1 - od.discount) as "price"
	from customers c
	inner join orders o
		on o.customer_id = c.customer_id
	inner join order_details od
		on od.order_id = o.order_id
) as result1
group by result1.order_id, result1.contact_name
;

--4) Obtenha uma tabela que contenha o país do cliente e o valor da compra que ele realizou.
--
select
	result2.customer_id,
	result2.price,
	c2.country
from (
	select
		result1.customer_id,
		sum(result1.unit_price) as "price"
	from (
		select
			c.customer_id,
			c.country,
			o.order_id,
			(od.unit_price * od.quantity) as "unit_price"
		from customers c
		inner join orders o
			on o.customer_id = c.customer_id 
		inner join order_details od
			on od.order_id = o.order_id
	) as result1
	group by result1.customer_id
) as result2
inner join customers c2
	on c2.customer_id = result2.customer_id
;
--5) Obtenha uma tabela que contenha uma lista dos países dos clientes e o valor total de compras
--realizadas em cada um dos países. Ordene a tabela, na order descrescente, considerando o valor
--total de compras realizadas por país.
--
select
	result1.country,
	sum(result1.price) as "total_price"
from (
	select
		c.country,
		od.unit_price * od.quantity as "price"
	from customers c
	inner join orders o
		on o.customer_id = c.customer_id
	inner join order_details od
		on od.order_id = o.order_id
) as result1
group by result1.country
order by
	"total_price" desc
;

--6) Obtenha uma tabela com o valor médio das vendas em cada mês (ordenados do mês com mais vendas
--para o mês com menos vendas).
select
	result1.year_month,
	avg(result1.price) as "avg_price"
from (
	select
		to_char(o.order_date, 'YYYYMM') as "year_month",
		(od.unit_price * od.quantity) as "price"
	from orders o
	inner join order_details od
		on od.order_id = o.order_id
) as result1
group by result1.year_month
order by
	avg_price desc
;