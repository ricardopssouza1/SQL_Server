/********************************************************************************  
*                                                                               *
* Criado por....: Dirceu Rezende                                                *  
* Objetivo......: Recuperar código de um objeto criptografado (WITH ENCRYPTION) *  
* Origem........: https://www.dirceuresende.com/                                *
*                                                                               *
*********************************************************************************/ 

SET NOCOUNT ON

-- Aqui você tem que alterar para o objeto que você quer descriptografar
DECLARE
    @ObjectOwnerOrSchema NVARCHAR(128) = 'dbo', 
    @ObjectName NVARCHAR(128) = 'stpTeste_Decrypt'


DECLARE 
    @i INT,
    @ObjectDataLength INT,
    @ContentOfEncryptedObject NVARCHAR(MAX),
    @ContentOfDecryptedObject NVARCHAR(MAX),
    @ContentOfFakeObject NVARCHAR(MAX),
    @ContentOfFakeEncryptedObject NVARCHAR(MAX),
    @ObjectType NVARCHAR(128),
    @ObjectID INT
 

SET @ObjectID = OBJECT_ID('[' + @ObjectOwnerOrSchema + '].[' + @ObjectName + ']')
 
IF @ObjectID IS NULL
BEGIN
    RAISERROR('The object name or schema provided does not exist in the database', 16, 1)
    RETURN
END
 

IF NOT EXISTS(SELECT TOP 1 * FROM sys.syscomments WHERE id = @ObjectID AND encrypted = 1)
BEGIN
    RAISERROR('The object provided exists however it is not encrypted. Aborting.', 16, 1)
    RETURN
END
 

IF OBJECT_ID('[' + @ObjectOwnerOrSchema + '].[' + @ObjectName + ']', 'PROCEDURE') IS NOT NULL
    SET @ObjectType = 'PROCEDURE'
ELSE
    IF OBJECT_ID('[' + @ObjectOwnerOrSchema + '].[' + @ObjectName + ']', 'TRIGGER') IS NOT NULL
        SET @ObjectType = 'TRIGGER'
    ELSE
        IF OBJECT_ID('[' + @ObjectOwnerOrSchema + '].[' + @ObjectName + ']', 'VIEW') IS NOT NULL
            SET @ObjectType = 'VIEW'
        ELSE
            SET @ObjectType = 'FUNCTION'
 

SELECT TOP 1 @ContentOfEncryptedObject = imageval
FROM sys.sysobjvalues
WHERE [objid] = OBJECT_ID('[' + @ObjectOwnerOrSchema + '].[' + @ObjectName + ']')
AND valclass = 1 and subobjid = 1
 
SET @ObjectDataLength = DATALENGTH(@ContentOfEncryptedObject)/2
SET @ContentOfFakeObject = N'ALTER ' + @ObjectType + N' [' + @ObjectOwnerOrSchema + N'].[' + @ObjectName + N'] WITH ENCRYPTION AS'
 
WHILE DATALENGTH(@ContentOfFakeObject)/2 < @ObjectDataLength
BEGIN
    IF DATALENGTH(@ContentOfFakeObject)/2 + 4000 < @ObjectDataLength
        SET @ContentOfFakeObject = @ContentOfFakeObject + REPLICATE(N'-', 4000)
    ELSE
        SET @ContentOfFakeObject = @ContentOfFakeObject + REPLICATE(N'-', @ObjectDataLength - (DATALENGTH(@ContentOfFakeObject)/2))
END
 

SET XACT_ABORT OFF
BEGIN TRAN
 
EXEC(@ContentOfFakeObject)
 
IF @@ERROR <> 0
    ROLLBACK TRAN
 
SELECT TOP 1 @ContentOfFakeEncryptedObject = imageval
FROM sys.sysobjvalues
WHERE [objid] = OBJECT_ID('[' + @ObjectOwnerOrSchema + '].[' + @ObjectName + ']')
AND valclass = 1 and subobjid = 1
 
IF @@TRANCOUNT > 0
    ROLLBACK TRAN
 
SET @ContentOfFakeObject = N'CREATE ' + @ObjectType + N' [' + @ObjectOwnerOrSchema + N'].[' + @ObjectName + N'] WITH ENCRYPTION AS'
 
WHILE DATALENGTH(@ContentOfFakeObject)/2 < @ObjectDataLength
BEGIN
    IF DATALENGTH(@ContentOfFakeObject)/2 + 4000 < @ObjectDataLength
        SET @ContentOfFakeObject = @ContentOfFakeObject + REPLICATE(N'-', 4000)
    ELSE
        SET @ContentOfFakeObject = @ContentOfFakeObject + REPLICATE(N'-', @ObjectDataLength - (DATALENGTH(@ContentOfFakeObject)/2))
END
 
SET @i = 1
SET @ContentOfDecryptedObject = N''
 
WHILE DATALENGTH(@ContentOfDecryptedObject)/2 < @ObjectDataLength
BEGIN
    IF DATALENGTH(@ContentOfDecryptedObject)/2 + 4000 < @ObjectDataLength
        SET @ContentOfDecryptedObject = @ContentOfDecryptedObject + REPLICATE(N'A', 4000)
    ELSE
        SET @ContentOfDecryptedObject = @ContentOfDecryptedObject + REPLICATE(N'A', @ObjectDataLength - (DATALENGTH(@ContentOfDecryptedObject)/2))
END
 
WHILE (@i <= @ObjectDataLength)
BEGIN
    SET @ContentOfDecryptedObject = STUFF(@ContentOfDecryptedObject, @i, 1,
        NCHAR(
            UNICODE(SUBSTRING(@ContentOfEncryptedObject, @i, 1)) ^
            (
                UNICODE(SUBSTRING(@ContentOfFakeObject, @i, 1)) ^
                UNICODE(SUBSTRING(@ContentOfFakeEncryptedObject, @i, 1))
            )))
 
    SET @i = @i + 1

END
 
SET @i = 0
 
WHILE DATALENGTH(@ContentOfDecryptedObject)/2 > (@i + 1)*2000
BEGIN
    PRINT(SUBSTRING(@ContentOfDecryptedObject, 1 + 2000*@i, 2000*(@i + 1)))
    SET @i = @i + 1
END
 
PRINT(SUBSTRING(@ContentOfDecryptedObject, 1 + 2000*@i, 2000*(@i + 1)))