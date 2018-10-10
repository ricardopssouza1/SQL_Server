
-- ===============================
-- SEPARANDO NOME 
-- =============================

DECLARE @t TABLE(NomeCompleto VARCHAR(50));
INSERT INTO @t (NomeCompleto)
VALUES('joão de oliveira da silva')
     ,('Augusto Melo')
     ,('João')
     ,('Marcelo Gonçalves Araújo')

SELECT NomeCompleto, 
       LEFT(NomeCompleto, Inicio) AS Nome,
       CASE
           WHEN Inicio = Fim
           THEN ''
           ELSE SUBSTRING(NomeCompleto, Inicio+1, Fim-Inicio-1)
       END AS NomeMeio,
       CASE
           WHEN Fim = 0
           THEN ''
           ELSE RIGHT(NomeCompleto, LEN(NomeCompleto) - Fim)
       END AS SobreNome
FROM
(
    SELECT NomeCompleto, 
           CHARINDEX(' ', NomeCompleto) AS Inicio,
           CASE
               WHEN CHARINDEX(' ', NomeCompleto) = 0
               THEN 0
               ELSE LEN(NomeCompleto)-CHARINDEX(' ', REVERSE(NomeCompleto))+1
           END AS Fim
    FROM @t
) AS Nomes;

-- ===============================
-- SEPARANDO NOME USANDO CTE
-- ===============================

DECLARE @t TABLE(NomeCompleto VARCHAR(50));
INSERT INTO @t (NomeCompleto)
VALUES('joão de oliveira da silva')
     ,('Augusto Melo')
     ,('João')
     ,('Marcelo Gonçalves Araújo')

WITH Nomes(NomeCompleto, 
           Inicio, 
           Fim)
     AS (SELECT NomeCompleto, 
                CHARINDEX(' ', NomeCompleto),
                CASE
                    WHEN CHARINDEX(' ', NomeCompleto) = 0
                    THEN 0
                    ELSE LEN(NomeCompleto)-CHARINDEX(' ', REVERSE(NomeCompleto))+1
                END
         FROM @t)

     SELECT NomeCompleto, 
            LEFT(NomeCompleto, Inicio) AS Nome,
            CASE
                WHEN Inicio = Fim
                THEN ''
                ELSE SUBSTRING(NomeCompleto, Inicio+1, Fim-Inicio-1)
            END AS NomeMeio,
            CASE
                WHEN Fim = 0
                THEN ''
                ELSE RIGHT(NomeCompleto, LEN(NomeCompleto) - Fim)
            END AS SobreNome
     FROM Nomes;