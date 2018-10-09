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
-- GROUP BY
-- =========================

SELECT 
    CentroCusto, SUM(Quantidade)
FROM
    @Inventario
GROUP BY CentroCusto

-- =========================
-- GROUP BY ROLLUP
-- =========================

SELECT 
    CentroCusto, SUM(Quantidade)
FROM
    @Inventario
GROUP BY ROLLUP(CentroCusto)

-- =========================
-- GROUP BY ROLLUP (melhorar a descrição)
-- =========================

SELECT 
    ISNULL(CentroCusto, 'Total') AS CentroCusto,
    SUM(Quantidade)
FROM
    @Inventario
GROUP BY ROLLUP (CentroCusto)

-- =========================
-- GROUP BY por Centro de Custo e Produto
-- =========================

SELECT 
    CentroCusto, DsProduto, SUM(Quantidade)
FROM
    @Inventario
GROUP BY CentroCusto, DsProduto

-- =========================
-- GROUP BY ROLLUP por Centro de Custo e Produto
-- =========================

SELECT 
    CentroCusto, DsProduto, SUM(Quantidade)
FROM
    @Inventario
GROUP BY ROLLUP (CentroCusto , DsProduto)

-- =========================
-- EXEMPLO DE ROLLUP PARCIAL
-- =========================

SELECT 
    CentroCusto, ISNULL(DsProduto,'Total Parcial'), SUM(Quantidade)
FROM
    @Inventario
GROUP BY CentroCusto, ROLLUP (DsProduto)


