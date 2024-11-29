
WITH RECURSIVE temp (n, fact) AS 
(SELECT 0, 1 -- Initial Subquery
  UNION ALL 
 SELECT n+1, (n+1)*fact FROM temp -- Recursive Subquery 
        WHERE n < 9)
SELECT * FROM temp;

------
WITH RECURSIVE table_temp_n(empid, name) AS (
  --initial Subquery
  SELECT empid, name
  FROM emp
  WHERE name = 'Joan'
  UNION ALL
  --recursive subquery
  SELECT nplus1.empid, nplus1.name
  FROM emp as nplus1, table_temp_n
  WHERE table_temp_n.empid =nplus1.mgrid)

SELECT name FROM table_temp_n;

/************* <=> CONNECT BY (sous ORACLE) ************/
SELECT employee_id, last_name, manager_id
FROM employees
CONNECT BY PRIOR employee_id = manager_id;
   
SELECT EMPLOYEE_DATA.*, SYS_CONNECT_BY_PATH(MRG_USERNAME, ',') "Path"
FROM EMPLOYEE_DATA
START WITH MGR_USERNAME = 'ceo'
CONECT BY NOCYCLE prior EE_USERNAME = MGR_USERNAME

-- <=>
WITH cte AS (
  SELECT e.*, mgr.EE_USERNAME AS Path
  FROM EMPLOYEE_DATA AS mgr
  JOIN EMPLOYEE_DATA AS e ON mgr.EE_USERNAME = e.MGR_USERNAME
  )
SELECT * FROM cte
-- OPTION (MAXRECURSTION 200)  --if you need a different value
;
  
   
/* Convert this
L1   L1DESC  L2   PaysD.     L3    DepartementD.  L4         Ville
10   Europe  101  France     FR30  Gars           FR0018203  Bagnols/ceze
10   Europe  101  France     FR34  Hérault        FR0277639  Montpellier
10   Europe  102  Allemange  AL01  Berlin         AL3748148  Berlin


IN this :
Level         Description       ParentLevel
10            Europe            NULL
101           France            10
102           Allemange         10
FR30          Gars              101
FR34          Hérault           101
AL01          Berlin            102
FR0018203     Bagnols/ceze      FR30
FR0277639     Montpellier       FR34
AL3748148     Berlin            AL01
*/

/***** SOLUTION 1 *****/

/***** SOLUTION 2 *****/
SELECT   
    Mgr.EmployeeID AS MgrID, Mgr.LoginID AS Manager,   
    Emp.EmployeeID AS E_ID, Emp.LoginID, Emp.JobTitle  
FROM HumanResources.EmployeeDemo AS Emp  
LEFT JOIN HumanResources.EmployeeDemo AS Mgr  
ON Emp.ManagerID = Mgr.EmployeeID  
ORDER BY MgrID, E_ID  
