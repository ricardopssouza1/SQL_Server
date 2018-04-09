-- ===================================  
--         Usando CTE - exemplo 1  
-- ===================================  
;with exemplo(valor,nome)
as
(
select 1, 'teste' 
)
select * from Exemplo

-- ===================================  
--         Usando CTE - exemplo 2
-- ===================================  
;with exemplo(valor)
as
(
select 1
union all
select 2
union all
select 8
)
select SUM(valor) from Exemplo