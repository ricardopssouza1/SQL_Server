CREATE PROCEDURE USP_ProcedureCriptografada
WITH ENCRYPTION
AS 
BEGIN
	
    PRINT 'Exemplo "WITH ENCRYPTION"'	
    SELECT 'Utilize o "WITH ENCRYPTION" no inicio da procedure'

END

GO

CREATE FUNCTION Fn_FunctionCriptografada()
RETURNS VARCHAR(255)
WITH ENCRYPTION
AS 
BEGIN
	
	DECLARE @Retorno varchar(255)
	    SET @Retorno = 'Utilize o "WITH ENCRYPTION" no inicio da Fun��o'

    PRINT 'Exemplo "WITH ENCRYPTION"'	
    return @Retorno

END

GO

CREATE VIEW VW_ViewCriptografada
WITH ENCRYPTION
AS
SELECT CASE 
       WHEN (DATEPART(DW,GETDATE() )) = 1
	   THEN 'DOMINGO'
       WHEN (DATEPART(DW,GETDATE() )) = 2
	   THEN 'SEGUNDA-FEIRA'
       WHEN (DATEPART(DW,GETDATE() )) = 3
	   THEN 'TER�A-FEIRA'
       WHEN (DATEPART(DW,GETDATE() )) = 4
	   THEN 'QUARTA-FEIRA'
       WHEN (DATEPART(DW,GETDATE() )) = 5
	   THEN 'QUINTA-FEIRA'
       WHEN (DATEPART(DW,GETDATE() )) = 6
	   THEN 'SEXTA-FEIRA'
       WHEN (DATEPART(DW,GETDATE() )) = 7
	   THEN 'S�BADO'
	   END AS DS_DIA