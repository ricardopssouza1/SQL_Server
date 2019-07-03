/*
Fonte: https://www.dirceuresende.com/blog/como-criar-uma-tabela-com-os-feriados-nacionais-estaduais-e-moveis-no-sql-server/
*/

CREATE PROCEDURE dbo.stpGera_Feriados
AS BEGIN

    -------------------------------
    -- Cria a tabela se não existir
    -------------------------------

    IF (OBJECT_ID('dbo.Feriado') IS NULL)
    BEGIN
        
        -- DROP TABLE dbo.Feriado
        CREATE TABLE dbo.Feriado (
            Nr_Ano SMALLINT NOT NULL,
            Nr_Mes SMALLINT NOT NULL,
            Nr_Dia SMALLINT NOT NULL,
            Tp_Feriado CHAR(1) NULL,
            Ds_Feriado VARCHAR(100) NOT NULL,
            Sg_UF CHAR(2) NOT NULL
        )
        
        ALTER TABLE dbo.Feriado ADD CONSTRAINT [Pk_Feriado] PRIMARY KEY CLUSTERED  ([Nr_Ano], [Nr_Mes], [Nr_Dia], [Sg_UF]) WITH (FILLFACTOR=90, PAD_INDEX=ON) ON [PRIMARY]

    END

    -- Apaga os dados se já tiverem sido populados
    TRUNCATE TABLE dbo.Feriado

    -------------------------------
    -- Feriados nacionais
    -------------------------------

    INSERT INTO dbo.Feriado
    SELECT 0, 1, 1, 1, 'Confraternização Universal', ''
    UNION
    SELECT 0, 4, 21, 1, 'Tiradentes', ''
    UNION
    SELECT 0, 5, 1, 1, 'Dia do Trabalhador', ''
    UNION
    SELECT 0, 9, 7, 1, 'Independência', ''
    UNION
    SELECT 0, 10, 12, 1, 'Nossa Senhora Aparecida', ''
    UNION
    SELECT 0, 11, 2, 1, 'Finados', ''
    UNION
    SELECT 0, 11, 15, 1, 'Proclamação da República', ''
    UNION
    SELECT 0, 12, 25, 1, 'Natal', ''

    -------------------------------
    -- Feriados estaduais
    -------------------------------

    -- Acre
    INSERT INTO dbo.Feriado
    SELECT 0, 1, 23, 2, 'Dia do evangélico', 'AC'
    UNION
    SELECT 0, 3, 8, 2, 'Alusivo ao Dia Internacional da Mulher', 'AC'
    UNION
    SELECT 0, 6, 15, 2, 'Aniversário do estado', 'AC'
    UNION
    SELECT 0, 9, 5, 2, 'Dia da Amazônia', 'AC'
    UNION
    SELECT 0, 11, 17, 2, 'Assinatura do Tratado de Petrópolis', 'AC'

    -- Alagoas
    INSERT INTO dbo.Feriado
    SELECT 0, 6, 24, 2, 'São João', 'AL'
    UNION
    SELECT 0, 6, 29, 2, 'São Pedro', 'AL'
    UNION
    SELECT 0, 9, 16, 2, 'Emancipação política', 'AL'
    UNION
    SELECT 0, 11, 20, 2, 'Morte de Zumbi dos Palmares', 'AL'

    -- Amapá
    INSERT INTO dbo.Feriado
    SELECT 0, 3, 19, 2, 'Dia de São José, santo padroeiro do Estado do Amapá', 'AP'
    UNION
    SELECT 0, 9, 13, 2, 'Criação do Território Federal (Data Magna do estado)', 'AP'

    -- Amazonas
    INSERT INTO dbo.Feriado
    SELECT 0, 9, 5, 2, 'Elevação do Amazonas à categoria de província', 'AM'
    UNION
    SELECT 0, 11, 20, 2, 'Dia da Consciência Negra', 'AM'

    -- Bahia
    INSERT INTO dbo.Feriado
    SELECT 0, 7, 2, 2, 'Independência da Bahia (Data magna do estado)', 'BA'

    -- Ceará
    INSERT INTO dbo.Feriado
    SELECT 0, 3, 25, 2, 'Data magna do estado (data da abolição da escravidão no Ceará)', 'CE'

    -- Distrito Federal
    INSERT INTO dbo.Feriado
    SELECT 0, 4, 21, 2, 'Fundação de Brasília', 'DF'
    UNION
    SELECT 0, 11, 30, 2, 'Dia do evangélico', 'DF'

    -- Maranhão
    INSERT INTO dbo.Feriado
    SELECT 0, 7, 28, 2, 'Adesão do Maranhão à independência do Brasil', 'MA'

    -- Mato Grosso
    INSERT INTO dbo.Feriado
    SELECT 0, 11, 20, 2, 'Dia da Consciência Negra', 'MT'

    -- Mato Grosso do Sul
    INSERT INTO dbo.Feriado
    SELECT 0, 10, 11, 2, 'Criação do estado', 'MS'

    -- Minas Gerais
    INSERT INTO dbo.Feriado
    SELECT 0, 4, 21, 2, 'Data magna do estado', 'MG'

    -- Pará
    INSERT INTO dbo.Feriado
    SELECT 0, 8, 15, 2, 'Adesão do Grão-Pará à independência do Brasil (data magna)', 'PA'

    -- Paraíba
    INSERT INTO dbo.Feriado
    SELECT 0, 7, 26, 2, 'Homenagem à memória do ex-presidente João Pessoa', 'PB'
    UNION
    SELECT 0, 8, 5, 2, 'Fundação do Estado em 1585', 'PB'

    -- Paraná
    INSERT INTO dbo.Feriado
    SELECT 0, 12, 19, 2, 'Emancipação política (emancipação do Paraná)', 'PR'

    -- Piauí
    INSERT INTO dbo.Feriado
    SELECT 0, 10, 19, 2, 'Dia do Piauí', 'PI'

    -- Rio de Janeiro
    INSERT INTO dbo.Feriado
    SELECT 0, 4, 23, 2, 'Dia de São Jorge', 'RJ'
    UNION
    SELECT 0, 11, 20, 2, 'Dia da Consciência Negra', 'RJ'

    -- Rio Grande do Norte
    INSERT INTO dbo.Feriado
    SELECT 0, 10, 3, 2, 'Mártires de Cunhaú e Uruaçu', 'RN'

    -- Rio Grande do Sul
    INSERT INTO dbo.Feriado
    SELECT 0, 9, 20, 2, 'Proclamação da República Rio-Grandense', 'RS'

    -- Rondônia
    INSERT INTO dbo.Feriado
    SELECT 0, 1, 4, 2, 'Criação do estado (data magna)', 'RO'
    UNION
    SELECT 0, 6, 18, 2, 'Dia do evangélico', 'RO'

    -- Roraima
    INSERT INTO dbo.Feriado
    SELECT 0, 10, 5, 2, 'Criação do estado', 'RR'

    -- Santa Catarina
    INSERT INTO dbo.Feriado
    SELECT 0, 10, 5, 2, 'Dia de Santa Catarina', 'SC'

    -- São Paulo
    INSERT INTO dbo.Feriado
    SELECT 0, 7, 9, 2, 'Revolução Constitucionalista de 1932 (Data magna do estado)', 'SP'

    -- Sergipe
    INSERT INTO dbo.Feriado
    SELECT 0, 3, 17, 2, 'Aniversário de Aracaju', 'SE'
    UNION
    SELECT 0, 6, 24, 2, 'São João', 'SE'
    UNION
    SELECT 0, 7, 8, 2, 'Autonomia política de Sergipe', 'SE'
    UNION
    SELECT 0, 12, 8, 2, 'Nossa Senhora da Conceição', 'SE'

    -- Tocantins
    INSERT INTO dbo.Feriado
    SELECT 0, 10, 5, 2, 'Criação do estado', 'TO'
    UNION
    SELECT 0, 3, 18, 2, 'Autonomia do Estado (criação da Comarca do Norte)', 'TO'
    UNION
    SELECT 0, 9, 8, 2, 'Padroeira do Estado (Nossa Senhora da Natividade)', 'TO'
   
    -------------------------------
    -- Feriados móveis
    -------------------------------

    DECLARE
        @ano INT,
        @seculo INT,
        @G INT,
        @K INT,
        @I INT,
        @H INT,
        @J INT,
        @L INT,
        @MesDePascoa INT,
        @DiaDePascoa INT,
        @pascoa DATETIME 

    DECLARE 
        @Dt_Inicial datetime = '1990-01-01',
        @Dt_Final datetime = '2099-01-01'


    WHILE(@Dt_Inicial <= @Dt_Final)
    BEGIN
        
        SET @ANO = YEAR(@Dt_Inicial)

        SET @seculo = @ano / 100 
        SET @G = @ano % 19
        SET @K = ( @seculo - 17 ) / 25
        SET @I = ( @seculo - CAST(@seculo / 4 AS int) - CAST(( @seculo - @K ) / 3 AS int) + 19 * @G + 15 ) % 30
        SET @H = @I - CAST(@I / 28 AS int) * ( 1 * -CAST(@I / 28 AS int) * CAST(29 / ( @I + 1 ) AS int) ) * CAST(( ( 21 - @G ) / 11 ) AS int)
        SET @J = ( @ano + CAST(@ano / 4 AS int) + @H + 2 - @seculo + CAST(@seculo / 4 AS int) ) % 7
        SET @L = @H - @J
        SET @MesDePascoa = 3 + CAST(( @L + 40 ) / 44 AS int)
        SET @DiaDePascoa = @L + 28 - 31 * CAST(( @MesDePascoa / 4 ) AS int)
        SET @pascoa = CAST(@MesDePascoa AS varchar(2)) + '-' + CAST(@DiaDePascoa AS varchar(2)) + '-' + CAST(@ano AS varchar(4))

        
        INSERT INTO dbo.Feriado
        SELECT YEAR(DATEADD(DAY , -2, @pascoa)), MONTH(DATEADD(DAY , -2, @pascoa)), DAY(DATEADD(DAY , -2, @pascoa)), 1, 'Paixão de Cristo', ''
        
        INSERT INTO dbo.Feriado
        SELECT YEAR(DATEADD(DAY , -48, @pascoa)), MONTH(DATEADD(DAY , -48, @pascoa)), DAY(DATEADD(DAY , -48, @pascoa)), 1, 'Carnaval', ''
        
        INSERT INTO dbo.Feriado
        SELECT YEAR(DATEADD(DAY , -47, @pascoa)), MONTH(DATEADD(DAY , -47, @pascoa)), DAY(DATEADD(DAY , -47, @pascoa)), 1, 'Carnaval', ''
        
        INSERT INTO dbo.Feriado
        SELECT YEAR(DATEADD(DAY , 60, @pascoa)), MONTH(DATEADD(DAY , 60, @pascoa)), DAY(DATEADD(DAY , 60, @pascoa)), 1, 'Corpus Christi', ''
        

        SET @Dt_Inicial = DATEADD(YEAR, 1, @Dt_Inicial)      

    END

    
END