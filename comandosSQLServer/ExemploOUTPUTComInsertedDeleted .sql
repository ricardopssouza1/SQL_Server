-- ===============================================
-- Cl�usula OUTPUT para instru��es INSERT e DELETE
-- ===============================================



-- ===============================================
--                  INSERT
-- ===============================================
Declare @Inventario as table(ID int identity(1,1),CentroCusto varchar(100),DsProduto varchar(100), DsModelo varchar(100), Quantidade numeric(15))
Insert into @Inventario(CentroCusto,DsProduto,DsModelo,Quantidade) 
Output INSERTED.*
Values
 ('S�o Paulo'     ,'IPhone' ,'6s'      ,'50')
,('S�o Paulo'     ,'IPhone' ,'7'       ,'10')
,('S�o Paulo'     ,'IPhone' ,'x'       ,'200')
,('S�o Paulo'     ,'Samsung','Galaxy S','200')
,('S�o Paulo'     ,'Samsung','Note 8'  ,'100')
,('Rio de Janeiro','IPhone' ,'6s'      ,'100')
,('Rio de Janeiro','IPhone' ,'7'       ,'50')
,('Rio de Janeiro','IPhone' ,'X'       ,'150')
,('Rio de Janeiro','Samsung','Galaxy S','200')
,('Rio de Janeiro','Samsung','Note 8'  ,'150')

-- ===============================================
--                   DELETE
-- ===============================================

Declare @Inventario as table(ID int identity(1,1),CentroCusto varchar(100),DsProduto varchar(100), DsModelo varchar(100), Quantidade numeric(15))
Insert into @Inventario(CentroCusto,DsProduto,DsModelo,Quantidade) 
Values
 ('S�o Paulo'     ,'IPhone' ,'6s'      ,'50')
,('S�o Paulo'     ,'IPhone' ,'7'       ,'10')
,('S�o Paulo'     ,'IPhone' ,'x'       ,'200')
,('S�o Paulo'     ,'Samsung','Galaxy S','200')
,('S�o Paulo'     ,'Samsung','Note 8'  ,'100')
,('Rio de Janeiro','IPhone' ,'6s'      ,'100')
,('Rio de Janeiro','IPhone' ,'7'       ,'50')
,('Rio de Janeiro','IPhone' ,'X'       ,'150')
,('Rio de Janeiro','Samsung','Galaxy S','200')
,('Rio de Janeiro','Samsung','Note 8'  ,'150')


Delete 
  From @Inventario 
Output DELETED.*  
 Where CentroCusto = 'Rio de Janeiro'

-- ===============================================
-- EXIBINDO O QUE N�O FOI DELETADO
-- ===============================================

Select * From @Inventario






-- ===============================================
-- INSERT (guardando o resultado em tabela)
-- ===============================================
Declare @Inventario as table(ID int identity(1,1),CentroCusto varchar(100),DsProduto varchar(100), DsModelo varchar(100), Quantidade numeric(15))
Declare @Resultado as table(ID int ,CentroCusto varchar(100),DsProduto varchar(100), DsModelo varchar(100), Quantidade numeric(15))
Insert into @Inventario(CentroCusto,DsProduto,DsModelo,Quantidade) 
Output INSERTED.* into @Resultado
Values
 ('S�o Paulo'     ,'IPhone' ,'6s'      ,'50')
,('S�o Paulo'     ,'IPhone' ,'7'       ,'10')
,('S�o Paulo'     ,'IPhone' ,'x'       ,'200')
,('S�o Paulo'     ,'Samsung','Galaxy S','200')
,('S�o Paulo'     ,'Samsung','Note 8'  ,'100')
,('Rio de Janeiro','IPhone' ,'6s'      ,'100')
,('Rio de Janeiro','IPhone' ,'7'       ,'50')
,('Rio de Janeiro','IPhone' ,'X'       ,'150')
,('Rio de Janeiro','Samsung','Galaxy S','200')
,('Rio de Janeiro','Samsung','Note 8'  ,'150')

select * from @Resultado

-- ===============================================
--   DELETE (guardando o resultado em tabela)
-- ===============================================

Declare @Inventario as table(ID int identity(1,1),CentroCusto varchar(100),DsProduto varchar(100), DsModelo varchar(100), Quantidade numeric(15))
Declare @Resultado as table(ID int ,CentroCusto varchar(100),DsProduto varchar(100), DsModelo varchar(100), Quantidade numeric(15))
Insert into @Inventario(CentroCusto,DsProduto,DsModelo,Quantidade) 
Values
 ('S�o Paulo'     ,'IPhone' ,'6s'      ,'50')
,('S�o Paulo'     ,'IPhone' ,'7'       ,'10')
,('S�o Paulo'     ,'IPhone' ,'x'       ,'200')
,('S�o Paulo'     ,'Samsung','Galaxy S','200')
,('S�o Paulo'     ,'Samsung','Note 8'  ,'100')
,('Rio de Janeiro','IPhone' ,'6s'      ,'100')
,('Rio de Janeiro','IPhone' ,'7'       ,'50')
,('Rio de Janeiro','IPhone' ,'X'       ,'150')
,('Rio de Janeiro','Samsung','Galaxy S','200')
,('Rio de Janeiro','Samsung','Note 8'  ,'150')


Delete 
  From @Inventario 
Output DELETED.*  into @Resultado
 Where CentroCusto = 'Rio de Janeiro'


select * from @Resultado