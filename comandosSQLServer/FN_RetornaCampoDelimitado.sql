
Create Function FN_RetornaCampoDelimitado(@texto as varchar(max), @delimitador as varchar(1), @exibirColuna as int )
returns varchar(max)
begin

/****************************************************************************  
* Function......: [FN_RetornaCampoDelimitado]              Data: 2018-04-19 *
* Criado por....: Ricardo Souza                                             *  
* Objetivo......: Retorna campo delimitado conforme o texto informado       *  
*---------------------------------------------------------------------------*  
* Tabelas envolvidas:           |Select |Insert |Update |Delete |           *  
* - NDA                         |  [ ]  |  [ ]  |  [ ]  |  [ ]  |           *  
*                                                                           *  
* Chamada por:                                                              *  
*---------------------------------------------------------------------------*  
* Historico de Modificações:                                                *  
*  Data      Autor           OS      Descricao                              *  
*                                                                           * 
* Forma de uso                                                              *
* -- SELECT DBO.FN_RetornaCampoDelimitado('abc;def;hij',';',2)              *
* -- resultado = 'def'                                                      *
*****************************************************************************/
 DECLARE @resultado AS VARCHAR(max)
 DECLARE @i AS INT
 
 SELECT @i = 1, @resultado = @texto
 
   while @i <> @exibirColuna
 begin
  select @resultado = substring(@resultado,charindex(@delimitador,@resultado)+1,len(@texto))  
  select @i = @i + 1
 end
 
 if charindex(@delimitador,@resultado)>1
  select @resultado = substring(@resultado,1,charindex(@delimitador,@resultado)-1)
 else
  select @resultado = substring(@resultado,1,len(@resultado))
 
 return @resultado

end