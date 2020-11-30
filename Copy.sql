
-- Copy a table, but not its structure (primary key, index, ...)
SELECT * INTO NewCopyTableName FROM TableName;


/*************** OR **************/
--1 COPY TABLE STRUCTURE : 
-- Database -> Task -> Generate Scripts...
-- OR Script Table as -> CREATE To -> New Query Editor Window
CREATE TABLE NewCopyTableName ( ...) ;
--2 - 
INSERT INTO NewCopyTableName 
SELECT * FROM TableName;

/** INSERT INTO NewCopyTableName (col1, col2, Col3)
SELECT column1, column2, column3 FROM TableName; **/

/*************** OR **************/
CREATE TABLE `table2` LIKE `table1`;
INSERT INTO `table2` SELECT * FROM `table1`;


/************* /!\ Temporary table isn't copy **********/
-- la table temporaire n'existe que dans la session ou la procédure qui lui est associé
-- n'est pas utilisable dans une vue
SELECT *
INTO #Name_of_tempory_table
FROM TableName
WHERE ...;
