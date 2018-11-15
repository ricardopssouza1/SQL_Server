
/* Restringindo apenas numeros ou textos  */

drop table #teste

create table #teste (
ApenasNumero varchar(100)	    constraint LetraRestringida  check (ApenasNumero not like '%[^0-9]%')
,ApenasTexto varchar(100)	    constraint NumeroRestringido  check (ApenasTexto  not like '%[^a-z]%' )
,ApenasNumeroTexto varchar(100) constraint RestringeCaracteresEspeciais check (ApenasNumeroTexto  not like '%[^A-Z 0-9]%')
)


/* teste insert */
insert into #teste (ApenasNumero)
values('1')
insert into #teste (ApenasNumeroTexto)
values('A2')
insert into #teste (ApenasTexto)
values('A')


/* simulando o erro */
insert into #teste (ApenasTexto)
values('1')
insert into #teste (ApenasNumero)
values('A')
insert into #teste (ApenasNumeroTexto)
values('/')




insert into #teste (ApenasNumero, ApenasNumeroTexto, ApenasTexto)
values('1','A','A1')

/*forçando o erro*/
insert into #teste (ApenasNumero, ApenasNumeroTexto, ApenasTexto)
values('A','A','A1')

insert into #teste (ApenasNumero, ApenasNumeroTexto, ApenasTexto)
values('1','A','A1')