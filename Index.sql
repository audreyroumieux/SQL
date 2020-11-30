
/* Un Index permet d'accedé plus rapidement aux données (meilleure recherche, on l'associe souvent au annuaire téléphonique).
L'index peut également être un index UNIQUE, ce qui signifie que vous ne pouvez pas avoir de valeurs dupliquées dans cette colonne, ou une CLÉ PRIMAIRE qui, dans certains moteurs de stockage, définit où la valeur est stockée dans le fichier de base de données.

Il ne peut exister qu'un seul cluter Index (index en grape) par table.*/

CREATE {UNIQUE} INDEX index_nom ON tableName {(`colonne1`, `colonne2` , ...)};

	-- DROP INDEX :
-- MS Access			DROP INDEX index_nom ON tableName;
-- SQL Server			DROP INDEX tableName.index_nom;
-- Oracle				DROP INDEX index_nom;
-- MySQL				ALTER TABLE tableName DROP INDEX index_nom;


	-- Convention de nommage:
-- Préfixe “PK_” pour Primary Key
-- Préfixe “FK_” pour Foreign Key
-- Préfixe “UK_” pour Unique Key
-- Préfixe “UX_” pour Unique Index
-- Préfixe “IX_” pour chaque autre IndeX

