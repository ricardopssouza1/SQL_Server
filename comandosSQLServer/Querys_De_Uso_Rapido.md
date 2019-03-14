# Querys de uso Rápido
 
**Desativando e Ativando Identity**
<p>SET IDENTITY_INSERT Tabela Off<br />
Go<br />
<br />
Scripts SQL<br />
Go<br />
<br />
SET IDENTITY_INSERT Tabela On<br />
</p>

**Obtendo o último Identity**
<p>
Select Ident_Current('Tabela')
<p/>

**Alterando o Identity**
<p>
DBCC CheckIdent('Tabela',Reseed,@Identity)
</p>

**Informando o Collate em uma cláusula Where**
<p>
Select campo<br />
From tabela<br />
Where campo collate Latin_General_CI_AS like ‘%á%’<br />
</p>

**Informando o Collate em uma coluna e na cláusula Where**
<p>
Select Campo collate Latin_General_CI_AS<br />
From tabela<br />
Where Campo collate Latin_General_CI_AS like ‘%á%’<br />
</p>

**Alterando o Collate de uma Coluna**
<p>
Alter Table Users<br />
Alter Column [Password] Varchar(12) Collate SQL_Latin1_General_CP1_CS_AS
</p>

**RowNumber**
<p>
select <br />
  row_number() over(order by name asc) as Linha,<br />
  name, recovery_model_desc<br />
from sys.databases <br />
where database_id < 5;<br />
</p>

**Retorna o último valor de identity no mesmo escopo**
<p>
select SCOPE_IDENTITY() AS scope_identity
</p>

**Retorna o último valor de identity inserido na tabela**
<p>
select @@IDENTITY AS identity
</p>


**Retorna o último valor de identity inserido na tabela**
<p>
SET LANGUAGE 'Brazilian'<br />
SELECT<br />
DATEPART(WEEKDAY,getdate()) as DIA_DATA,<br />
DATENAME(WEEKDAY,getdate()) as DIA_DESCRICAO<br />
SET LANGUAGE 'us_english'<br />
</p>


**Exemplos abaixo tirados do Blog do Dirceu**
<p>
www.dirceuresende.com/blog/o-que-mudou-no-sql-server-2012-em-relacao-ao-t-sql-na-visao-dos-desenvolvedores/
</p>

**FUNÇÃO LÓGICA IIF**
*(A PARTIR DO 2012)*
<p>
SELECT IIF(DATEPART(HOUR, GETDATE()) < 12, 'AM', 'PM') <br />
</p>

*(ATÉ O 2008)*
<p>
SELECT (CASE WHEN DATEPART(HOUR, GETDATE()) < 12 THEN 'AM' ELSE 'PM' END) <br />
</p>


**ALTERANDO FORMATAÇÃO DE DATA**
<p>
SET LANGUAGE 'Portuguese' <br />
SELECT DATENAME(MONTH, GETDATE()), DATENAME(WEEKDAY, GETDATE())	<br />
SET LANGUAGE 'Brazilian' <br />
SELECT DATENAME(MONTH, GETDATE()), DATENAME(WEEKDAY, GETDATE())	<br />
SET LANGUAGE 'English' <br />
SELECT DATENAME(MONTH, GETDATE()), DATENAME(WEEKDAY, GETDATE()) <br />
</p>


**TIPOS DE LINGUAGEM**
<p>
SELECT * FROM syslanguages<br />
</p>

**RETORNANDO ULTIMO DIA DO MES**
/* ATÉ O 2008 */
<p>
	DECLARE @DATA_ATUAL DATETIME <br />
	      , @ANO VARCHAR(10) <br /> 
		  , @MES VARCHAR(10) <br />
		  , @ULTIMODIA VARCHAR(10)<br />
	SET @DATA_ATUAL = GETDATE() <br />
	SET @ANO = LEFT(CONVERT(VARCHAR(20),@DATA_ATUAL,112),4)<br />
	SET @MES = SUBSTRING(CONVERT(VARCHAR(20),@DATA_ATUAL,112),5,2) <br />
	SELECT DAY(DATEADD(d, - 1, DATEADD(M, 1, CONVERT(DATETIME, @ANO + @MES + '01')))) AS ULTIMO_DIA_MES <br />
</p>
<p>
/* A PARTIR DO 2012 */
SELECT EOMONTH(@DATA_ATUAL) AS ULTIMO_DIA_MES <br />
</p>

