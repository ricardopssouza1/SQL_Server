-- ==================================
-- Invertendo colunas em linhas
-- ==================================

DECLARE @CONTAS TABLE (
    [BANCO] VARCHAR(100), 
    [TIPO] VARCHAR(100),
    [2010] NUMERIC(15,2), 
    [2011] NUMERIC(15,2) )
 
INSERT INTO @CONTAS VALUES
('Banco Alvorada S/A', 'Investimentos', 9613906084.01, 174343.35),
('Banco Alvorada S/A', 'Despesas', 8102644.84, 7935411.15),
('Banco Arbi S/A', 'Investimentos', 8202652.29, 8407843.72),
('Banco Arbi S/A', 'Despesas', 114215.13, 81746.25)

-- ==================================
-- Exibindo o resultado normal
-- ==================================

SELECT * FROM @CONTAS

-- ==================================
-- Invertendo coluna em linha
-- ==================================
 
SELECT [BANCO], [ANO], [TIPO], [VALOR]
FROM @CONTAS C
UNPIVOT ( [VALOR] FOR [ANO] IN (  
          [2010], 
          [2011]  )
        ) AS U
ORDER BY [BANCO], [ANO], [TIPO]