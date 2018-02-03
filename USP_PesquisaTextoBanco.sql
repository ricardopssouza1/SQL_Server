CREATE PROCEDURE dbo.USP_PesquisaTextoBanco (
    @TextoPesquisado VARCHAR(255)
)
AS 
/****************************************************************************
* Function......: [USP_PesquisaTextoBanco]             Data: 2017-12-01     *
* Criado por....: RSouza                                                    *
* Objetivo......: Pesquisa em todo banco, em todas as tabelas o texto       *
*                 informado                                                 *
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
* -- EXEC USP_PesquisaTextoBanco 'João'                                     *
* --                                                                        *
* --                                                                        *
****************************************************************************/

DECLARE @SQL VARCHAR(8000)
DECLARE @filtro VARCHAR(200)
DECLARE @filtro_www VARCHAR(200)
 

SET @SQL = ''
SET @filtro = '%'+@TextoPesquisado+'%'
 
SELECT
   tabelas.name   AS Tabela 
  ,colunas.name   AS Coluna
  ,tipos.name     AS Tipo
  ,colunas.length AS Tamanho
INTO
  #result
FROM 
  sysobjects tabelas
  INNER JOIN syscolumns colunas
  ON colunas.id = tabelas.id
  --
  INNER JOIN systypes tipos
  ON tipos.xtype = colunas.xtype
WHERE 
  tabelas.xtype = 'u'
    AND
  -- colocar aqui os tipos de coluna que serão buscados
  tipos.name IN('text', 'ntext', 'varchar', 'nvarchar')
 
 
-- cursor para varrer as tabelas
DECLARE cTabelas cursor LOCAL fast_forward FOR
SELECT DISTINCT Tabela FROM #result
 
DECLARE @nomeTabela VARCHAR(255)
 
OPEN cTabelas
 
fetch NEXT FROM cTabelas INTO @nomeTabela
 
while @@fetch_status = 0
BEGIN
 
  -- cursor para varrer as colunas da tabela corrente
  DECLARE cColunas cursor LOCAL fast_forward FOR
  SELECT Coluna, Tipo, Tamanho FROM #result WHERE Tabela = @nomeTabela
 
  DECLARE @nomeColuna VARCHAR(255)
  DECLARE @tipoColuna VARCHAR(255)
  DECLARE @tamanhoColuna VARCHAR(255)
 
  OPEN cColunas
 
  -- monta as colunas da cláusula select 
  fetch NEXT FROM cColunas INTO @nomeColuna, @tipoColuna, @tamanhoColuna
 
  while @@fetch_status = 0
  BEGIN
    -- cria a declaração da variável
    SET @SQL = 'declare @hasresults bit' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
    -- cria o select
    SET @SQL = @SQL + 'select' + CHAR(13) + CHAR(10)
    SET @SQL = @SQL + CHAR(9) + '''' + @nomeTabela + ''' AS NomeTabela'
    SET @SQL = @SQL + CHAR(9) + ',' + @nomeColuna + CHAR(13) + CHAR(10)
    -- adiciona uma coluna com o tipo e o tamanho do campo
    SET @SQL = @SQL  + CHAR(9) + ',' + '''' + @tipoColuna + ''' AS ''' + @nomeColuna + '_Tipo''' + CHAR(13) + CHAR(10)
    SET @SQL = @SQL  + CHAR(9) + ',' + 'DATALENGTH(' + @nomeColuna + ') AS ''' + @nomeColuna + '_Tamanho_Ocupado''' + CHAR(13) + CHAR(10)    
    SET @SQL = @SQL  + CHAR(9) + ',' + '''' + @tamanhoColuna + ''' AS ''' + @nomeColuna + '_Tamanho_Maximo''' + CHAR(13) + CHAR(10)
 
    -- define a tabela temporária (#result)
    SET @SQL = @SQL + 'into' + CHAR(13) + CHAR(10) + CHAR(9) + '#result_' + @nomeTabela + CHAR(13) + CHAR(10)
    -- adiciona a cláusula from
    SET @SQL = @SQL +  'from' + CHAR(13) + CHAR(10) + CHAR(9) + @nomeTabela + CHAR(13) + CHAR(10)
    -- inicia a montagem do where
    SET @SQL = @SQL + 'where' + CHAR(13) + CHAR(10)
    SET @SQL = @SQL + CHAR(9) + @nomeColuna + ' like ''' + @filtro + '''' + CHAR(13) + CHAR(10)
 
    SET @SQL = @SQL + CHAR(13) + CHAR(10) + 'select @hasresults = count(*) from #result_' + @nomeTabela + CHAR(13) + CHAR(10)
    SET @SQL = @SQL + CHAR(13) + CHAR(10) + 'if @hasresults > 0'
    SET @SQL = @SQL + CHAR(13) + CHAR(10) + 'begin'
    SET @SQL = @SQL + CHAR(13) + CHAR(10) + CHAR(9) + 'select * from #result_' + @nomeTabela
    SET @SQL = @SQL + CHAR(13) + CHAR(10) + 'end' + CHAR(13) + CHAR(10)
    SET @SQL = @SQL + CHAR(13) + CHAR(10) + 'drop table #result_' + @nomeTabela
    SET @SQL = @SQL + CHAR(13) + CHAR(10)
 
    fetch NEXT FROM cColunas INTO @nomeColuna, @tipoColuna, @tamanhoColuna
	-- descomente a linha abaixo para ver o SQL produzido no janela de Messages
    -- print @sql
    EXEC(@SQL)
    SET @SQL = ''
  END
 
  close cColunas
  deallocate cColunas
 
  fetch NEXT FROM cTabelas INTO @nomeTabela
END
 
close cTabelas
deallocate cTabelas
 
DROP TABLE #result