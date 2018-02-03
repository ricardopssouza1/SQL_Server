CREATE FUNCTION Fn_DiaDaSemanaPorExtenso (@DATA DATETIME) RETURNS VARCHAR (20)  AS
BEGIN
/****************************************************************************
* Function......: [Fn_DiaDaSemanaPorExtenso]              Data: 2017-12-01  *
* Criado por....: RSouza                                                    *
* Objetivo......: Exibe a descrição do dia da semana, conforme a data       *
*                 informada.                                           *
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
* -- SELECT DBO.Fn_DiaDaSemanaPorExtenso(getdate())                         *
****************************************************************************/

-- ====================================
-- Declarando variaveis
-- ====================================
  DECLARE 
   @DIA INT,
   @DIA_EXT VARCHAR(20)
  
  SELECT @DIA = (DATEPART(DW,@DATA ))

  IF @DIA=1 
    SET @DIA_EXT ='DOMINGO'
  IF @DIA=2  
     SET @DIA_EXT ='SEGUNDA-FEIRA'
  IF @DIA=3  
     SET @DIA_EXT ='TERÇA-FEIRA'
  IF @DIA=4  
     SET @DIA_EXT ='QUARTA-FEIRA'
  IF @DIA=5  
     SET @DIA_EXT ='QUINTA-FEIRA'
  IF @DIA=6  
     SET @DIA_EXT ='SEXTA-FEIRA'
  IF @DIA=7  
     SET @DIA_EXT ='SÁBADO'

  RETURN @DIA_EXT
END