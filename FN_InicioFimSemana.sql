CREATE FUNCTION Fn_InicioFimSemana (@Mes varchar(2), @Ano varchar(4))
RETURNS @Retorno TABLE (Semana INT, InicioSemana Date, FinalSemana Date )
AS

BEGIN

/****************************************************************************
* Function......: [Fn_InicioFimSemana]             Data: 2017-12-01         *
* Criado por....: RSouza                                                    *
* Objetivo......: Pegar data de inicio e de fim de uma semana do mês        *
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
* -- SELECT * FROM DBO.FN_InicioFimSemana(6,2017)                           *
****************************************************************************/

-- ====================================
-- Declarando variaveis
-- ====================================
Declare @MesAno varchar(7), @Dia1 DATE, @Id INT = 1;
Declare @InicioSemana date, @FinalSemana date;

set @MesAno = @Mes + '/' + @Ano;  --< mês/ano, sem espaços
set @Dia1= Convert(date, '1/' + @MesAno, 103);
--set DateFirst 7;

set @InicioSemana= DateAdd(day, 1 - DatePart(weekday, @Dia1), @Dia1);
set @FinalSemana= DateAdd(day, +6, @InicioSemana);

while Month(@InicioSemana) = Month(@Dia1) or Month(@FinalSemana) =
Month(@Dia1) 
  begin
    INSERT INTO @Retorno(Semana, InicioSemana, FinalSemana)
    SELECT @Id, @InicioSemana, @FinalSemana;
    set @InicioSemana= DateAdd(day, +7, @InicioSemana);
    set @FinalSemana= DateAdd(day, +6, @InicioSemana);
    set @Id = @Id+1;
  END;

RETURN

END