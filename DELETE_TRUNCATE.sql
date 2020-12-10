
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