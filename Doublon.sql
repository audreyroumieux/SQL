
-- Doublon  absolu

SELECT   COUNT(*) AS nbr_doublon, champ1, champ2, champ3
FROM  dbo.mytable
GROUP BY champ1, champ2, champ3
HAVING   COUNT(*) > 1;



-- Doublon relatif

SELECT DISTINCT *
FROM table t1
WHERE EXISTS (
              SELECT *
              FROM table t2
              WHERE t1.ID <> t2.ID
              AND   t1.champ1 = t2.champ1
              AND   t1.champ2 = t2.champ2
              AND   t1.champ3 = t2.champ3 );


SELECT dbl.*, p.[col1] 
FROM [core].[Worksites] p 
  JOIN (
SELECT   COUNT(*) AS nbr_doublon, [col1], [col2], [col3]
FROM    [core].[Worksites]
GROUP BY [col1], [col2], [col3]
HAVING   COUNT(*) > 1) dbl ON p.[col1] = dbl.[col1] 
						AND p.[col2] = dbl.[col2] 
						AND p.[col3] = dbl.[col3];


-------------------

SELECT *, ROW_NUMBER() OVER (PARTITION BY champ1, champ2, champ3 ORDER BY champ2, champ4) as rno
FROM  [stg].[mytable];


----------------

SELECT *, RANK() OVER (PARTITION BY champ1, champ2, champ3 ORDER BY champ2, champ4) as rno
FROM  [stg].[mytable];



