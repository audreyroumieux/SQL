
/*** Le partitionnement n’est possible que dans certaines conditions :
- les données (une ou plusieurs colonnes) qui permettent de ranger les lignes d’un côté ou de l’autre des bornes (soit l’infopartition) n’est pas NULLable.
– le partitionnement doit concerner la table tout entière
– les valeurs des bornes doivent être connues
– l’infopartition doit être déterministe (les données ne doivent pas fluctuer en fonction de critères externe, ce qui revient à dire que les colonnes participant à l’infopartition ne doivent pas être calculées, notamment par des fonctions non déterministes

- Les données et les index des tables source et cible doivent se trouver dans la même base de données et les mêmes groupes de fichiers. 

Elle est bénifique si:
- la volumétrie des données est conséquente
- les partitions sont gérées par des « storages »
- certaines tables interrogées systématiquement de manière conjointe sont elles aussi partitionnés avec le même critère dans les mêmes storages
- toutes les requêtes inclues toujours le critère de partitionnement dans le filtrage
****/

-- MS SQL Server
/*************** 1 - création des espaces de stockage du partitionnement **************/
/*************** ATTENTION: ce n'est pas possible sur Azure **************/
-- il y a n valeur_pivot, donc il y a n+1 Partition

ALTER DATABASE BaseName
   ADD FILEGROUP DATA_PART_01;
 
ALTER DATABASE BaseName
   ADD FILEGROUP DATA_PART_02;
   
ALTER DATABASE BaseName
   ADD FILEGROUP DATA_PART_03;

-- ajouts de fichiers aux storages :
ALTER DATABASE BaseName
   ADD FILE (NAME       = 'F_PART_01',
             FILENAME   = 'E:\DatabasesSQL\Partitions\F_part_01.ndf',
             SIZE       = 150 GB,  
             FILEGROWTH = 10 MB)  
TO FILEGROUP DATA_PART_01;

LTER DATABASE BaseName
   ADD FILE (NAME       = 'F_PART_02',
             FILENAME   = 'F:\DatabasesSQL\Partitions\F_part_02.ndf',
             SIZE       = 150 GB,  
             FILEGROWTH = 10 MB)  
TO FILEGROUP DATA_PART_02;
 
ALTER DATABASE BaseName
   ADD FILE (NAME       = 'F_PART_03',
             FILENAME   = 'G:\DatabasesSQL\Partitions\F_part_03.ndf',
             SIZE       = 150 GB,  
             FILEGROWTH = 10 MB)  
TO FILEGROUP DATA_PART_03;

-- verify the filegroup assignment
SELECT name as finename,
	physical_name as file_path,
FROM sys.database_files
WHERE type_desc = 'ROWS';

/*************** 2  - CREATE PARTITION FUNCTION **************/
IF EXISTS (SELECT name FROM sys.partition_functions WHERE name = 'Func_Part_Name')
	BEGIN
		DROP PARTITION FUNCTION Func_Part_Name
	END
	
CREATE PARTITION FUNCTION Func_Part_Name  ( input_parameter_type )  
AS 
	RANGE [ LEFT | RIGHT ] 
	FOR VALUES ( [ valeur_pivot_1 ,... ,valeur_pivot_n ] )   


/*************** 3 - création du schéma de partitionnement **************/
/* schéma de partitionnement fait référence à la fonction de partitionnement.
Il inclus les 5 espaces de stockage définis précédemment, c’est à dire les 4 nécessaire au schéma de partitionnement, et un storage supplémentaire de réserve pour des travaux ultérieurs. */
IF EXISTS (SELECT name FROM sys.partition_schemes WHERE name = 'F_S_FAC_DATE')
	BEGIN
		DROP PARTITION SCHEME  F_S_FAC_DATE
	END

CREATE PARTITION SCHEME F_S_FAC_DATE  
AS PARTITION Func_Part_Name
TO (DATA_PART_01, DATA_PART_02, DATA_PART_03);


/*************** 4 - création de l’objet partitionné **************/
CREATE TABLE TableName_PARTITION  
(COLONNE1 INT NOT NULL,
 ...
 COLONNE_DATE  DATE NOT NULL,
 ...
 COLONNEn ...)
ON F_S_FAC_DATE (COLONNE_DATE);

/*
INSERT INTO  TableName_PARTITION (COLONNE1, COLONNE_DATE, ..., COLONNEn)
VALUES (0, '2017-03-08 14:45:00.000', ..., NULL) 
*/

/*********** 10 - Déterminer si une table est partitionnée ***************/
-- https://docs.microsoft.com/fr-fr/sql/relational-databases/partitions/create-partitioned-tables-and-indexes?view=sql-server-ver15
SELECT object_name(object_id),*   
FROM sys.dm_db_partition_stats where object_name(object_id)='TableName_PARTITION';

--https://technet.microsoft.com/fr-fr/ms188730(v=sql.15)

/****** Triouver le nombre de partition existant avant la valeur expression ********/
SELECT $PARTITION.Func_Part_Name (expression);


/*****/
SELECT * FROM sys.partition_range_values;


