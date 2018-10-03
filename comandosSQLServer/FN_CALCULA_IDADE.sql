CREATE   FUNCTION [dbo].[FN_CALCULA_IDADE]   
--*******************************************************  
--* Modulo      : Relatórios Gerenciais Farmaseg  
--* Função   : CalcularIdade  
--* Função      : Calcula a idade na data atual  
--* Criação     : 12/05/2010  
--* Por         : Eliane Alvarenga  
--* Consultoria :   
--* Modificado  :   
--* Por         :   
--* Parametros  : @DataNascimento -> Data de nascimento  
--*      @DataParametro  -> Data no tempo em que se quer saber a idade  
--* Uso   : select dbo.CalcularIdade('1980-05-09',getdate()) AS IDADE  
--*******************************************************  
--select dbo.CalcularIdade('2008-09-09',getdate())  
--select dbo.CalcularIdade('2008-09-09','2010-06-02')  
  
--  
(  
    @DataNascimento DateTime,  
    @DataParametro DateTime  
)  
RETURNS int  
AS  
BEGIN  
    DECLARE @Result int;  
  
    SELECT @Result = datediff(yy, @DataNascimento, @DataParametro) -  
        (case WHEN (datepart(m, @DataNascimento) > datepart(m, @DataParametro)) OR  
            (datepart(m, @DataNascimento) = datepart(m, @DataParametro) AND  
                datepart(d, @DataNascimento) > datepart(d, @DataParametro))  
            THEN 1  
            ELSE 0  
        end)   
    RETURN @Result   
END  