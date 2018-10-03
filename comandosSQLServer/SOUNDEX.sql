
-- ================================================
--  Esta fun��o do SQL Server possibilita fazer uma 
-- busca em determinado campo retornando valores 
-- similares, por exemplo:
--  Se procuro por �Alessandro� ele retorna mais 
-- nomes similares como Alexandre, Alessandra, 
-- Alexsandro, Alexsandra, Alexnaldo ou se procuro 
-- por �Daniela� ele retorna Daniel, Daniella, 
-- Danyella, Danielle, Danilo, claro que s� retornar�
-- se os mesmos estiverem cadastrados na tabela.
-- A fun��o � SOUNDEX, um exemplo de uso � mostrado abaixo:
-- ==============================================

SELECT nome FROM clientes WHERE SOUNDEX(nome) = SOUNDEX(�Alessandro�)