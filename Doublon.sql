
-- Doublon  absolu

SELECT   COUNT(*) AS nbr_doublon, champ1, champ2, champ3
FROM     table
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
