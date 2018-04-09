CREATE FUNCTION [dbo].[Fn_DecimalBinario](@Entrada NUMERIC(15))
RETURNS VARCHAR(255)
AS
BEGIN

/****************************************************************************  
* Function......: [Fn_DecimalBinario]                      Data: 2018-04-05 *
* Criado por....: Ricardo Souza                                             *  
* Objetivo......: Retorna o binario partir do numero decimal informado      *  
*---------------------------------------------------------------------------*  
* Tabelas envolvidas:           |Select |Insert |Update |Delete |           *  
* - NDA                         |  [X]  |  [ ]  |  [ ]  |  [ ]  |           *  
*                                                                           *  
* Chamada por:                                                              *  
*---------------------------------------------------------------------------*  
* Historico de Modificações:                                                *  
*  Data      Autor           OS      Descricao                              *  
*                                                                           * 
* Forma de uso                                                              *
* -- SELECT DBO.Fn_DecimalBinario(9)                                        *
*                                                                           *
*****************************************************************************/ 

    DECLARE @Saida VARCHAR(255) = ''
      WHILE @Entrada > 0 
	  BEGIN
        SET @Saida   = ( @Saida + CONVERT(VARCHAR(255),(@Entrada % 2)) )
        SET @Entrada = ( @Entrada / 2)
      END

    RETURN REVERSE(@Saida)

END


