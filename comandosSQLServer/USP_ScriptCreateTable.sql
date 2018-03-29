CREATE PROCEDURE USP_ScriptCreateTable(
    @Tabela Varchar(200)
)
AS

/****************************************************************************
* Procedure.....: [USP_ScriptCreateTable]          Data: 2017-05-11         * 
* Criado por....: Ricardo Souza                                             * 
* Objetivo......: Procedure para gerar script de criação de tabela          * 
*-------------------------------------------------------------------------- * 
* Tabelas envolvidas:           |Select |Insert |Update |Delete |           * 
* -                             |  [ ]  |  [ ]  |  [ ]  |  [ ]  |           * 
* Chamada por:                                                              * 
*         Processo de carga e importação                                    * 
*-------------------------------------------------------------------------- * 
* Historico de Modificações:                                                * 
*  Data      Autor           OS      Descricao                              *
*                                                                           *
* Forma de uso                                                              *
* -- Exec USP_ScriptCreateTable 'Clientes'                                  *
****************************************************************************/  

    --Desabilitando a saída "(x row(s) affected)"
    SET NOCOUNT ON
 
    --Criando a tabela que irá  contar as linhas do create table
    DECLARE @Create_Table TABLE(s VARCHAR(1000), id INT IDENTITY)
 
    --Criação Inicial
    INSERT INTO  @Create_Table(s) VALUES ('CREATE TABLE ' + @Tabela + ' (')
 
    --Colunas do Create
    INSERT INTO @Create_Table(s)
    SELECT
        '['+column_name+'] ' + 
        data_type + 
        CASE WHEN RTrim(data_type) = 'image' THEN ''
        ELSE coalesce('('+cast(character_maximum_length AS VARCHAR)+')','') END + 
        ' ' +
        CASE WHEN EXISTS ( 
            SELECT id FROM syscolumns
            WHERE object_name(id)=@Tabela
            AND name=column_name
            AND columnproperty(id,name,'IsIdentity') = 1 
        ) THEN
            'IDENTITY(' + 
            cast(ident_seed(@Tabela) AS VARCHAR) + ',' + 
            cast(ident_incr(@Tabela) AS VARCHAR) + ')'
        ELSE ''
        END + ' ' +
        ( CASE WHEN IS_NULLABLE = 'No' OR RTrim(column_name) = 'R_E_C_N_O_' THEN 'NOT ' ELSE '' END ) + 'NULL ' + 
        coalesce('DEFAULT '+COLUMN_DEFAULT,'') + ','
 
    FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @Tabela
    ORDER BY ordinal_position
 
    --Agora pega a primary key da tabela
    DECLARE @PKName varchar(100)
    SELECT @PKName = constraint_name FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE table_name = @Tabela AND constraint_type='PRIMARY KEY'
 
    --Se tiver indice
    IF ( @PKName is not null ) BEGIN
        INSERT INTO @Create_Table(s) values('  PRIMARY KEY (')
        INSERT INTO @Create_Table(s)
            SELECT '   ['+COLUMN_NAME+'],' FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
            WHERE constraint_name = @PKName
            ORDER BY ordinal_position
 
        --Remove a última vírgula
        UPDATE @Create_Table SET s=left(s,len(s)-1) WHERE id=@@identity
        INSERT INTO @Create_Table(s) VALUES (' )')
    END
    --Senão, remove a ultima vírgula
    ELSE BEGIN
        UPDATE @Create_Table set s=left(s,len(s)-1) WHERE id=@@identity
    END
 
    --Fechando o último parêntestes
    INSERT INTO @Create_Table(s) values( ')' )
 
    --Agora seleciona os dados
    SELECT * FROM @Create_Table