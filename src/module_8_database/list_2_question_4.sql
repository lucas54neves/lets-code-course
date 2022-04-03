--Na tabela de Suppliers:
--
--1) Conte todos os diferentes fornecedores por país. Agrupe categorizando os países em 'Americas'
--(se o país for USA, Brazil ou Canada) e 'Outros' senão. Detalhe, estamos buscando aqueles cujo DDD
--não comece com o dígito 1.
--
select
	s.country,
	count(s.supplier_id) as "number_suppliers",
	case
		when s.country in ('USA', 'Brazil', 'Canada') then 'Americas'
		else 'Outros'
	end as "Categoria"
from suppliers s
where s.phone not like '(1%' and s.phone not like '1%'
group by s.country
;

--2) Existe alguma cidade com mais de um código de área de telefone?
select *
from (
	select res.city, count(res.city) as "number_cities"
	from (
		select
			s.city,
			SUBSTRING (
				s.phone,
				'([0-9]{1,3})'
			) as ddd
		from suppliers s
	) as res
	group by (res.city)
) as res2
where res2."number_cities" > 1
;

--
--3) Tome a primeira letra de cada cidade (ex. "N" para "New Orleans"). Quais são as 5 iniciais de
--nomes de cidades que têm mais fornecedores associados (em ordem descrescente de fornecedores/cidade)?
select res.cities_initials, count(res.supplier_id) as "number_supplies"
from (
	select
		SUBSTRING (
			s.city,
			'([A-Z]{1,1})'
		) as "cities_initials",
		s.city,
		s.supplier_id
	from suppliers s
) as res
group by (res.cities_initials)
order by ("number_supplies") desc
limit 5
;