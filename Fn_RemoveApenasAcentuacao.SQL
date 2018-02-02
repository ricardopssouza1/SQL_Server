CREATE FUNCTION [dbo].[Fn_RemoveApenasAcentuacao] (@Texto VARCHAR(4000))  
RETURNS VARCHAR(4000)  
AS  
/****************************************************************************
* Function......: [Fn_RemoveApenasAcentuacao]          Data: 2017-12-01     *
* Criado por....: RSouza                                                    *
* Objetivo......: Remover toda acentuação do texto informado                *
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
* -- SELECT DBO.Fn_RemoveApenasAcentuacao('áÓÚÀòùÂÔãõÒ')                    *
****************************************************************************/  

BEGIN  
  
Declare @NovoTexto As Varchar(Max)   
SET @NovoTexto = ''  
  
Declare @Count As Int   
SET @COUNT = 1  
  
Declare @Char as Char(1)  
  
While @Count <= LEN(@Texto)  
Begin  
      Set @Char = SUBSTRING (@Texto, @Count, 1)    
      Set @Char = Case ASCII(@Char)                    
                
                -- =====================
                -- Vogais
                -- =====================
                  When 193 Then 'A' --'Á'  
                  When 225 Then 'a' --'á'  
                  When 226 Then 'a' --'â'  
                  When 192 Then 'A' --'À'  
                  when 194 Then 'A' --'Â'  
                  When 224 Then 'a' --'à'  
                  When 195 Then 'A' --'Ã'  
                  When 227 Then 'a' --'ã'  

                  When 200 Then 'E' --'È'  
                  When 201 Then 'E' --'É'  
                  When 232 Then 'e' --'é'                  
                  When 233 Then 'e' --'é'  
                  When 234 Then 'e' --'e'  

                  When 204 Then 'I' --'Ì'  
                  When 205 Then 'I' --'Í'  
                  When 236 Then 'i' --'ì' 
                  When 237 Then 'i' --'í'  


                  When 210 Then 'O' --'Ò'
                  When 211 Then 'O' --'Ó'
                  When 212 Then 'O' --'Ô'  
                  When 243 Then 'o' --'ó'  
                  When 212 Then 'O' --'Ô'  
                  When 244 Then 'o' --'ô'  
                  When 242 Then 'o' --'ò' 
                  When 213 Then 'O' --'Õ'  
                  When 245 Then 'o' --'õ'  

                  When 249 Then 'u' --'ú'
                  When 250 Then 'u' --'ú'
                  When 252 Then 'u' --'ú'				  				    
                  When 220 Then 'U' --'ú'  
                  When 217 Then 'U' --'Ü'  
                  When 218 Then 'U' --'Ú'  

                -- =====================
                -- Consoantes
                -- =====================
                  When 199 Then 'C' --'Ç'  
                  When 231 Then 'c' --'ç'  
                  When 209 Then 'N' --'Ñ'  
                  When 241 Then 'n' --'ñ'  
                  When 221 Then 'Y' --'Ý'  
                  When 253 Then 'y' --'ý'  


             Else @Char   
             End  
   
 Set @NovoTexto = @NovoTexto + @Char  
 Set @Count = @COUNT + 1  
   
End  
  
  
RETURN @NovoTexto  
  
  
END 

