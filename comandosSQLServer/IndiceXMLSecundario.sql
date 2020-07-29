CREATE TABLE MinhaTabela (Col1 INT PRIMARY KEY, XmlCol XML)
GO
-- Criando indice primario.
CREATE PRIMARY XML INDEX PIdx_MinhaTabela_XmlCol 
ON T(XmlCol)
GO
-- Criando indices secundarios (PATH, VALUE, PROPERTY).
CREATE XML INDEX PIdx_MinhaTabela_XmlCol_PATH ON MinhaTabela(XmlCol)
USING XML INDEX PIdx_MinhaTabela_XmlCol
FOR PATH
GO
CREATE XML INDEX PIdx_MinhaTabela_XmlCol_VALUE ON T(XmlCol)
USING XML INDEX PIdx_MinhaTabela_XmlCol
FOR VALUE
GO

/* Um índice XML pode ser criado em uma coluna XML e a tabela deve ter um índice cluster. O índice XML pode ser primário ou secundário */