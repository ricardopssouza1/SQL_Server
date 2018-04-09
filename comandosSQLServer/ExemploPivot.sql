-- ** invertendo linhas e colunas
DECLARE @registros as table (
    idRegistro int,
    Campo varchar(100),
    Valor varchar(100)
)

INSERT INTO @registros VALUES (1, 'Banco', 'BANCO ALVORADA');
INSERT INTO @registros VALUES (1, 'Email', 'notenho@outlook.com');
INSERT INTO @registros VALUES (1, 'campoX', 'valorX');
INSERT INTO @registros VALUES (2, 'Banco', 'BANCO CETELEN');
INSERT INTO @registros VALUES (2, 'tel', '1188889999');
INSERT INTO @registros VALUES (2, 'campoY', 'valorY');

-- ==================================
-- Exibindo o resultado normal
-- ==================================

SELECT * FROM @registros

-- ==================================
-- Invertendo linha em coluna
-- ==================================

SELECT * 
FROM @registros
PIVOT (
    MAX(Valor)
    FOR Campo IN
    ([Banco], [Email], [tel], [campoX], [campoY])
) AS pvt
ORDER BY idRegistro