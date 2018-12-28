DECLARE @Produtos TABLE (Codigo INT, Valor  NUMERIC(15,2))
INSERT INTO @Produtos
(Codigo, Valor)
VALUES
 (1, 100)
,(2, 200)
,(3, 300)
,(4,  50)
,(5, 400)


SELECT
A.*, X.Acumulado
FROM @Produtos A
CROSS APPLY ( SELECT SUM(Valor) AS Acumulado
                FROM @Produtos B
               WHERE A.Codigo >= B.Codigo) X
ORDER BY A.Codigo;