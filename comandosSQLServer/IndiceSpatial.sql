CREATE TABLE MinhaTabelaEspacial(id int primary key, geometry_col geometry);
CREATE SPATIAL INDEX SIndx_MinhaTabelaEspacial_geometry_col1 
   ON MinhaTabelaEspacial(geometry_col)
   WITH ( BOUNDING_BOX = ( 0, 0, 500, 200 ) );
   
   
/* O SQL Server 2008 apresentou um novo tipo especial de coluna chamada coluna espacial, que é uma coluna de tabela que contém dados de um tipo de dados espaciais, como geometria ou geografia. */   