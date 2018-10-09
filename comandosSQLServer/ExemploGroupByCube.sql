Declare @Inventario as table(ID int identity(1,1),CentroCusto varchar(100),DsProduto varchar(100), DsModelo varchar(100), Quantidade numeric(15))
insert into @Inventario(CentroCusto,DsProduto,DsModelo,Quantidade)
Values
 ('São Paulo'     ,'IPhone' ,'6s'      ,'50')
,('São Paulo'     ,'IPhone' ,'7'       ,'10')
,('São Paulo'     ,'IPhone' ,'x'       ,'200')
,('São Paulo'     ,'Samsung','Galaxy S','200')
,('São Paulo'     ,'Samsung','Note 8'  ,'100')
,('Rio de Janeiro','IPhone' ,'6s'      ,'100')
,('Rio de Janeiro','IPhone' ,'7'       ,'50')
,('Rio de Janeiro','IPhone' ,'X'       ,'150')
,('Rio de Janeiro','Samsung','Galaxy S','200')
,('Rio de Janeiro','Samsung','Note 8'  ,'150')

-- =========================
-- EXEMPLO DE CUBE
-- =========================

SELECT 
    CentroCusto, SUM(Quantidade)
FROM
    @Inventario
GROUP BY
   CUBE(CentroCusto)
ORDER BY
   CentroCusto

-- =========================
-- EXEMPLO DE CUBE COM SUBTOTAL
-- =========================

SELECT
   ISNULL(CentroCusto,'TOTAL GERAL'),
   ISNULL(DsProduto,'SUBTOTAL'),
   SUM(Quantidade)
FROM
   @Inventario
GROUP BY
   CUBE(CentroCusto,DsProduto)
ORDER BY
   CentroCusto,
   DsProduto

-- =========================
-- EXEMPLO DE CUBE COM SUBTOTAL + TOTAL
-- =========================

SELECT
   CASE WHEN (DsProduto IS NULL AND CentroCusto IS NULL)
        THEN 'TOTAL GERAL'
		WHEN (DsProduto IS NOT NULL AND CentroCusto IS NULL)
        THEN '-'
		ELSE CentroCusto END AS CentroCusto ,
   CASE WHEN (DsProduto IS NULL AND CentroCusto IS NOT NULL)
        THEN 'SUBTOTAL'
		WHEN (DsProduto IS NULL AND CentroCusto IS NULL)
        THEN '-'
		ELSE DsProduto END AS DsProduto ,
   SUM(Quantidade)
FROM
   @Inventario
GROUP BY
   CUBE(CentroCusto,DsProduto)
ORDER BY
   CentroCusto,
   DsProduto