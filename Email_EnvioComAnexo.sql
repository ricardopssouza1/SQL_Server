
-- ==================================================== *
/*-- /* Habilitando o xp_cmdshell */                    *
* --                                                    *
* -- exec sp_configure 'show advanced options', 1       *
* -- go                                                 *
* -- reconfigure                                        *
* -- go                                                 *
* -- EXEC sp_configure 'xp_cmdshell', 1                 *
* -- go                                                 *
* -- reconfigure                                        *
* -- go                                                 *
-- ==================================================== */


-- =======================================================
--               Declarando as variaveis
-- =======================================================
        Declare @assunto varchar(max)
        Declare @corpoEmail    varchar(max)
        Declare @destinatarios       varchar(max)
        Declare @anexo varchar(max)
        Declare @Caminho varchar (200) 
        Declare @destinatarioti varchar(5000)
        Declare @cmd varchar (1000)
        Declare @nomeArquivo varchar(1000)

-- =======================================================
--  Carregando o nome do arquivo que será enviado em anexo 
-- e o caminho para envio no email
-- Obs: Estou usando *.zip, mas pode usar txt, csv etc
-- =======================================================

           Set @Caminho = 'C:\TEMP\PastaComZip\'
		    If object_id('tempdb..#tmp') is not null DROP TABLE #tmp 
        Create table #tmp (out varchar (1000))
        Select @cmd = 'dir ' + @caminho + '*.zip /b'
        Insert into #tmp (out)
          Exec xp_cmdshell @cmd
        Select top 1 @nomeArquivo = out from #tmp where out is not NULL
-- =======================================================
--  Concatenando email de todos os profissionais que 
-- receberam o email
-- Obs: Essa parte não é obrigatória, podendo ser 
-- substituida diretamente pelos emails fixos
-- =======================================================
           Set @destinatarioti = ''  
        Select @destinatarioti = @destinatarioti+[a].[column]+'; '  
          From (Select distinct convert(varchar(100),CampoEmail)as[column]  
                  From TB_EmailDosProfissionaisResponsaveis ) as a  
           Set @destinatarioti = left(@destinatarioti,len(@destinatarioti)-1)

-- =======================================================
-- Enviando Email com anexo
-- Obs: Assunto, Corpo email e destinatários também podem
-- ser fixos
-- =======================================================
           Set @destinatarios = @destinatarioti
           Set @assunto = 'Arquivo do dia ' + convert(varchar(30),getdate(),103) 
           Set @corpoEmail = 'Segue em anexo o arquivo gerado .' + char(13) +char(10) + 'Duvidas entrar em contato com o TI.'
           Set @anexo = @caminho + @nomeArquivo

          EXEC msdb.dbo.sp_send_dbmail @recipients  = @destinatarios -- e-mails destinatario
                                     , @subject     = @assunto -- assunto
                                     , @body        = @corpoEmail  -- corpo email
                                     , @body_format = 'HTML'
                                     , @profile_name = 'ProfileName' 
                                     , @file_attachments = @anexo

