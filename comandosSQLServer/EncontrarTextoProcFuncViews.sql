-- ===============================================
--  Encontrar texto dentro de Procedures,Functions
-- e Views
-- ===============================================

SELECT type_desc
     , obj.name AS SP_NAME
	 , sqlmod.definition AS SP_DEFINITION
  FROM sys.sql_modules AS sqlmod
 INNER JOIN sys.objects AS obj ON sqlmod.object_id = obj.object_id
 WHERE sqlmod.definition LIKE '%TextoPesquisado%'
 ORDER BY type_desc