
CREATE FUNCTION [dbo].[Fn_ValidarFormatoEmail](@Ds_Email varchar(max))
/****************************************************************************  
* Function......: [Fn_ValidarFormatoEmail]                 Data: 2016-12-16 *
* Criado por....: Ricardo Souza                                             *  
* Objetivo......: Retorna 0(ZERO) email invalido e 1(UM) email valido       *  
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
* -- SELECT DBO.Fn_ValidarFormatoEmail('ricardo.ps.souza@gmail.com')        *
* -- 1 - Verdadeiro / 0 - Falso                                             *
*****************************************************************************/  
RETURNS BIT
AS BEGIN
 
    DECLARE @Retorno BIT = 0
 
    SELECT @Retorno = 1
    WHERE @Ds_Email NOT LIKE '%[^a-z,0-9,@,.]%'
    AND @Ds_Email LIKE '%_@_%_.__%'
 
    RETURN @Retorno
 
END