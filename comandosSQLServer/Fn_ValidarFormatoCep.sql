CREATE FUNCTION [dbo].[Fn_ValidarFormatoCep](@Nr_Cep CHAR(8))  
RETURNS BIT  
 AS   
 /***************************************************************************  
* Function......: [Fn_ValidarFormatoCep]                    Data: 2016-12-16 *
* Criado por....: Ricardo Souza                                             *  
* Objetivo......: Retorna 0(ZERO) CEP invalido e 1(UM) CEP valido           *  
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
* -- SELECT DBO.Fn_ValidarFormatoCep('11700000')                            *
* -- 1 - Verdadeiro / 0 - Falso                                             *
*****************************************************************************/ 
BEGIN

    DECLARE @chr CHAR, @tamanho INT
    
    -- Verifica se possui 8 caracteres
    IF (LEN(@Nr_Cep) < 8)
        RETURN 0
        
    WHILE (LEN(@Nr_Cep) > 0)
    BEGIN
    
        SELECT @tamanho = LEN(@Nr_Cep), @chr = LEFT(@Nr_Cep,1)
        
        -- Verifica se o número informado possui apenas números
        IF CHARINDEX(@chr,'0123456789') = 0
        BEGIN
            RETURN 0
            BREAK
        END
        
        SET @Nr_Cep = STUFF(@Nr_Cep,1,1,'') -- retira o primeiro dígito
        
    END
    
    RETURN 1
    
END