declare @pessoas table
( id int, nome varchar(100) )

insert into @pessoas values
(57,'Jonas Sousa Ferreira da Silva'),
(56,'Jonas Souza Silva'),
(55,'Jo�o Vitor Silva'),
(54,'Maria Jo�o Santos'),
(53,'Vitor Silva Santos'),
(52,'Vitoria Mendes'),
(51,'Jonasi Cunha')

select * from @pessoas where nome like 'Jo[nas]%';
--ou
select * from @pessoas where nome like 'Jo[nas]% Sou[sz]%a [da Silva]%';