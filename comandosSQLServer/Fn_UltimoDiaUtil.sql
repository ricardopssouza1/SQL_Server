CREATE FUNCTION  Fn_UltimoDiaUtil (@Data DATETIME) RETURNS VARCHAR (20)
AS
Begin

/****************************************************************************
* Function......: [Fn_UltimoDiaUtil]                      Data: 2018-03-28  *
* Criado por....: RSouza                                                    *
* Objetivo......: Exibe a data do ultimo dia util do mês da data informada  *
*---------------------------------------------------------------------------*
* Tabelas envolvidas:                   |Select |Insert |Update |Delete |   *
*                                       |  [ ]  |  [ ]  |  [ ]  |  [ ]  |   *
*                                                                           *
* Chamada por:                                                              *
*                                                                           *
*---------------------------------------------------------------------------*
* Historico de Modificações:                                                *
*  Data      Autor           OS      Descricao                              *
*                                                                           *
* Forma de uso                                                              *
* -- SELECT DBO.Fn_UltimoDiaUtil(getdate())                                 *
****************************************************************************/

DECLARE @DataSaida AS DATETIME
DECLARE @DataEntrada AS VARCHAR(20)
DECLARE @tempDate AS DATETIME
DECLARE @UltimoDiaDoMes AS DATETIME

SET @DataSaida = @Data -- getdate()
SET @tempDate = DateAdd(MONTH, 1 , @DataSaida)
SET @UltimoDiaDoMes = DateAdd(DAY, -1 , CONVERT(DATETIME, CONVERT(char(2), MONTH(@tempDate)) + '/01/' + CONVERT(char(4), YEAR(@tempDate))))

SELECT @DataEntrada = (
      CASE 
	       WHEN datepart(dw, @UltimoDiaDoMes) = 7 -- Caso seja sábado
           THEN CONVERT(VARCHAR, dateadd(day, -1, @UltimoDiaDoMes), 103)
           WHEN datepart(dw, @UltimoDiaDoMes) = 1 -- Caso seja domingo
	       THEN CONVERT(VARCHAR, dateadd(day, -2, @UltimoDiaDoMes), 103)
           ELSE CONVERT(VARCHAR, @UltimoDiaDoMes, 103)
      END ) 

RETURN @DataEntrada

End