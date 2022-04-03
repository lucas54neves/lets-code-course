--Na tabela Customers:
--
--1) Gere uma relação com os nomes dos clientes, suas cidades e países, em ordem alfabética de nome.

select c.contact_name, c.city, c.country
from customers c
order by c.contact_name
;

--2) Na relação do item (1), filtre pelos clientes da Alemanha, da França e da Espanha, excluindo-se 
--os clientes que vivem nas capitais destes países.
select c.contact_name, c.city, c.country
from customers c
where c.country in ('Germany', 'France', 'Spain') and c.city not in ('Berlin', 'Paris', 'Madrid')
order by c.contact_name
;