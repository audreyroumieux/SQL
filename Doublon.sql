
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


SELECT dbl.*, p.[WBS] 
FROM [core].[Worksites] p 
  JOIN (
SELECT   COUNT(*) AS nbr_doublon, [WBS], [COCD], [DivisionID]
FROM    [core].[Worksites]
GROUP BY [WBS], [COCD], [DivisionID]
HAVING   COUNT(*) > 1) dbl ON p.[WBS] = dbl.[WBS] AND p.[COCD] = dbl.[COCD] AND p.[DivisionID] = dbl.[DivisionID];



-------------------


SELECT *, ROW_NUMBER() OVER (PARTITION BY champ1, champ2, champ3 ORDER BY champ2, champ4) as rno
FROM  [staging].[TimeEntries]



----------------
SELECT *, RANK() OVER (PARTITION BY champ1, champ2, champ3 ORDER BY champ2, champ4) as rno




