					/* trabalhando com datas */

/*OBS: DATEPART e DATENAME funcionam desde o SQL 2008  */

SET LANGUAGE 'Portuguese'

SELECT DATEPART(YEAR,GETDATE())     AS [ANO]
SELECT DATEPART(MONTH,GETDATE())	AS [MES]
SELECT DATEPART(WEEKDAY,GETDATE())	AS [DIA DA SEMANA]
SELECT DATEPART(DAY,GETDATE())		AS [DIA]
SELECT DATEPART(HOUR,GETDATE())		AS [HORA]
SELECT DATEPART(MINUTE,GETDATE())	AS [MINUTO]
SELECT DATEPART(SECOND,GETDATE())	AS [SEGUNDO]
SELECT DATENAME(MONTH,GETDATE())    AS [MES POR EXTENSO]
SELECT DATENAME(WEEKDAY,GETDATE())  AS [DIA DA SEMANA POR EXTENSO]

/* EXEMPLO COMPLETO */
SELECT CONVERT(VARCHAR(30),DATENAME(WEEKDAY,GETDATE())) + ','+ SPACE(1) +
       CONVERT(VARCHAR(2),DATEPART(DAY,GETDATE())) + SPACE(1) + 'de' + SPACE(1) +
       CONVERT(VARCHAR(30),DATENAME(MONTH,GETDATE()))  + SPACE(1) + 'de' + SPACE(1) +
       CONVERT(VARCHAR(4),DATEPART(YEAR,GETDATE()) ) AS [DATA COMPLETA POR EXTENSO]