/********** Suprimer toutes les lignes d'une table ***********/
DELETE FROM table_1;
-- ou 
TRUNCATE TABLE table_1; --qui ré-initialise l’auto-incrémente

/********** Suprimer des lignes Specific ***********/
DELETE FROM table_1
WHERE champ1 = "Spécific value";


/********* Suppresion de doublon dans une table *****/

DELETE FROM table_1
WHERE ID NOT IN (
			SELECT  min(ID)
			FROM  table_1
			GROUP BY champ_doublone);


/********* Deleting Referential Integrity Violations **************/
/********* Supprime toutes les lignes qui ne correspondent pas aux lignes retournées entre parentheses **************/
-- NOT IN <=> NOT EXISTS

DELETE FROM table_2
WHERE champ1 NOT IN (SELECT champ1 FROM table_1);
 -- ou
DELETE FROM table_2
WHERE NOT EXISTS (SELECT * FROM table_1 WHERE table_2.champ1 = table_1.champ1);


/********* Supresion par raport à la postion d'un curseur **********/
DELETE FROM table_1
WHERE CURRENT OF cursor_name;


/********* Supresion d'element d'une partition ***********/
-- supresion des partitions 2, 4, 6, 7, 8 et 9
TRUNCATE TABLE PartitionTable1   
WITH (PARTITIONS (2, 4, 6 TO 9));


/********* Supresion d'une table temporaire ***********/
/********* SQL SERVER ***********/
--create a temporary table
CREATE TABLE dbo.#Continent (
	id int IDENTITY(1,1),
	Continent varchar(50)
);
INSERT INTO dbo.#Continent (Continent) VALUES ('Africa');
SELECT * FROM  dbo.#Continent;
--delete temporary table
DROP TABLE IF EXISTS dbo.#Continent;
/********* MySQL ***********/
--create a temporary table
CREATE TEMPORARY TABLE Continent (
	id int PRIMARY KEY,
	Continent varchar(50)
);
INSERT INTO Continent (Continent) VALUES ('Africa');
SELECT * FROM  Continent;
--delete temporary table
DROP TEMPORARY TABLE IF EXISTS Continent;


/********************************************************/
/****************** Check drop table ********************/
/********************************************************/
/****/!\ Ordre de supression (referential integrity) ****/
-- methode 1 with OBJECT_ID function
USE [MyDataBase];Go
IF OBJECT_ID('dbo.MyTable', 'u') IS NOT NULL
DROP TABLE MyTable;

-- methode 2 by query sys.objects
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'MyTable' and type = 'u')
	DROP TABLE MyTable;

IF EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'dbo' AND name LIKE 'MyTable')
	DROP TABLE [dbo].[MyTable];

-- methode 3 check to see if table exists in INFORMATION_SCHEMA.TABLES - ignore DROP TABLE if it does not
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MyTable0' AND TABLE_SCHEMA = 'dbo')
	DROP TABLE [dbo].[MyTable0];

-- SQL SERVER 2016 and up
DROP TABLE IF EXISTS [dbo].[MyTable1];
