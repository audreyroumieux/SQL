
WITH RECURSIVE temp (n, fact) AS 
(SELECT 0, 1 -- Initial Subquery
  UNION ALL 
 SELECT n+1, (n+1)*fact FROM temp -- Recursive Subquery 
        WHERE n < 9)
SELECT * FROM temp;

-- CONNECT BY

SELECT employee_id, last_name, manager_id
FROM employees
CONNECT BY PRIOR employee_id = manager_id;
   
   