--Selecione todos os clientes que começam com a letra 'A'.
select *
from cliente c
where c.nome_cli like 'A%'
;

--Selecione todos os vendedores que tem salario maio que R$5.000,00
select *
from (
	select CAST(v.sal_fixo AS double precision) as sal_fixo_float, *
	from vendedor v
) as vend
where vend.sal_fixo_float  > 5000
;

--Selecione todos os pedidos onde a quantidade de produto seja maior que 3.
select *
from pedido p
inner join item_pedido ip
	on p.cod_ped = ip.cod_ped
where ip.qtd_ped > 3
;