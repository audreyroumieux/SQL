-- https://docs.microsoft.com/fr-fr/sql/t-sql/queries/select-for-clause-transact-sql?view=sql-server-ver15 

-- FOR XML / JSON : retourne le résultat d’une requête au format texte XML / JSON

SELECT LastName, FirstName  
FROM myTable
WHERE LastName LIKE 'G%'  
ORDER BY LastName, FirstName   
FOR XML AUTO, TYPE, XMLSCHEMA, ELEMENTS XSINIL;  


