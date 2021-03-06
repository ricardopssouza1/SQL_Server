CREATE PROCEDURE dbo.USP_ApagaArquivo (
    @Ds_Arquivo VARCHAR(255)
)
AS 
/****************************************************************************
* Procedure.....: [USP_ArquivoExiste]                  Data: 2017-12-01     *
* Criado por....: RSouza                                                    *
* Objetivo......: Deletar o arquivo no diretório informado                  *
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
* -- EXEC USP_ApagaArquivo 'C:\TEMP\PastaComZip\teste.txt'                  *
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
    
    SET NOCOUNT ON

    DECLARE @Query VARCHAR(8000) = 'del /F /Q "' + @Ds_Arquivo + '"'

    DECLARE @Retorno TABLE ( Resultado VARCHAR(MAX) )

    INSERT INTO @Retorno
    EXEC master.dbo.xp_cmdshell 
        @command_string = @Query
    
END