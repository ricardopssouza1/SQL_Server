-----------------------------------------------------------------
-- Exibe até o resultado ser menor que 50 na seqüência de Fibonacci
-----------------------------------------------------------------
Declare @Param int
    Set @Param = 50

;WITH SequenciaFibonacci (ProxNumero, NumeroFibonacci) AS
(
     SELECT 0, 1
     UNION ALL
     SELECT NumeroFibonacci, ProxNumero + NumeroFibonacci
     FROM SequenciaFibonacci
     WHERE NumeroFibonacci < @Param
)
SELECT ProxNumero as Fibonacci
     FROM SequenciaFibonacci
     OPTION (MAXRECURSION 0);