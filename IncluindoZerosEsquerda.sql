-- ======================================================= 
--       Incluindo zeros a esquerda 
-- ======================================================= 

SELECT REPLICATE('0',(3 - LEN(Campo))) + Convert(varchar(10),Campo)
  FROM Tabela