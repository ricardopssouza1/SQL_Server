# Comandos básicos em vários SGBDs 

**SELECT TOP**
- SQL Server - SELECT TOP 10 * FROM TABELA
- MySQL      - SELECT * FROM TABELA LIMIT 10;
- Oracle     - SELECT * FROM TABELA WHERE ROWNUM < 10;
- PostgreSQL - SELECT * FROM TABELA LIMIT 10;
- Firebird   - SELECT FIRST 10 * FROM TABELA;

**Data Atual**
- SQL Server - SELECT GETDATE() AS DATA_ATUAL
- MySQL      - SELECT CURDATE();
- Oracle     - SELECT SYSDATE FROM DUAL;
- PostgreSQL - SELECT CURRENT_DATE;

**Formatar Data**
- SQL Server - SELECT CONVERT(VARCHAR(8),GETDATE(),103)
- MySQL      - SELECT date_format(curdate(),'%d/%m/%Y');
- Oracle     - SELECT to_char(sysdate,'dd/mm/yyyy') from dual;
- PostgreSQL - SELECT to_char(current_date,'dd/mm/yyyy');

**Soma Datas**
- SQL Server - SELECT DATEADD(DAY,3,GETDATE())
- MySQL      - SELECT DATE_ADD(CURDATE(),interval 3 day);
- Oracle     - SELECT sysdate + interval '3' FROM DUAL;
- PostgreSQL - SELECT current_date + interval '3 days';

**Diferença entre Datas**
- SQL Server - SELECT DATEDIFF(DAY,'2020-01-01',getdate())
- MySQL      - SELECT datediff(curdate(),'2020-01-01');
- Oracle     - SELECT sysdate - to_date ('2020-01-01','yyyy-mm-dd') from dual;
- PostgreSQL - SELECT curr_date - to_date('2020-01-01','yyyy-mm-dd');

**Parte da Data**
- SQL Server - SELECT DATEPART(MONTH,GETDATE())
- MySQL      - SELECT extract(month from curdate());
- Oracle     - SELECT extract(month FROM sysdate) FROM dual;
- PostgreSQL - SELECT date_part('month',current_date);

**Zeros a esquerda**
- SQL Server - SELECT RIGHT(REPLICATE('0',14) + '123',14)
- MySQL      - SELECT LPAD(123,14,'0')
- Oracle     - SELECT LPAD(123,14,0) FROM dual; 
- PostgreSQL - SELECT RIGHT(repeat('0',14) || '123', 14)

**Parte do texto**
- SQL Server - SELECT SUBSTRING('Substring',1,3)
- MySQL      - SELECT SUBSTRING('Substring', 1, 3) OU SELECT SUBSTRING('Substring' FROM 3)
- Oracle     - SELECT SUBSTR( 'Substring', 1, 3 ) FROM dual;
- PostgreSQL - SELECT SUBSTRING ('Substring', 1, 3);

**Tamanho da String**
- SQL Server - SELECT LEN('abc')
- MySQL      - SELECT LENGTH('abc')
- Oracle     - SELECT LENGTH('abc') from dual;
- PostgreSQL - SELECT char_length('abc');
