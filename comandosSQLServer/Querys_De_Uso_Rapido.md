# Querys de uso Rápido
<br />
<br />
**Desativando e Ativando Identity**
<p>SET IDENTITY_INSERT Tabela Off<br />
Go<br />
<br />
Scripts SQL<br />
Go<br />
<br />
SET IDENTITY_INSERT Tabela On<br />
</p>
**Obtendo o último Identity**
Select Ident_Current('Tabela')

**Alterando o Identity**
DBCC CheckIdent('Tabela',Reseed,@Identity)

**Informando o Collate em uma cláusula Where**
Select campo
From tabela
Where campo collate Latin_General_CI_AS like ‘%á%’

**Informando o Collate em uma coluna e na cláusula Where**
Select Campo collate Latin_General_CI_AS
From tabela
Where Campo collate Latin_General_CI_AS like ‘%á%’

**Alterando o Collate de uma Coluna**
Alter Table Users
Alter Column [Password] Varchar(12) Collate SQL_Latin1_General_CP1_CS_AS

**RowNumber**
select 
  row_number() over(order by name asc) as Linha,
  name, recovery_model_desc
from sys.databases 
where database_id < 5;

**Retorna o último valor de identity no mesmo escopo**
select SCOPE_IDENTITY() AS scope_identity

**Retorna o último valor de identity inserido na tabela**
select @@IDENTITY AS identity






