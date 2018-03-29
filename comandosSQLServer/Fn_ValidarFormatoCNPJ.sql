CREATE FUNCTION [dbo].[Fn_ValidarFormatoCNPJ] ( @CNPJ VARCHAR(14) )
RETURNS BIT
AS
BEGIN

    DECLARE
        @INDICE INT,
        @SOMA INT,
        @DIG1 INT,
        @DIG2 INT,
        @VAR1 INT,
        @VAR2 INT,
        @RESULTADO CHAR(1)
 

    SET @SOMA = 0
    SET @INDICE = 1
    SET @RESULTADO = 0
    SET @VAR1 = 5 /* 1a Parte do Algorítimo começando de "5" */

    WHILE ( @INDICE <= 4 )
    BEGIN
        SET @SOMA = @SOMA + CONVERT(INT, SUBSTRING(@CNPJ, @INDICE, 1)) * @VAR1
        SET @INDICE = @INDICE + 1 /* Navegando um-a-um até < = 4, as quatro primeira posições */
        SET @VAR1 = @VAR1 - 1       /* subtraindo o algorítimo de 5 até 2 */
    END

       
    SET @VAR2 = 9
    WHILE ( @INDICE <= 12 )
    BEGIN
        SET @SOMA = @SOMA + CONVERT(INT, SUBSTRING(@CNPJ, @INDICE, 1)) * @VAR2
        SET @INDICE = @INDICE + 1
        SET @VAR2 = @VAR2 - 1            
    END

    SET @DIG1 = ( @SOMA % 11 )


   /* SE O RESTO DA DIVISÃO FOR < 2, O DIGITO = 0 */
    IF @DIG1 < 2
        SET @DIG1 = 0;
    ELSE /* SE O RESTO DA DIVISÃO NÃO FOR < 2*/
        SET @DIG1 = 11 - ( @SOMA % 11 );


    SET @INDICE = 1
    SET @SOMA = 0
    SET @VAR1 = 6 /* 2a Parte do Algorítimo começando de "6" */
    SET @RESULTADO = 0


    WHILE ( @INDICE <= 5 )
    BEGIN
        SET @SOMA = @SOMA + CONVERT(INT, SUBSTRING(@CNPJ, @INDICE, 1)) * @VAR1
        SET @INDICE = @INDICE + 1 /* Navegando um-a-um até < = 5, as quatro primeira posições */
        SET @VAR1 = @VAR1 - 1       /* subtraindo o algorítimo de 6 até 2 */
    END



    /* CÁLCULO DA 2ª PARTE DO ALGORÍTIOM 98765432 */
    SET @VAR2 = 9
    WHILE ( @INDICE <= 13 )
    BEGIN
        SET @SOMA = @SOMA + CONVERT(INT, SUBSTRING(@CNPJ, @INDICE, 1)) * @VAR2
        SET @INDICE = @INDICE + 1
        SET @VAR2 = @VAR2 - 1            
    END

 
    SET @DIG2 = ( @SOMA % 11 )

 
   /* SE O RESTO DA DIVISÃO FOR < 2, O DIGITO = 0 */

    IF @DIG2 < 2
        SET @DIG2 = 0;

    ELSE /* SE O RESTO DA DIVISÃO NÃO FOR < 2*/
        SET @DIG2 = 11 - ( @SOMA % 11 );


    IF ( @DIG1 = SUBSTRING(@CNPJ, LEN(@CNPJ) - 1, 1) ) AND ( @DIG2 = SUBSTRING(@CNPJ, LEN(@CNPJ), 1) )
        SET @RESULTADO = 1
    ELSE
        SET @RESULTADO = 0

 
 
    RETURN @RESULTADO
 

END