**FUNÇÃO CHOOSE**
/*RECUPERAR UM VALOR BASEADO NA POSIÇÃO NUMÉRICA (ÍNDICE), A PARTIR DO 2012*/
<p>
SELECT CHOOSE(5, <br />
    'Janeiro', 	 <br />
    'Fevereiro', <br />
    'Março', 	 <br />
    'Abril', 	 <br />
    'Maio', 	 <br />
    'Junho', 	 <br />
    'Julho', 	 <br />
    'Agosto', 	 <br />
    'Setembro',  <br />
    'Novembro',  <br />
    'Dezembro'	 <br />
)                <br />

SELECT <br />
    CHOOSE(-1, <br />
        'Domingo',  <br />
        'Segunda-feira',   <br />
        'Terça-feira',	   <br />
        'Quarta-feira',	   <br />
        'Quinta-feira',	   <br />
        'Sexta-feira',	   <br />
        'Sábado'  <br />
    ) AS Nome_Dia_Semana1, <br />
    CHOOSE(4.9, <br />
        'Domingo',  <br />
        'Segunda-feira',   <br />
        'Terça-feira',	   <br />
        'Quarta-feira',	   <br />
        'Quinta-feira',	   <br />
        'Sexta-feira',	   <br />
        'Sábado'		   <br />
    ) AS Nome_Dia_Semana2  <br />
</p>

**Tratamento de erros e exceções com o THROW**
/*ATÉ O 2008*/
<p>
BEGIN TRY <br />
    SELECT 1/0  <br />
END TRY  <br />
BEGIN CATCH  <br />
    DECLARE <br />
        @MsgErro VARCHAR(MAX) = ERROR_MESSAGE(),  <br />
        @IntState INT = ERROR_STATE(), <br />
        @IntSeverity INT = ERROR_SEVERITY()  <br />
    RAISERROR(@MsgErro, @IntSeverity, @IntState) WITH NOWAIT <br />
 END CATCH
</p>
<p>
 
/*A PARTIR DO 2012*/
BEGIN TRY <br />
    SELECT 1/0 <br />
END TRY  <br />
BEGIN CATCH <br />
    THROW <br />
END CATCH  <br />
</p>

**Funções de conversão – PARSE, TRY_PARSE, TRY_CONVERT e TRY_CAST**
<p>
SELECT CAST('Sábado, 29 de dezembro de 2018' AS DATETIME) AS [Cast] /*Erro*/ <br />
GO <br />
SELECT CONVERT(DATETIME, 'Sábado, 29 de dezembro de 2018') AS [CONVERT] /*Erro*/ <br />
GO <br />
SELECT PARSE('Sábado, 29 de dezembro de 2018' AS DATETIME USING 'pt-BR') AS [PARSE] /*Sucesso (A PARTIR DO 2012)*/ <br />
</p>

/*Nesse exemplo, será gerada uma exceção durante a execução do código T-SQL*/
/*Msg 9819, Level 16, State 1, Line 1: Error converting string value 'Domingo, 29 de dezembro de 2018' into data type datetime using culture 'pt-BR'.*/

<p>
SELECT PARSE('Domingo, 29 de dezembro de 2018' AS DATETIME USING 'pt-BR') AS [PARSE] <br />
GO<br />
	
/*Aqui vai apenas retornar NULL*/<br />
SELECT TRY_PARSE('Domingo, 29 de dezembro de 2018' AS DATETIME USING 'pt-BR') AS [PARSE] <br />
GO<br />

/*Sucesso (2018-12-28 00:00:00.000)*/<br />
SELECT CAST('2018-12-28' AS DATETIME) <br />
GO<br />

/*Erro: The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.*/<br />
SELECT CAST('2018-12-99' AS DATETIME) <br />
GO<br />

/*NULL*/<br />
SELECT TRY_CAST('2018-12-99' AS DATETIME) /* (A PARTIR DO 2012) */<br />
GO<br />

/*Sucesso (2018-12-28 00:00:00.000)*/<br />
SELECT CONVERT(DATETIME, '2018-12-28')<br />
GO <br />

/*Erro: The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.*/<br />
SELECT CONVERT(DATETIME, '2018-12-99')<br />
GO <br />

/*NULL*/<br />
SELECT TRY_CONVERT(DATETIME, '2018-12-99') /* (A PARTIR DO 2012) */<br />
</p>

