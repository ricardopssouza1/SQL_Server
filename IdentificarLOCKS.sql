-- ======================================================= 
--       Buscando nome do campo em todas as tabelas 
-- ======================================================= 

select spid
     , blocked
     , hostname=left(hostname,20)
     , program_name=left(program_name,20)
     , WaitTime_Seg = convert(int,(waittime/1000))  
     , open_tran
     , status
     , (SELECT text FROM sys.dm_exec_sql_text(sql_handle)) as ScriptEmExecucao
   From master.dbo.sysprocesses 
where blocked > 0
order by spid