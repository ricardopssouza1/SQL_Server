CREATE PROCEDURE dbo.USP_ListandoArquivo (
    @Ds_Diretorio VARCHAR(255)
)
AS 
/****************************************************************************
* Procedure.....: [USP_ListandoArquivo]                Data: 2017-12-01     *
* Criado por....: RSouza                                                    *
* Objetivo......: Listando arquivos no diretório informado                  *
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
* -- EXEC USP_ListandoArquivo 'C:\TEMP\PastaComZip\'                        *
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
    
    DECLARE @Query VARCHAR(8000) = 'dir/ -C /4 /N "' + @Ds_Diretorio + '"'

    DECLARE @Retorno TABLE (
        Linha INT IDENTITY(1, 1),
        Resultado VARCHAR(MAX)
    )

    DECLARE @Tabela_Final TABLE (
        Linha INT IDENTITY(1, 1),
        Dt_Criacao DATETIME,
        Fl_Tipo BIT,
        Qt_Tamanho INT,
        Ds_Arquivo VARCHAR(255)
    )

-- ===========================================
--            Retorno do CMD
-- ===========================================

    INSERT INTO @Retorno
    EXEC master.dbo.xp_cmdshell 
        @command_string = @Query


    INSERT INTO @Tabela_Final(Dt_Criacao, Fl_Tipo, Qt_Tamanho, Ds_Arquivo)
    SELECT 
        CONVERT(DATETIME, LEFT(Resultado, 17), 103) AS Dt_Criacao,
        0 AS Fl_Tipo, 
        0 AS Qt_Tamanho,
        SUBSTRING(Resultado, 37, LEN(Resultado)) AS Ds_Arquivo
    FROM 
        @Retorno
    WHERE 
        Resultado IS NOT NULL
        AND Linha >= 6
        AND Linha < (SELECT MAX(Linha) FROM @Retorno) - 2
        AND Resultado LIKE '%<DIR>%'
        AND SUBSTRING(Resultado, 37, LEN(Resultado)) NOT IN ('.', '..')
    ORDER BY
        Ds_Arquivo
        

    INSERT INTO @Tabela_Final(Dt_Criacao, Fl_Tipo, Qt_Tamanho, Ds_Arquivo)
    SELECT 
        CONVERT(DATETIME, LEFT(Resultado, 17), 103) AS Dt_Criacao,
        1 AS Fl_Tipo, 
        LTRIM(SUBSTRING(LTRIM(Resultado), 18, 19)) AS Qt_Tamanho,
        SUBSTRING(Resultado, CHARINDEX(LTRIM(SUBSTRING(LTRIM(Resultado), 18, 19)), Resultado, 18) + LEN(LTRIM(SUBSTRING(LTRIM(Resultado), 18, 19))) + 1, LEN(Resultado)) AS Ds_Arquivo
    FROM 
        @Retorno
    WHERE 
        Resultado IS NOT NULL
        AND Linha >= 6
        AND Linha < (SELECT MAX(Linha) FROM @Retorno) - 2
        AND Resultado NOT LIKE '%<DIR>%'
    ORDER BY
        Ds_Arquivo

-- ===========================================
--          Exibindo resultado final
-- ===========================================
        
    SELECT Dt_Criacao, Fl_Tipo, Qt_Tamanho, Ds_Arquivo FROM @Tabela_Final


END
GO