CREATE PROCEDURE USP_GeraSenhaAleatoria

/****************************************************************************************
* Procedure.....: [USP_GeraSenhaAleatoria]                            Data: 2017-08-17  *
* Criado por....: RSouza                                                                *
* Objetivo......: Gerar senhas aleatórias                                               *
*---------------------------------------------------------------------------------------*
* Tabelas envolvidas:                                |Select |Insert |Update |Delete |  *
* -                                                  |  [ ]  |  [ ]  |  [ ]  |  [ ]  |  *
*                                                                                       * 
*---------------------------------------------------------------------------------------* 
* Historico de Modificações:                                                            * 
*  Data      Autor           OS      Descricao                                          * 
*                                                                                       * 
* Outros Exemplos                                                                       *
*																						*
* -- todos os valores entre o código ASCII 48 - 122 excluindo os padrões				*
* declare @len=8																		*
* 																						*
* -- todas as letras minúsculas excluindo o e l											*
* declare @len=10, @min=97, @range=25, @exclude='ol'									*
* 																						*
* --todas as letras maiúsculas, excluindo O												*
* declare @len=12, @min=65, @range=25, @exclude='O'										*
* 																						*
* -- todos os números entre 0 e 9														*
* declare @len=14, @min=48, @range=9, @exclude=''										*
*																						*
*****************************************************************************************/ 
    @output varchar(50) output
AS
    declare @char char
	      , @len int = 8
          , @min tinyint = 48
          , @range tinyint = 74
          , @exclude varchar(50) = '0:;<=>?@O[]`^\/'
        set @output = ''
 
    while @len > 0 begin
       select @char = char(round(rand() * @range + @min, 0))
       if charindex(@char, @exclude) = 0 begin
           set @output += @char
           set @len = @len - 1
       end
    end
;
go




