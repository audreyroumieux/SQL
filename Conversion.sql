/*********************************************/
/************** Converstion Date *************/
/*********************************************/
/**** https://docs.microsoft.com/fr-fr/sql/t-sql/functions/cast-and-convert-transat-sql?view=sql-server-ver15 ****/
/**** T-SQL / SQL SERVER / MySQL  ****/
SET DATEFORMAT mdy;
SELECT CAST('25/09/2017' AS DATE) AS "startDate", ...
/** ou **/
CONVERT('DATE', 'startDate', 103) AS "StartDate", ...
-- 103 = jj/mm/aaaa
-- 104 = jj.mm.aaaa
-- 105 = jj-mm-aaaa

/**** Oracle ou Snoflake ****/
TO_DATE("startDate", "DD/MM/YYYY") AS "StartDate"
