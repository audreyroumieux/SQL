
SELECT column_name FROM table_name where isnull(column_name,'') <> '';


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