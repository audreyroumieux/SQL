/********************************************/
-- Doublon  absolu
SELECT COUNT(*) AS nbr_doublon, champ1, champ2, champ3
FROM  dbo.mytable
GROUP BY champ1, champ2, champ3
HAVING   COUNT(*) > 1;

-- table_A = table_B si l'UNION a exactement le même nb de lignes
SELECT * FROM table_A
UNION
SELECT * FROM table_B;
	
/********************************************/
-- Doublon relatif
SELECT DISTINCT *
FROM table as t1
WHERE EXISTS (
              SELECT *
              FROM table t2
              WHERE t1.ID <> t2.ID
              AND   t1.champ1 = t2.champ1
              AND   t1.champ2 = t2.champ2
              AND   t1.champ3 = t2.champ3 );

-------------------
SELECT *, ROW_NUMBER() OVER (PARTITION BY champ1, champ2, champ3 ORDER BY champ2, champ4) as rno
FROM  [stg].[mytable];


----------------
SELECT *, RANK() OVER (PARTITION BY champ1, champ2, champ3 ORDER BY champ2, champ4) as rno
FROM  [stg].[mytable];


--- Selection de toutes les lignes doublonné d'une table
SELECT dbl_table.*, p.[col1] 
FROM [core].[Worksites] p 
JOIN (
	SELECT   COUNT(*) AS nbr_doublon, [col1], [col2], [col3]
	FROM    [core].[Worksites]
	GROUP BY [col1], [col2], [col3]
	HAVING   COUNT(*) > 1
	) dbl_table 
ON p.[col1] = dbl.[col1] AND p.[col2] = dbl.[col2] AND p.[col3] = dbl.[col3];

-- select row less doublon
SELECT DISTINCT *
FROM [core].[Worksites]
-- /!\ it's different to 
SELECT [col1], [col2], [col3]
FROM [core].[Worksites]
INTERSECT
SELECT COUNT(*) AS nbr_doublon, [col1], [col2], [col3]
FROM    [core].[Worksites]
GROUP BY [col1], [col2], [col3]
HAVING   COUNT(*) > 1)  dbl_table;

/****************** Suprimer doublon ********************/
DELETE FROM tableX
LEFT OUTER JOIN (
	SELECT Min(id) as id, Col1, Col2, Col3
	FROM tableX
	GROUP BY Col1, Col2, Col3
) as t1
ON tableX.id = t1.id
WHERE t1.id IS NULL;

-- or
DELETE t1
FROM tableX As t1, tableX as t2
WHERE t1.id > t2.id
AND t1.Col1 = t2.Col1 AND t1.Col2 =t2.Col2 AND t1.Col3 = t2.Co3
