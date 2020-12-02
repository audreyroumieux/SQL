-- http://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/

-- mise a jour de la table cible (target =DimTables) par la table source
WITH source AS (
		SELECT * 
		FROM [staging].[Tables]
		WHERE [ImportStatus] = 0
)
-- si
MERGE [dbo].[DimTables] AS D --MERGE INTO [dbo].[DimTables]
    USING source AS S
    ON D.[PrimaryKey] = S.[PrimaryKey] --cle permetent de metre à jour les données

	-- on met a jours les données DimTables avec les données de la source
    WHEN MATCHED THEN
        UPDATE SET D.[Description]			 = S.[Description]
                  ,D.[column_1]			 	 = UPPER(S.[column_1])
				  ,D.[column_2]				 = COALESCE( S.[column_2], S.[column_3])
				  ,D.[StartupDate]			 = CONVERT(datetime2, S.[StartupDate], 121)
	
	-- s'il y a des lignes dans source, mais pas dans la table dim
	-- on les rajoutes		  
    WHEN NOT MATCHED BY TARGET THEN	
		INSERT ([Description]
				,[PrimaryKey]
				,[column_1]
				,[column_2]
				,[StartupDate])
        VALUES (S.[Description]
        ,S.[PrimaryKey]
        ,UPPER(S.[column_1])
		,COALESCE( S.[column_2], S.[column_3])
		,CONVERT(datetime2, S.[ImportDate], 121))
	/*
	-- on suprime les lignes dans dim, qui ne sont pas dans staging	
	 WHEN NOT MATCHED BY SOURCE THEN DELETE */ 
	 ;



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

BEGIN;

CREATE TEMPORARY TABLE Source(id integer, column_1 text, column_2 text);

INSERT INTO Source(id, column_1, column_2) VALUES (2, 'John', 'Do'), (3, 'Alan', 'Turing');

LOCK TABLE [dbo].[DimTables] IN EXCLUSIVE MODE;

UPDATE [dbo].[DimTables]
SET column_1 = Source.column_1,
column_2 = Source.column_2
FROM Source
WHERE Source.id = [DimTables].id;

INSERT INTO [dbo].[DimTables]
SELECT Source.id, Source.column_1, Source.column_2
FROM Source
LEFT OUTER JOIN [dbo].[DimTables] ON ([DimTables].id = Source.id)
WHERE [DimTables].id IS NULL;

COMMIT;


