-- http://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/
USE databaseName; GO
CREATE OR ALTER PROCEDURE dbo.MergeProcedureName(
	@Id INT,
	@Name NVARCHAR(100),
	@LastName NVARCHAR(255)
)
AS
BEGIN
-- mise a jour de la table cible (target =DimTables) par la table source
WITH source AS (
		SELECT * 
		FROM [staging].[Tables]
		WHERE [ImportStatus] = 0
)
-- si
MERGE [dbo].[DimTables] WITH (HOLDLOCK) AS T --HOLDLOCK permet d'ouvrir ou non le verrou pour ne pas avoir l'erreur de violation de clé primaire --Target
    USING source AS S
    /*USING (SELECT @Id as Id, @Name as Name, @LastName as LastName) AS S */
    ON D.[PrimaryKey] = S.[PrimaryKey] --cle permetent de metre à jour les données
	-- on met a jours les données DimTables avec les données de la source
    WHEN MATCHED THEN
        UPDATE SET D.[Description]			 = S.[Description]
		, D.[column_1]			 	 = UPPER(S.[column_1])
		, D.[column_2]				 = COALESCE( S.[column_2], S.[column_3])
		, D.[StartupDate]			 = CONVERT(datetime2, S.[StartupDate], 121)
	
	-- s'il y a des lignes dans source, mais pas dans la table dim, on les rajoutes		  
    WHEN NOT MATCHED BY TARGET THEN	
		INSERT ([Description]
			,[PrimaryKey]
			,[column_1]
			,[column_2]
			,[StartupDate])
        VALUES (  S.[Description]
		, S.[PrimaryKey]
		, UPPER(S.[column_1])
		, COALESCE(S.[column_2], S.[column_3])
		, CONVERT(datetime2, S.[ImportDate], 121))
	/* -- on suprime les lignes dans dim, qui ne sont pas dans staging	
	 WHEN NOT MATCHED BY SOURCE THEN DELETE */ 
	 ;
END
GO

/************************Si on veut faire que de l'insertion dans la table cible (target)*******************************/
INSERT INTO Target_table (colonne1, colonne2, colonne3)
SELECT valeur1, valeur2, valeur3
FROM source_Table
WHERE NOT EXISTS (
	SELECT colonne1, colonne2, colonne3
	FROM Target_table
	WHERE colonne1 = valeur1 AND colonne2 = valeur2 AND colonne3 = valeur3
);

/************************Pour Postgresql utilisison : UPSERT *******************************/
INSERT INTO [dbo].[DimTables] (PrimaryKey, Description)
VALUES (PrimaryKey_value, Description_new_value)
ON CONFLICT (PrimaryKey)
--ON CONFLICT ON CONSTRAINT DimTables_PK
DO UPDATE SET Description = EXCLUDED.Description_new_value || ';' || [DimTables].Description
--DO NOTHING;


/********************************** BULK INSERT **********************************
-- 1 - Créez une table TEMPORAIRE
-- 2 - Copiez ou insérez les nouvelles données dans la table temporaire
-- 3 - LOCK la table cible IN EXCLUSIVE MODE. Cela sélectionne d'autres transactions, mais ne modifie pas la table.
-- 4 - UPDATE ... à partir des enregistrements existants dans la table temporaire
-- 5 - INSERT les ligne qui n'existe pas encore dans la table
-- 6 - COMMIT, en libérant le verrou
/********************************************************************/

BEGIN

CREATE TEMPORARY TABLE my_source(id integer, column_1 text, column_2 text);

INSERT INTO my_source(id, column_1, column_2) VALUES (2, 'John', 'Do'), (3, 'Alan', 'Turing');

LOCK TABLE [dbo].[DimTables] IN EXCLUSIVE MODE;

UPDATE [dbo].[DimTables]
SET column_1 = my_source.column_1, column_2 = my_source.column_2
FROM my_source
WHERE my_source.id = [DimTables].id;

INSERT INTO [dbo].[DimTables]
SELECT my_source.id, my_source.column_1, my_source.column_2
FROM my_source
LEFT OUTER JOIN [dbo].[DimTables] ON ([DimTables].id = my_source.id)
WHERE [DimTables].id IS NULL;
COMMIT;

COMMIT;

