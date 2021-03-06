CREATE FUNCTION [dbo].[Fn_NumeroMonetarioPorExtenso]
(
@valor DECIMAL(18,2)
)
RETURNS VARCHAR(8000)
AS
BEGIN

/*********************************************************************
* Function......: [Fn_NumeroMonetarioPorExtenso]   Data: 2016-10-25  *
* Criado por....: Ricardo Souza                                      *
* Objetivo......: Retorna numero por extenso                         *
*--------------------------------------------------------------------*
* Tabelas envolvidas:           |Select |Insert |Update |Delete |    *
* -                             |  [ ]  |  [ ]  |  [ ]  |  [ ]  |    *
*                                                                    *
* Chamada por:                                                       *
*------------------------------------------------------------------- *
* Historico de Modificações:                                         *
*  Data      Autor           OS      Descricao                       *
*                                                                    *
* Forma de uso                                                       *
* -- SELECT DBO.Fn_NumeroMonetarioPorExtenso(2017.52)                *
**********************************************************************/  

DECLARE @valorCentavos	TINYINT	--Valor dos Centavos
DECLARE @valorInt	BIGINT	--Remove os centavos
DECLARE @valorStr	VARCHAR(20)	--Valor como string
DECLARE @pedacoStr1	VARCHAR(20)	--Pedaco da str
DECLARE @pedacoStr2	VARCHAR(20)	--Pedaco da str
DECLARE @pedacoStr3	VARCHAR(20)	--Pedaco da str
DECLARE @pedacoInt1	INT	--Pedaco da INT
DECLARE @pedacoInt2	INT	--Pedaco da INT
DECLARE @pedacoInt3	INT	--Pedaco da INT
DECLARE @menorN	INT
DECLARE @retorno VARCHAR(8000)

SET @retorno = ''
SET @valorInt = Convert(bigint, @valor)
SET @valorStr = Convert(VARCHAR(20), @valorInt)
SET @valorCentavos = Convert(int, (@valor - convert(bigint, @valor)) * 100)


--Retorna Zero
IF (@valor = 0)
BEGIN
SET @retorno = 'Zero Reaiz'
RETURN @retorno
END

DECLARE @numeros TABLE (descricao varchar(50), menor int, maior int)
DECLARE @milhar TABLE (descricaoUm varchar(50), descricaoPl Varchar(50), menor int, maior int)

INSERT INTO @numeros VALUES('Um', 1, 1)
INSERT INTO @numeros VALUES('Dois', 2, 2)
INSERT INTO @numeros VALUES('Três', 3, 3)
INSERT INTO @numeros VALUES('Quatro', 4, 4)
INSERT INTO @numeros VALUES('Cinco', 5, 5)
INSERT INTO @numeros VALUES('Seis', 6, 6)
INSERT INTO @numeros VALUES('Sete', 7, 7)
INSERT INTO @numeros VALUES('Oito', 8, 8)
INSERT INTO @numeros VALUES('Nove', 9, 9)
INSERT INTO @numeros VALUES('Dez', 10, 10)
INSERT INTO @numeros VALUES('Onze', 11, 11)
INSERT INTO @numeros VALUES('Doze', 12, 12)
INSERT INTO @numeros VALUES('Treze', 13, 13)
INSERT INTO @numeros VALUES('Catorze', 14, 14)
INSERT INTO @numeros VALUES('Quinze', 15, 15)
INSERT INTO @numeros VALUES('Dezesseis', 16, 16)
INSERT INTO @numeros VALUES('Dezessete', 17, 17)
INSERT INTO @numeros VALUES('Dezoito', 18, 18)
INSERT INTO @numeros VALUES('Dezenove', 19, 19)
INSERT INTO @numeros VALUES('Vinte', 20, 20)
INSERT INTO @numeros VALUES('Vinte e', 21, 29)
INSERT INTO @numeros VALUES('Trinta', 30, 30)
INSERT INTO @numeros VALUES('Trinta e', 31, 39)
INSERT INTO @numeros VALUES('Quarenta', 40, 40)
INSERT INTO @numeros VALUES('Quarenta e', 41, 49)
INSERT INTO @numeros VALUES('Cinquenta', 50, 50)
INSERT INTO @numeros VALUES('Cinquenta e', 51, 59)
INSERT INTO @numeros VALUES('Sessenta', 60, 60)
INSERT INTO @numeros VALUES('Sessenta e', 61, 69)
INSERT INTO @numeros VALUES('Setenta', 70, 70)
INSERT INTO @numeros VALUES('Setenta e', 71, 79)
INSERT INTO @numeros VALUES('Oitenta', 80, 80)
INSERT INTO @numeros VALUES('Oitenta e', 81, 89)
INSERT INTO @numeros VALUES('Noventa', 90, 90)
INSERT INTO @numeros VALUES('Noventa e', 91, 99)
INSERT INTO @numeros VALUES('Cem', 100, 100)
INSERT INTO @numeros VALUES('Cento e', 101, 199)
INSERT INTO @numeros VALUES('Duzentos', 200, 200)
INSERT INTO @numeros VALUES('Duzentos e', 201, 299)
INSERT INTO @numeros VALUES('Trezentos', 300, 300)
INSERT INTO @numeros VALUES('Trezentos e', 301, 399)
INSERT INTO @numeros VALUES('Quatrocentos', 400, 400)
INSERT INTO @numeros VALUES('Quatrocentos e', 401, 499)
INSERT INTO @numeros VALUES('Quinhentos', 500, 500)
INSERT INTO @numeros VALUES('Quinhentos e', 501, 599)
INSERT INTO @numeros VALUES('Seiscentos', 600, 600)
INSERT INTO @numeros VALUES('Seiscentos e', 601, 699)
INSERT INTO @numeros VALUES('Setecentos', 700, 700)
INSERT INTO @numeros VALUES('Setecentos e', 701, 799)
INSERT INTO @numeros VALUES('Oitocentos', 800, 800)
INSERT INTO @numeros VALUES('Oitocentos e', 801, 899)
INSERT INTO @numeros VALUES('Novecentos', 900, 900)
INSERT INTO @numeros VALUES('Novecentos e', 901, 999)

