-- =============================================
--   Somando horas, acima das 24 horas do dia
-- =============================================

declare @tempo table (hora varchar(9))

insert into @tempo values ('23:59')
insert into @tempo values ('03:31')


select minutos_total / 60 as horas, minutos_total % 60 as minutos
from (
select sum(
 cast(left(hora,charindex(':',hora) - 1) as int) * 60 +
 cast(right(hora,len(hora)-charindex(':',hora)) as int)) as minutos_total
from @tempo) as resultado