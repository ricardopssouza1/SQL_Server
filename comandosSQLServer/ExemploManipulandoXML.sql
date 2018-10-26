-- ====================================
-- Manipulando dados XML
-- fonte: http://www.macoratti.net/07/11/sql_xml1.htm
-- ====================================

DECLARE @TB_XML AS TABLE (codigo INT ,dados XML)

-- ====================================
-- Inserindo um XML
-- ====================================

INSERT INTO @TB_XML
(codigo,dados)
VALUES
(100,
'<?xml version="1.0"?>
	<aluno cod="100">
	<nome>Jose Carlos Macoratti</nome>              
		<historico>
			<materia nome="Portugues" nota="10"/>
			<materia nome="Matemtaica" nota="8"/>
			<materia nome="Fisica" nota="6"/>
			<materia nome="Ingles" nota="9"/>
		</historico>
</aluno>')

-- ====================================
-- exibindo conteudo do XML
-- ====================================

SELECT codigo,dados FROM @TB_XML

-- ==========================================
-- inserindo dados no nó/elemento "historico"
-- ==========================================

UPDATE @TB_XML
SET dados.modify('insert <materia nome="Quimica" nota="7" />into (/aluno/historico)[1]')
WHERE codigo = 100

-- ====================================
-- exibindo conteudo do XML
-- ====================================

SELECT codigo,dados FROM @TB_XML

-- ====================================
-- inserindo dados no nó/elemento "historico"
-- na posição 2
-- ====================================

UPDATE @TB_XML
SET dados.modify('insert <materia nome="Biologia" nota="8" /> before (/aluno/historico/materia)[2]')
WHERE codigo = 100

-- ====================================
-- exibindo conteudo do XML
-- ====================================

SELECT codigo,dados FROM @TB_XML

-- ==========================================
-- alterando/update na nota da ultima posição
-- ==========================================

UPDATE @TB_XML
SET dados.modify('replace value of (/aluno/historico/materia/@nota)[last()]with "5"')
WHERE codigo = 100

-- ====================================
-- exibindo conteudo do XML
-- ====================================

SELECT codigo,dados FROM @TB_XML

-- ==========================================
-- deleta todas as matérias com o texto "ica"
-- Exemplo: Quimica, Fisica e Matematica
-- ==========================================

UPDATE @TB_XML
SET dados.modify('delete /aluno/historico/materia/@nome[contains(.,"ica")]')

-- ====================================
-- exibindo conteudo do XML
-- ====================================

SELECT codigo,dados FROM @TB_XML

-- ====================================
-- deleta todo o XML
-- ====================================

UPDATE @TB_XML
SET dados.modify('delete /aluno')
WHERE codigo = 100


-- ====================================
-- exibindo conteudo do XML
-- ====================================

SELECT codigo,dados FROM @TB_XML

/*

query() - Efetua consultas em estruturas XML que retornam XML;
value() - Efetua consultas em estruturas XML que retornam tipos SQL ;
exist() - Efetua consultas para determinar a existência de um valor dentro de uma estrutura XML;
nodes() - Utiliza para segmentar uma estrutura XML em vários registros;

*/