INSERT INTO @milhar VALUES('Mil', 'Mil', 4, 6)
INSERT INTO @milhar VALUES('Milhão', 'Milhões', 7, 9)
INSERT INTO @milhar VALUES('Bilhão', 'Bilhões', 10, 12)
INSERT INTO @milhar VALUES('Trilhão', 'Trilhões', 13, 15)
INSERT INTO @milhar VALUES('Quadrilhão', 'Quadrilhões', 16, 18)

--Busca o número de casas (sempre em 3)
SELECT TOP 1 @menorN = menor - 1 FROM @milhar WHERE menor > len(@valorStr)

--Adiciona casas a esquerda (tratando sempre de 3 em 3 casas)
SET @valorStr = replicate('0', @menorN - len(@valorStr)) + @valorStr

--Varre Convertendo os valores para valores por extenso
WHILE (len(@valorStr) > 0)
BEGIN
--Busca os 3 primeiros carac.
SET @pedacoStr1 = left(@valorStr, 3)
SET @pedacoStr2 = right(@pedacoStr1, 2)
SET @pedacoStr3 = right(@pedacoStr2, 1)
SET @pedacoInt1 = Convert(int, @pedacoStr1)
SET @pedacoInt2 = Convert(int, @pedacoStr2)
SET @pedacoInt3 = Convert(int, @pedacoStr3)

--Busca a centena
SELECT 
@retorno = @retorno + descricao + ' ' 
FROM 
@numeros 
WHERE 
((len(@pedacoInt1) = 3) AND @pedacoStr1 BETWEEN menor AND maior) 
OR ((@pedacoInt2 <> 0 AND len(@pedacoInt2) = 2) AND @pedacoInt2 BETWEEN menor AND maior)
OR ((@pedacoInt3 <> 0 AND(@pedacoInt2 < 10 OR @pedacoInt2 > 20)) AND @pedacoInt3 BETWEEN menor AND maior) --Remove de 11 a 19
ORDER BY 
maior DESC

--Define o milhar (se foi escrito algum valor para ele)
IF (@pedacoInt1 > 0)
SELECT @retorno = @retorno + CASE WHEN @pedacoInt1 > 1 THEN descricaoPL ELSE descricaoUm END + ' ' FROM @milhar WHERE (len(@valorStr) BETWEEN menor and maior)

--Remove os pedaços efetuados
SET @valorStr = right(@valorStr, len(@valorStr) - 3)

IF (convert(int, left(@valorStr, 3)) > 0)
SET @retorno = @retorno + 'e '
ELSE
IF (convert(int, @valorStr) = 0 AND len(@valorStr) = 6) /*Somente coloca na dezena*/
SET @retorno = @retorno + 'de '	
END

--Somente coloca se tiver algum valor.
IF (len(@retorno) > 0)
SET @retorno = @retorno + CASE WHEN @valorInt > 1 THEN 'Reais ' ELSE 'Real ' END


--Busca os centavos
SET @valorStr = Convert(varchar(2), @valorCentavos)

--Adiciona casas a esquerda
SET @valorStr = replicate('0', 2 - len(@valorStr)) + @valorStr

--Define os centavos
--Busca os 2 caracteres
SET @pedacoStr1 = @valorStr
SET @pedacoStr2 = right(@valorStr, 1)
SET @pedacoInt1 = Convert(int, @pedacoStr1)
SET @pedacoInt2 = Convert(int, @pedacoStr2)

--Define a descrição (Não coloca se não tiver reais)
IF (@pedacoInt1 > 0 AND (len(@retorno) > 0))
SET @retorno = @retorno + 'e '

--Busca a centena
SELECT 
@retorno = @retorno + descricao + ' ' 
FROM 
@numeros 
WHERE 
((@pedacoInt1 <> 0 AND len(@pedacoInt1) = 2) AND @pedacoInt1 BETWEEN menor AND maior)
OR ((@pedacoInt2 <> 0 AND (@pedacoInt1 < 10 OR @pedacoInt1 > 20)) AND @pedacoInt2 BETWEEN menor AND maior)
ORDER BY 
maior DESC

--Define a descrição
IF (@pedacoInt1 > 0)
SELECT @retorno = @retorno + 'Centavo' + CASE WHEN @pedacoInt1 > 1 THEN 's' ELSE '' END


RETURN @retorno
END