SELECT OBJECT_SCHEMA_NAME(BaseT.[object_id],DB_ID()) AS [Schema], 
 BaseT.[name] AS [table_name], I.[name] AS [index_name], AC.[name] AS [column_name], 
 I.[type_desc]
FROM sys.[tables] AS BaseT 
 INNER JOIN sys.[indexes] I ON BaseT.[object_id] = I.[object_id] 
 INNER JOIN sys.[index_columns] IC ON I.[object_id] = IC.[object_id] 
 INNER JOIN sys.[all_columns] AC ON BaseT.[object_id] = AC.[object_id] AND IC.[column_id] = AC.[column_id] 
WHERE BaseT.[is_ms_shipped] = 0 AND I.[type_desc] <> 'HEAP'
ORDER BY BaseT.[name], I.[index_id], IC.[key_ordinal]