-- ======================================================= 
--       Buscando nome do campo em todas as tabelas 
-- ======================================================= 

Use DATABASE_XYZ

SELECT 
	T.name AS Tabela, 
	C.name AS Coluna
FROM 
	sys.sysobjects    AS T (NOLOCK) 
INNER JOIN sys.all_columns AS C (NOLOCK) ON T.id = C.object_id AND T.XTYPE = 'U' 
WHERE 
	C.NAME LIKE '%NomeDoCampo%'
ORDER BY 
	T.name ASC