CREATE PROCEDURE dbo.USP_MoveArquivo (
    @Ds_Arquivo VARCHAR(255),
    @Ds_Diretorio VARCHAR(255),
    @Fl_Sobrescrever BIT = 0
)
AS

/****************************************************************************
* Function......: [USP_MoveArquivo]                    Data: 2017-12-01     *
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
* -- EXEC USP_MoveArquivo 'C:\TEMP\PastaComZip\teste.txt'                   *
* --                    , 'C:\TEMP\PastaSemZip\teste.txt'                   *
* --                    , '0'                                               *
* --                                                                        *
* -- 0 - não sobreescreve / 1 sobreescreve                                  *
* --                                                                        *
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


    DECLARE 
        @Query VARCHAR(8000),
        @Nm_Arquivo_Destino VARCHAR(500) = @Ds_Diretorio + REVERSE(LEFT(REVERSE(@Ds_Arquivo),CHARINDEX('\', REVERSE(@Ds_Arquivo), 1) - 1)),
        @Resultado VARCHAR(MAX)

    
    IF (@Fl_Sobrescrever = 0)
        SET @Query = 'IF EXIST "' + @Nm_Arquivo_Destino + '" ( ECHO Arquivo já existe ) ELSE ( move "' + @Ds_Arquivo + '" "' + @Ds_Diretorio + '")'
    ELSE
        SET @Query = 'move ' + (CASE WHEN @Fl_Sobrescrever = 1 THEN '/Y' ELSE '' END) + ' "' + @Ds_Arquivo + '" "' + @Ds_Diretorio + '"'


    DECLARE @Retorno TABLE (
        Linha INT IDENTITY(1, 1),
        Resultado VARCHAR(MAX)
    )

    INSERT INTO @Retorno
    EXEC master.dbo.xp_cmdshell 
        @command_string = @Query
    

    SELECT @Resultado = LTRIM(RTRIM(Resultado))
    FROM @Retorno
    WHERE Linha = 1
    
    PRINT @Resultado

END