/*Funções de data – DATEFROMPARTS, DATETIME2FROMPARTS, DATETIMEFROMPARTS, DATETIMEOFFSETFROMPARTS, SMALLDATETIMEFROMPARTS e TIMEFROMPARTS*/<br />
<p>
IF (OBJECT_ID('tempdb..#Dados') IS NOT NULL) DROP TABLE #Dados <br />
CREATE TABLE #Dados ( <br />
    Ano INT,		  <br />
    Mes INT,		  <br />
    Dia INT,		  <br />
    Hora INT,		  <br />
    Minuto INT,		  <br />
    Segundo INT,	  <br />
    Millisegundo INT, <br />
    Offset_Hora INT,  <br />
    Offset_Minuto INT <br />
) <br />
INSERT INTO #Dados <br />
VALUES <br />
    (2018, 12, 19, 14, 39, 1, 123, 3, 30), <br />
    (1987, 5, 28, 21, 22, 59, 999, 3, 0), <br />
    (2018, 12, 31, 23, 59, 59, 999, 0, 0) <br />
 
/*Antes do SQL Server 2012: Utilizando CAST/CONVERT*/<br />
SELECT<br />
    CAST(CAST(Ano AS VARCHAR(4)) + '-' + CAST(Mes AS VARCHAR(2)) + '-' + CAST(Dia AS VARCHAR(2)) AS DATE) AS [CAST_DATE]<br />
FROM<br />
    #Dados<br />
    
/*A partir do SQL Server 2012: DATEFROMPARTS*/<br />
SELECT <br />
    DATEFROMPARTS (Ano, Mes, Dia) AS [DATEFROMPARTS] <br />
FROM<br />
    #Dados<br />
SELECT <br />
    DATEFROMPARTS (Ano, Mes, Dia) AS [DATEFROMPARTS],<br />
    DATETIME2FROMPARTS (Ano, Mes, Dia, Hora, Minuto, Segundo, Millisegundo, 7) AS [DATETIME2FROMPARTS],<br />
    DATETIMEFROMPARTS (Ano, Mes, Dia, Hora, Minuto, Segundo, Millisegundo) AS [DATETIMEFROMPARTS],<br />
    DATETIMEOFFSETFROMPARTS (Ano, Mes, Dia, Hora, Minuto, Segundo, Millisegundo, Offset_Hora, Offset_Minuto, 7) AS [DATETIMEOFFSETFROMPARTS],<br />
    SMALLDATETIMEFROMPARTS (Ano, Mes, Dia, Hora, Minuto) AS [SMALLDATETIMEFROMPARTS],<br />
    TIMEFROMPARTS (Hora, Minuto, Segundo, Millisegundo, 7) AS [TIMEFROMPARTS] <br />
FROM<br />
    #Dados<br />
</p>
SET LANGUAGE 'English' <br />
<p>
SELECT<br />
    FORMAT(GETDATE(), 'd'), /*Padrão de data abreviada.*/ <br />
    FORMAT(GETDATE(), 'D'), /*Padrão de data completa.*/ <br />
    FORMAT(GETDATE(), 'R'), /*Padrão RFC1123*/ <br />
    FORMAT(GETDATE(), 't'), /*Padrão de hora abreviada.*/ <br />
    FORMAT(GETDATE(), 'T')  /*Padrão de hora completa.*/ <br /> 
</p>    

SET LANGUAGE 'Brazilian'<br />
<p>
SELECT<br />
    FORMAT(GETDATE(), 'd'), /*Padrão de data abreviada.*/ <br />
    FORMAT(GETDATE(), 'D'), /*Padrão de data completa.*/ <br />
    FORMAT(GETDATE(), 'R'), /*Padrão RFC1123*/ <br />
    FORMAT(GETDATE(), 't'), /*Padrão de hora abreviada.*/ <br />
    FORMAT(GETDATE(), 'T')  /*Padrão de hora completa.*/ <br />
</p>
SELECT <br />
    /*Formato de data típico do Brasil*/ <br />
    FORMAT(GETDATE(), 'dd/MM/yyyy'), <br />
    /*Formato de data/hora típico dos EUA*/ <br />
    FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss.fff'), <br />
    /*Exibindo a data por extenso*/ <br />
    FORMAT(GETDATE(), 'dddd, dd \d\e MMMM \d\e yyyy'), <br />
    /*Exibindo a data por extenso (forçando o idioma pra PT-BR)*/ <br />
    FORMAT(GETDATE(), 'dddd, dd \d\e MMMM \d\e yyyy', 'pt-br'),	 <br />
    /*Exibindo a data/hora, mas zerando os minutos e segundos*/	<br />
    FORMAT(GETDATE(), 'dd/MM/yyyy HH:00:00', 'pt-br') <br />
</p>

**Função de tratamento de string – FORMAT**

