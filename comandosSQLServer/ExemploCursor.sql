DECLARE @codcliente int
      , @primeironome VARCHAR(30)
      , @sobrenome VARCHAR(60)
      , @nomecompleto VARCHAR(90)
      
DECLARE @Clientes AS TABLE(CdCliente INT
                         , NmCliente VARCHAR(100)
                         , NmSobrenome VARCHAR(100)
                         , NmCompleto VARCHAR(255))


INSERT INTO @Clientes (CdCliente,NmCliente,NmSobrenome)
Values ('1' ,'Jon'   ,'Snow')
     , ('2' ,'Mary'  ,'Parker')
     , ('3' ,'Peter' ,'Quill')
     , ('4' ,'Gustav','Stone')
     , ('5' ,'Fred'  ,'Flintstone')
     , ('6' ,'Barney','Parker')
     , ('7' ,'Olivia','Newton')
     , ('8' ,'Jane'  ,'Foster')
     , ('9' ,'Gwen'  ,'Banner')
     , ('10','Stacy' ,'Santos')

-- ==========================
-- exbindo antes da alteração
-- ==========================

SELECT * FROM @Clientes

-- ==========================
-- Executando o Cursor
-- ==========================
 
-- Cursor para percorrer os registros
DECLARE cursor1 CURSOR FOR
SELECT CdCliente, NmCliente, NmSobrenome FROM @Clientes
 
--Abrindo Cursor para leitura
OPEN cursor1
 
-- Lendo a próxima linha
FETCH NEXT FROM cursor1 INTO @codcliente, @primeironome, @sobrenome
 
-- Percorrendo linhas do cursor (enquanto houverem)
WHILE @@FETCH_STATUS = 0
BEGIN
 
-- Executando a rotina e manipulando o registro
UPDATE @Clientes SET NmCompleto = @primeironome + ' ' + @sobrenome WHERE CdCliente = @codcliente
 
-- Lendo a próxima linha
FETCH NEXT FROM cursor1 INTO @codcliente, @primeironome, @sobrenome
END
 
-- Fechando Cursor para leitura
CLOSE cursor1
 
-- Desalocando o cursor
DEALLOCATE cursor1

-- ==========================
-- exbindo antes da alteração
-- ==========================

SELECT * FROM @Clientes
