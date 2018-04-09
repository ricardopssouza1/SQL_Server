CREATE FUNCTION [dbo].[Fn_DecimalTime](@Entrada DECIMAL(18,2), @flg BIT = 1)
RETURNS TIME(0)
AS

/****************************************************************************  
* Function......: [Fn_DecimalTime]                         Data: 2018-04-05 *
* Criado por....: Ricardo Souza                                             *  
* Objetivo......: Exibe em horas o numero decimal informado                 *  
*---------------------------------------------------------------------------*  
* Tabelas envolvidas:           |Select |Insert |Update |Delete |           *  
* - NDA                         |  [ ]  |  [ ]  |  [ ]  |  [ ]  |           *  
*                                                                           *  
* Chamada por:                                                              *  
*---------------------------------------------------------------------------*  
* Historico de Modificações:                                                *  
*  Data      Autor           OS      Descricao                              *  
*                                                                           * 
* Forma de uso                                                              *
* -- SELECT DBO.Fn_DecimalTime '12.30', 1                                   *
*                                                                           * 
* -- @flg = 0 Quando o valor decimal estiver no formato de hora.            *
*           Ex.: 12,30, Saída: 12:30                                        * 
* -- @flg = 1 Quando precisar converter decimal em tempo.                   *
*           Ex: Entrada: 12.90, Saída: 12:54*                               *
*****************************************************************************/ 

BEGIN
 
DECLARE @result AS TIME(0)
 
IF @flg = 1
SELECT @result = CONVERT(TIME(0), DATEADD(MINUTE, 60 * (ISNULL(@Entrada, 00.00)), 0))
ELSE
SELECT @result = CAST(RIGHT('0' + REPLACE(CAST(@Entrada AS VARCHAR(10)), '.', ':'), 5) AS TIME)
 
RETURN @result
 
END