SELECT<br />
    FORMAT(123456.99, 'C'), /*Formato de moeda padrão*/ <br />
    FORMAT(-123456.987654321, 'C4'), /*Formato de moeda com 4 casas decimais*/ <br />
    FORMAT(123456.987654321, 'C2', 'pt-br') /*Formato de moeda forçando a localidade pra Brasil e 2 casas decimais*/ <br />

SELECT<br />
    FORMAT(123456.99, 'D'), /*Formato de número inteiro com valores numeric (NULL)*/ <br /> 
    FORMAT(123456, 'D'), /*Formato de número inteiro*/ <br />
    FORMAT(-123456, 'D4'), /*Formato de número inteiro com valores negativos*/ <br />
    FORMAT(123456, 'D10', 'pt-br'), /*formato de número inteiro com tamanho fixo em 10 caracteres*/ <br />
    FORMAT(-123456, 'D10', 'pt-br') /*formato de número inteiro com tamanho fixo em 10 caracteres*/ <br />

SELECT<br />
    FORMAT(123456.99, 'E'), /*Formato de notação científica*/ <br />
    FORMAT(123456.99, 'E4') /*Formato de notação científica e 4 casas decimais de precisão*/ <br />
SELECT <br />
    FORMAT(1, 'P'), /*Formato de porcentagem*/ <br />
    FORMAT(1, 'P2'), /*Formato de porcentagem com 2 casas decimais*/ <br />
    FORMAT(0.91, 'P'), /*Formato de porcentagem*/ <br />
    FORMAT(0.005, 'P4') /*Formato de porcentagem com 4 casas decimais*/ <br />
SELECT <br />
    FORMAT(255, 'X'), /*Formato hexadecimal*/ <br />
    FORMAT(512, 'X8') /*Formato hexadecimal fixando o retorno em 8 caracteres*/
SELECT <br />
    /*Formato de moeda brasileira (manualmente)*/<br />
    FORMAT(123456789.9, 'R$ ###,###,###,###.00'),<br />
    /*Utilizando sessão (;) para formatar valores positivos e negativos*/<br />
    FORMAT(123456789.9, 'R$ ###,###,###,###.00;-R$ ###,###,###,###.00'), <br />    
    /*Utilizando sessão (;) para formatar valores positivos e negativos*/ <br />
    FORMAT(-123456789.9, 'R$ ###,###,###,###.00;-R$ ###,###,###,###.00'),<br /> 
    /*Utilizando sessão (;) para formatar valores positivos e negativos*/<br />
    FORMAT(-123456789.9, 'R$ ###,###,###,###.00;(R$ ###,###,###,###.00)'),<br />    
    /*Formatando porcentagem com 2 casas decimais*/<br />
    FORMAT(0.9975, '#.00%'), <br />
    /*Formatando porcentagem com 4 casas decimais*/<br />
    FORMAT(0.997521654, '#.0000%'),<br />
    /*Formatando porcentagem com 4 casas decimais*/<br />
    FORMAT(123456789.997521654, '#.0000%'),<br />    
    /*Formatando porcentagem com 2 casas decimais e utilizando sessão (;)*/ <br />
    FORMAT(0.123456789, '#.00%;-#.00%'), <br />
    /*Formatando porcentagem com 2 casas decimais e utilizando sessão (;)*/ <br />
    FORMAT(-0.123456789, '#.00%;-#.00%'), <br />
    /*Formatando porcentagem com 2 casas decimais e utilizando sessão (;)*/ <br />
    FORMAT(-0.123456789, '#.00%;(#.00%)')<br />

**Função de tratamento de string – CONCAT**
IF (OBJECT_ID('tempdb..#Dados') IS NOT NULL) DROP TABLE #Dados <br />
CREATE TABLE #Dados ( <br />
    Dt_Nascimento DATE, <br />
    Nome1 VARCHAR(50), <br />
    Nome2 VARCHAR(50), <br />
    Idade AS CONVERT(INT, (DATEDIFF(DAY, Dt_Nascimento, GETDATE()) / 365.25)) <br />
) <br />

INSERT INTO #Dados <br />
VALUES <br />
    ('1999-09-27', 'JOAO', 'BATISTA'), <br />
    ('1999-09-19', 'MARIA', 'NAZARE'), <br />
    ('1999-09-19', 'JOSE', NULL) <br />

/*Antes do SQL Server 2012: Utilizando CAST/CONVERT*/ <br />
SELECT <br />
    Nome1 + ' ' + Nome2 + ' | ' + CAST(Idade AS VARCHAR(3)) + ' | ' + CAST(Dt_Nascimento AS VARCHAR(40)) AS [Antes do SQL Server 2012] <br />
