CREATE PROCEDURE dbo.USP_ArquivoExiste (
    @Ds_Arquivo VARCHAR(255),
    @Saida INT OUTPUT
)
AS 
/****************************************************************************
* Function......: [USP_ArquivoExiste]                  Data: 2017-12-01     *
* Criado por....: RSouza                                                    *
* Objetivo......: Identifica se o arquivo realmente existe                  *
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
* -- DECLARE @Retorno bit                                                   *
* -- EXEC USP_ArquivoExiste 'C:\TEMP\PastaComZip\teste.txt', @Retorno OUTPUT*
* -- SELECT @Retorno                                                        *
* -- 1 - Verdadeiro / 0 - Falso                                             *
* -- 																		*
* --  Habilitando o xp_cmdshell                                             * 
* -- 																		*
* -- exec sp_configure 'show advanced options', 1                           *
* -- go                                                                     *
* -- reconfigure                                                            *
* -- go                                                                     *
* -- EXEC sp_configure 'xp_cmdshell', 1                                     *
* -- go                                                                     *
* -- reconfigure                                                            *
* -- go                                                                     *
* --                                                                        *
****************************************************************************/  

BEGIN

    DECLARE @Query VARCHAR(8000) = 'IF EXIST "' + @Ds_Arquivo + '" ( echo 1 ) ELSE ( echo 0 )'

    DECLARE @Retorno TABLE (
        Linha INT IDENTITY(1, 1),
        Resultado VARCHAR(MAX)
    )

    INSERT INTO @Retorno
    EXEC master.dbo.xp_cmdshell 
        @command_string = @Query

    SELECT @Saida = Resultado
    FROM @Retorno
    WHERE Linha = 1

END