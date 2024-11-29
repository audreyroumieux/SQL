/*** Create a temporry table ***/
-- (n’existent que dans la session dans laquelle elles ont été créées et n’existent que pour le reste de la session)
 
SELECT column_1, column_2, column_3,...  
INTO #name_of_temp_table
FROM table_name
WHERE condition
 
CREATE TABLE #name_of_temp_table (
	column_1 datatype,
	column_2 datatype,
        .
        .
	column_n datatype
)
 
INSERT INTO #name_of_temp_table (column_1, column_2, column_3,...) 
SELECT column_1, column_2, column_3,...
FROM table_name
WHERE condition
 
DROP TABLE #name_of_temp_table;
 
-- Create a global temportay table
 
SELECT column_1, column_2, column_3,... 
INTO ##name_of_global_temp_table
FROM table_name
WHERE condition
 
 
/***************************** Oracle ***************************************/
CREATE GLOBAL TEMPORARY TABLE temp_table
(column1 datatype [ constraint ],
column2 datatype [ constraint ],
...)
ON COMMIT DELETE ROWS; --OR ON COMMIT PRESERVE ROWS;
INSERT INTO temp_table VALUES (val1.1, val1.2, ...);
 
/***************************** SNOWFLAKE ***************************************/
create TEMPORARY table name_of_temp_table (col1 type1, col2 type2, ... coln typen,);
--OR
 
CREATE TEMPORARY TABLE name_of_temp_table AS SELECT id, str FROM origninal_table_name;
 
----------------------- VS existent jusqu’à ce qu’elles soient explicitement détruites
create TRANSIENT table name_of_transitoire_table (col1 type1, col2 type2, ... coln typen,);
 
 
 
/********** /!\ C'est différent des requêtes imbriquées *********/
SELECT column_1
FROM (SELECT * 
		FROM table_name)
/**** ou utilisation du WITH ****/
WITH table_1 AS (
    SELECT  *
    FROM table_complexe
), table_2 AS (
	SELECT * FROM table_1
)
SELECT * FROM table_2
