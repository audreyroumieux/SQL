-- http://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/
-- mise a jour de la table cible (target) par la table source
WITH source AS (
		SELECT * 
		FROM [staging].[Tables]
		WHERE [ImportStatus] = 0
)
-- si
MERGE [dbo].[DimTables] AS D --MERGE INTO [dbo].[DimTables]
    USING source AS S
    ON D.[PrimaryKey] = S.[PrimaryKey]

	-- alors on mais a jours DimTables
    WHEN MATCHED THEN
        UPDATE SET D.[Description]					 = S.[Description]
                  ,D.[SerialNumber]					 = UPPER(S.[ManufSerialNumber])
				  ,D.[Region]						 = COALESCE( S.[Region], S.[Departement])
				  ,D.[StartupDate]					 = CONVERT(datetime2, S.[StartupDate], 104)
	
	-- s'il y a des lignes dans source, mais pas dans dim
	-- on les insere		  
    WHEN NOT MATCHED BY TARGET THEN	
		INSERT ([Description]
				,[PrimaryKey]
				,[SerialNumber]
				,[Region]
				,[StartupDate])
        VALUES (S.[Description]
        ,S.[PrimaryKey]
        ,UPPER(S.[ManufSerialNumber])
		,COALESCE( S.[Region], S.[Departement])
		,CONVERT(datetime2, S.[ImportDate], 121))
	/*
	-- on suprime les lignes dans dim, qui ne sont pas dans staging	
	 WHEN NOT MATCHED BY SOURCE THEN DELETE */ ;
