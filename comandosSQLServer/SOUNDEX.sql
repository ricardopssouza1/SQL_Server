
-- ================================================
--  Esta função do SQL Server possibilita fazer uma 
-- busca em determinado campo retornando valores 
-- similares, por exemplo:
--  Se procuro por “Alessandro” ele retorna mais 
-- nomes similares como Alexandre, Alessandra, 
-- Alexsandro, Alexsandra, Alexnaldo ou se procuro 
-- por “Daniela” ele retorna Daniel, Daniella, 
-- Danyella, Danielle, Danilo, claro que só retornará
-- se os mesmos estiverem cadastrados na tabela.
-- A função é SOUNDEX, um exemplo de uso é mostrado abaixo:
-- ==============================================

SELECT nome FROM clientes WHERE SOUNDEX(nome) = SOUNDEX(‘Alessandro’)