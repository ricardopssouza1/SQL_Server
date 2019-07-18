CREATE PROCEDURE [dbo].[SPpesquisaObjetos]     
@nm_pesquisado VARCHAR(255)    
    
AS    

/* REMOVE POSSIVEIS ESPAÇOS EM BRANCO */
SET @nm_pesquisado = LTRIM(RTRIM(@nm_pesquisado))
    
/* 'TABELAS' */
SELECT name AS NM_TABELA
  FROM sysobjects 
 WHERE type = 'U' 
   AND name LIKE '%' + @nm_pesquisado + '%' 
 ORDER BY name    
    
/* 'NOME PROCEDURES' */
SELECT name AS NM_PROCEDURE 
  FROM sysobjects 
 WHERE type = 'P' 
   AND name LIKE '%' + @nm_pesquisado + '%' 
 ORDER BY name    

/* 'NOME DE FUNCTIONS' */
SELECT name AS NM_FUNCTION 
  FROM sysobjects 
 WHERE type = 'FN' 
   AND name LIKE '%' + @nm_pesquisado + '%' 
 ORDER BY name
  
/* 'NOME DE VIEWS */
SELECT name AS NM_VIEWS 
  FROM sysobjects 
 WHERE type = 'V' 
   AND name LIKE '%' + @nm_pesquisado + '%' 
 ORDER BY name    

/* 'TRIGGERS' */
SELECT name AS NM_TRIGGER 
  FROM sysobjects 
 WHERE type = 'TR' 
   AND name LIKE '%' + @nm_pesquisado + '%' 
 ORDER BY name   
  
/* 'CONTEUDO DE VIEWS'  */
SELECT DISTINCT 
       o.name as CONTEUDO_VIEWS    
  FROM sysobjects o     
  JOIN syscomments c on (c.ID = o.ID)    
 WHERE o.type = 'V' 
   AND c.text LIKE '%' + @nm_pesquisado + '%'     
 ORDER BY o.name    
    
/* 'CONTEUDO PROCEDURES'  */  
SELECT DISTINCT 
       o.name as CONTEUDO_PROCEDURES     
  FROM sysobjects o     
  JOIN syscomments c on (c.ID = o.ID)
 WHERE o.type = 'P' 
   AND c.text LIKE '%' + @nm_pesquisado + '%'     
 ORDER BY o.name    
    
/* 'CONTEUDO FUNCTIONS'  */
SELECT DISTINCT 
       o.name as CONTEUDO_FUNCTIONS     
  FROM sysobjects o     
  JOIN syscomments c on (c.ID = o.ID)    
 WHERE o.type = 'FN' 
   AND c.text LIKE '%' + @nm_pesquisado + '%'     
 ORDER BY o.name    
    
/* 'COLUNAS DAS TABELAS '  */
SELECT 
	   t.name AS TABELA
	 , c.name AS COLUNA
  FROM sys.sysobjects AS t (NOLOCK) 
  JOIN sys.all_columns AS c (NOLOCK) ON t.ID = c.object_id 
                                    AND t.XTYPE = 'U' 
 WHERE C.NAME LIKE '%' + @nm_pesquisado + '%' 
 ORDER BY T.name ASC

/* NOME DAS JOBS */
SELECT name as JOB 
  FROM msdb..sysjobs 
 WHERE name like '%' + @nm_pesquisado + '%' 