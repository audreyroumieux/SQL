
SELECT column_name 
FROM table_name 
WHERE isnull(column_name,'') <> '';

--Remove leading and trailing spaces from a string:
--SQL Server Or MySQL: TRIM(), RTRIM(), LTRIM()
SELECT * 
FROM tableName 
WHERE TRIM(colName) IS NULL;

--Oracle: RTRIM(), LTRIM()
SELECT * 
FROM tableName 
WHERE LTRIM(RTRIM(colName)) IS NULL;


-- Convert whitespace into a NULL value (T-SQL)
SELECT [column_name]
FROM [table_name]
WHERE NULLIF([column_name], '') IS NULL;


-- Find last name and first name in column_name (like "NOM COMPOSE Prenom")
SELECT RIGHT(column_name, FINDSTRING(REVERSE(column_name)," ",1)) AS prenom,
LEFT(column_name, LEN(column_name) - FINDSTRING(REVERSE(column_name) As nom
FROM [table_name];