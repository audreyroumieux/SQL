/************************ TRANSFPOSITION *************************/
/** -- on a dans une table:
id;col_val;col_x
1;1;"..."
2;1;"toto"
3;1;"titi"
10;10;"..."

--et on veut trier en fonction de la valeur maximal de col_val:
id;col_val;col_x
1;10;"..."
2;1;"titi"
3;1;"xxxx"
**/

SELECT a.id, a.col_val, a.col_x
FROM YourTable a
INNER JOIN(
  SELECT id, MAX(col_val) col_val FROM YourTable GROUP BY b.id
) AND a.col_val = b.col_val;

/***** OR *****/
SELECT a.*
FROM YourTable a
LEFT OUTER JOIN YourTable b
ON a.id = b.id AND a.col_val < b.col_val
WHERE b.id IS NULL;

/***** OR *****/
SELECT *
FROM YourTable 
WHERE (id, col_val) IN (
  SELECT id, MAX(col_val) as col_val FROM YourTable GROUP BY b.id
);
