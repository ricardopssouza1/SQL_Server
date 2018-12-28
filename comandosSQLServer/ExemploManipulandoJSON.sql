-- ====================================
-- Manipulando dados JSON
-- ====================================

DECLARE @json VARCHAR(MAX)

-- ====================================
-- Inserindo um JSON
-- ====================================
--SET @json = '{ "Alunos" :  { "nome": "João", "notas": [ 8, 9, 7 ] },       
--							{ "nome": "Maria", "notas": [ 8, 10, 7 ] },       
--							{ "nome": "Pedro", "notas": [ 10, 10, 9 ] }    }'

SET @json = '{"info":{
						"type":1,
						"address":{"town" :"Bristol",
						           "county":"Avon",
								   "country":"England"} ,
						"tags":["Sport","Water polo"]
					},
			"type":"Basic"
			}'


SELECT 
JSON_VALUE(@json, '$.info.type')as [info_type],
JSON_VALUE(@json, '$.info.address.town')as [town],
JSON_VALUE(@json, '$.info.address.county')as [county],
JSON_VALUE(@json, '$.info.address.country')as [country],
-- para retornar o array, utilize JSONQUERY
JSON_VALUE(@json, '$.info.tags')as [tags],
-- retornando os dados do array
JSON_VALUE(@json, '$.info.tags[0]')as [tags1],
JSON_VALUE(@json, '$.info.tags[1]')as [tags2],
JSON_VALUE(@json, '$.info.tags[2]')as [tags3],
JSON_VALUE(@json, '$.type')as [type]

--SELECT 
--JSON_VALUE(@json, '$.Alunos.nome')as [nome] ,
--JSON_VALUE(@json, '$.Alunos.notas')as [nota]

-- ===============================
--  exemplo 2
-- ===============================

DECLARE @json VARCHAR(MAX) = N'[  
  {  
    "Order": {  
      "Number":"SO43659",  
      "Date":"2011-05-31T00:00:00"  
    },  
    "AccountNumber":"AW29825",  
    "Item": {  
      "Price":2024.9940,  
      "Quantity":1  
    }  
  },  
  {  
    "Order": {  
      "Number":"SO43661",  
      "Date":"2011-06-01T00:00:00"  
    },  
    "AccountNumber":"AW73565",  
    "Item": {  
      "Price":2024.9940,  
      "Quantity":3  
    }  
  }
]'  

SELECT *
FROM OPENJSON ( @json )  
WITH (   
              Number   varchar(200)   '$.Order.Number',  
              Date     datetime       '$.Order.Date',  
              Customer varchar(200)   '$.AccountNumber',  
              Quantity int            '$.Item.Quantity',  
              [Order]  nvarchar(MAX)  AS JSON  
 )

-- ===============================
--  exemplo 3
-- ===============================

DECLARE @json VARCHAR(MAX)
SET @json =  
N'[  
       { "id" : 2,"info": { "name": "John", "surname": "Smith" }, "age": 25 },  
       { "id" : 5,"info": { "name": "Jane", "surname": "Smith" }, "dob": "2005-11-04T12:00:00" }  
 ]'  

SELECT *  
FROM OPENJSON(@json)  
  WITH (id int 'strict $.id',  
        firstName nvarchar(50) '$.info.name', lastName nvarchar(50) '$.info.surname',  
        age int, dateOfBirth datetime2 '$.dob')  