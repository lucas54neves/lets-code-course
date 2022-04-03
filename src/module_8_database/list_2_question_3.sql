--Na tabela Orders:
--
--1) Liste o top 3 de funcionários com mais vendas no primeiro trimestre de 1996.
--
select o.employee_id, count(o.order_id) as "number_orders"
from orders o
where o.order_date < '1997-04-04' and o.order_date >= '1997-01-01'
group by (o.employee_id)
order by "number_orders" desc
limit 3
;

--2) Liste os clientes com mais pedidos - mas somente aqueles que tiverem a partir de 2 pedidos.
--Corte explicitamente os clientes que compraram de funcionários sem ID.
select *
from (
	select
		o.customer_id,
		count(o.order_id) as "number_orders"
	from orders o
	where o.employee_id is not null
	group by o.customer_id
) as orders_result
where orders_result."number_orders" > 1
;