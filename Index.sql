
/* Un Index permet d'accedé plus rapidement aux données (meilleure recherche, on l'associe souvent au annuaire téléphonique).
L'index peut également être un index UNIQUE, ce qui signifie que vous ne pouvez pas avoir de valeurs dupliquées dans cette colonne, ou une CLÉ PRIMAIRE qui, dans certains moteurs de stockage, définit où la valeur est stockée dans le fichier de base de données.

L'idée de l'index cluster est de faire 1 pierre 2 coups : mélanger l'index et la table. On sévite ainsi une redondance et les lignes de la table sont physiquement triées selon l'ordre de la cléf d'index.
Il ne peut exister qu'un seul cluter Index (index en grape) par table. Car l'index cluster c'est la table elle même */
--- Create a nonclustered index
CREATE {UNIQUE} {CLUSTERD |NONCLUSTERDE} INDEX index_nom ON tableName {(`colonne1` DESC, `colonne2` ASC, ...)};

/******* Index COLUMNSTORE *******/
-- l'index columstore est utilisé souvent conjointement à du partitionnement <=> primarykey
CREATE CLUSTERD COLUMNSTORED INDEX index_name 
	ON tableName {WITH (DROP_EXISTING = {ON | OFF}  )}; --default is OFF
-- non cluster
CREATE COLUMNSTORED INDEX index_name 
	ON tableName (column [, ...n])
	[WHERE <filter_expression> [AND <filter_expression>]]
	[WITH ( <with_option> [, ...n])
	[ON <on_option>]; 



/**** DROP INDEX : ****/
-- MS Access / SQL Server 	DROP INDEX [IF EXISTE] index_nom ON tableName;
-- Oracle			DROP INDEX index_nom;
-- MySQL			ALTER TABLE tableName DROP INDEX index_nom;


/**** Convention de nommage: ****/
-- Préfixe “PK_” pour Primary Key
-- Préfixe “FK_” pour Foreign Key
-- Préfixe “UK_” pour Unique Key
-- Préfixe “UX_” pour Unique Index
-- Préfixe “IX_” pour chaque autre IndeX