FROM <br />
    #Dados <br />

/*A partir do SQL Server 2012: Utilizando CONCAT*/ <br />
SELECT <br />
    CONCAT(Nome1, ' ', Nome2, ' | ', Idade, ' | ', Dt_Nascimento) AS [A partir do SQL Server 2012] <br />
FROM <br />
    #Dados <br />

**Funções analíticas – FIRST_VALUE e LAST_VALUE**
IF (OBJECT_ID('tempdb..#Dados') IS NOT NULL) DROP TABLE #Dados<br />
CREATE TABLE #Dados ( <br />
    Id INT IDENTITY(1,1), <br />
    Nome VARCHAR(50), <br />
    Idade INT<br />
) <br />
INSERT INTO #Dados <br />
VALUES<br />
    ('Dirceu Resende', 31),<br />
    ('Joãozinho das Naves', 33),<br />
    ('Rafael Sudré', 48),<br />
    ('Potássio', 27),<br />
    ('Rafaela', 25),<br />
    ('Jodinei', 39)<br />

**Antes do SQL Server 2012: MIN/MAX e Subquery**
SELECT<br />
    *,<br />
    (SELECT MIN(Idade) FROM #Dados) AS Menor_Idade,<br />
    (SELECT MAX(Idade) FROM #Dados) AS Maior_Idade,<br />
    (SELECT TOP(1) Nome FROM #Dados ORDER BY Idade) AS Nome_Menor_Idade,<br />
    (SELECT TOP(1) Nome FROM #Dados ORDER BY Idade DESC) AS Nome_Maior_Idade<br />
FROM<br />
    #Dados<br />
    
/*A partir do SQL Server 2012: FIRST_VALUE*/ <br />
SELECT <br />
    *, <br />
    FIRST_VALUE(Idade) OVER(ORDER BY Idade) AS Menor_Idade, <br />
    FIRST_VALUE(Idade) OVER(ORDER BY Idade DESC) AS Maior_Idade, <br />
    FIRST_VALUE(Nome) OVER(ORDER BY Idade) AS Nome_Menor_Idade, <br />
    FIRST_VALUE(Nome) OVER(ORDER BY Idade DESC) AS Nome_Maior_Idade <br />
FROM <br />
    #Dados <br />

SELECT <br />
    *, <br />
    FIRST_VALUE(Idade) OVER(ORDER BY Idade) AS Menor_Idade, <br />
    LAST_VALUE(Idade) OVER(ORDER BY Idade) AS Maior_Idade, <br />
    FIRST_VALUE(Nome) OVER(ORDER BY Idade) AS Nome_Menor_Idade, <br />
    LAST_VALUE(Nome) OVER(ORDER BY Idade) AS Nome_Maior_Idade <br />
FROM <br />
    #Dados <br />

SELECT <br /> 
    *, <br />
    FIRST_VALUE(Idade) OVER(ORDER BY Idade) AS Menor_Idade, <br />
    LAST_VALUE(Idade) OVER(ORDER BY Idade ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS Maior_Idade, <br />
    FIRST_VALUE(Nome) OVER(ORDER BY Idade) AS Nome_Menor_Idade, <br />
    LAST_VALUE(Nome) OVER(ORDER BY Idade ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS Nome_Maior_Idade <br />
FROM <br />
    #Dados <br />



**Remover Zeros Esquerda ou Direita**

/* remover zeros a esquerda */<br />

DECLARE @TEXTO AS VARCHAR(30) = '0H0000010008JQJP'<br />
SELECT SUBSTRING(@TEXTO,PATINDEX('%[A-Z,1-9]%',@TEXTO),LEN(@TEXTO))<br />

DECLARE @TEXTO AS VARCHAR(30) = '000000000008JQJP'<br />
SELECT SUBSTRING(@TEXTO,PATINDEX('%[A-Z,1-9]%',@TEXTO),LEN(@TEXTO))<br />


/* remover zeros a direita */<br />

DECLARE @TEXTO AS VARCHAR(30) = '8JQJP00000000000'<br />
SELECT REVERSE(SUBSTRING(REVERSE(@TEXTO),PATINDEX('%[a-z,1-9]%',REVERSE(@TEXTO)),LEN(@TEXTO)))<br />

DECLARE @TEXTO AS VARCHAR(30) = '8JQJP000000K0000'<br />
SELECT REVERSE(SUBSTRING(REVERSE(@TEXTO),PATINDEX('%[a-z,1-9]%',REVERSE(@TEXTO)),LEN(@TEXTO)))<br />



