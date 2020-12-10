/******************* TRANSPOSITION ****************************/
/** --on a dans un excel:
clef;valeur
nom;dupont
prenom;toto
age;33

-- et on veut :
nom;prenom;age
dupont;toto;33
**/


/******* Postgresql ********/
SELECT 
string_agg(f2, ',') FILTER(WHERE F1 = 'Nom') as nom
, string_agg(f2, ',') FILTER(WHERE F1 = 'Prénom') as prenom
, string_agg(f2, ',') FILTER(WHERE F1 = 'Age') as age
FROM stg.table_non_transpose;


/******* SQL Server ********/

SELECT 
(SELECT F2 FROM stg.table_non_transpose WHERE F1 = 'Prénom')) as Prenom,
(SELECT F2 FROM stg.table_non_transpose WHERE F1 = 'Age')) as age
;

