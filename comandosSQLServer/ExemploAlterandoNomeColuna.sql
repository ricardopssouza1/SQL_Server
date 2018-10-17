-- =====================================
 -- Alterando nome da coluna ou da tabela
 -- =====================================

-- Passo 1 - Criando a tabela para teste

IF EXISTS(SELECT TOP 1 1 FROM SA.SYS.TABLES WHERE NAME = 'TEMPORARIA')
    BEGIN DROP TABLE TEMPORARIA END

IF EXISTS(SELECT TOP 1 1 FROM SA.SYS.TABLES WHERE NAME = 'TMP')
    BEGIN DROP TABLE TMP END

CREATE TABLE TMP(CAMPO1 VARCHAR(100),CAMPO2 VARCHAR(100), CAMPO3 INT)

INSERT TMP(CAMPO1,CAMPO2,CAMPO3)
VALUES('TESTE' ,'TESTE2','2')
     ,('TESTE3','TESTE4','3')
     ,('TESTE5','TESTE6','4')
go

SELECT *, 'tabela TMP' AS DS_TB FROM TMP

go

-- Passo 2 - Alterando o nome da coluna

 sp_rename 'TMP.CAMPO1', 'CAMPO4' , 'COLUMN'

SELECT *, 'tabela TMP' FROM TMP

go
-- Passo 3 - Alterando o nome da tabela

 sp_rename 'TMP','TEMPORARIA'

SELECT *, 'tabela TEMPORARIA' AS DS_TB FROM TEMPORARIA
 

-- Passo 4 - Consultando se realmente existe a tabela TMP

-- SELECT *, 'tabela TMP' FROM TMP
