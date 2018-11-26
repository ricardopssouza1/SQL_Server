# Querys de uso Rápido
 
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
<p>
Select Ident_Current('Tabela')
<p/>

**Alterando o Identity**
<p>
DBCC CheckIdent('Tabela',Reseed,@Identity)
</p>

**Informando o Collate em uma cláusula Where**
<p>
Select campo<br />
From tabela<br />
Where campo collate Latin_General_CI_AS like ‘%á%’<br />
</p>

**Informando o Collate em uma coluna e na cláusula Where**
<p>
Select Campo collate Latin_General_CI_AS<br />
From tabela<br />
Where Campo collate Latin_General_CI_AS like ‘%á%’<br />
</p>

**Alterando o Collate de uma Coluna**
<p>
Alter Table Users<br />
Alter Column [Password] Varchar(12) Collate SQL_Latin1_General_CP1_CS_AS
</p>

**RowNumber**
<p>
select <br />
  row_number() over(order by name asc) as Linha,<br />
  name, recovery_model_desc<br />
from sys.databases <br />
where database_id < 5;<br />
</p>

**Retorna o último valor de identity no mesmo escopo**
<p>
select SCOPE_IDENTITY() AS scope_identity
</p>
**Retorna o último valor de identity inserido na tabela**
<p>
select @@IDENTITY AS identity
</p>





