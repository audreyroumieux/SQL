
/********** DELETE ALL RECORDS ***********/
DELETE FROM table_1;


/********** DELETE Specific RECORDS ***********/
DELETE FROM table_1
WHERE champ1 = "Spécific value";


/********* Suppresion de doublon dans une table *****/

DELETE FROM table_1
WHERE ID NOT IN (
			SELECT  min(ID)
			FROM  table_1
			GROUP BY champ_doublone);


-- Deleting Referential Integrity Violations
/********* Supprime toutes les lignes qui ne correspondent pas aux lignes retournées entre parentheses **************/
-- NOT IN <=> NOT EXISTS

DELETE FROM table_2
WHERE champ1 NOT IN (SELECT champ1 FROM table_1);

 -- <=>
DELETE FROM table_2
WHERE NOT EXISTS (SELECT * FROM table_1 WHERE table_2.champ1 = table_1.champ1);



/**************************/
