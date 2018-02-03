CREATE PROCEDURE dbo.USP_CriaDiretorio (
    @Ds_Diretorio VARCHAR(255)
)
AS 
/****************************************************************************
* Procedure.....: [USP_CriaDiretorio]                  Data: 2017-12-01     *
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
* -- EXEC USP_CriaDiretorio 'C:\TEMP\PastaComZip2\'                         *
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

    DECLARE @Query VARCHAR(8000) = 'mkdir "' + @Ds_Diretorio + '"'

    DECLARE @Retorno TABLE ( Resultado VARCHAR(MAX) )

    INSERT INTO @Retorno
    EXEC master.dbo.xp_cmdshell 
        @command_string = @Query
    
END