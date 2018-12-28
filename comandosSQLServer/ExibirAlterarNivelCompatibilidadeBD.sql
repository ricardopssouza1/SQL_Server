
/* Exibir ou alterar o nível de compatibilidade de um banco de dados */

/*Exibindo*/
USE AdventureWorks2012;  
GO  
SELECT compatibility_level , name  
FROM sys.databases WHERE name = 'AdventureWorks2012';  
GO  

/*Alterando*/
ALTER DATABASE AdventureWorks2012  
SET COMPATIBILITY_LEVEL = 120;  
GO 