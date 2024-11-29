USE [gdp_dwh_fra_toqla]
GO
DROP TABLE [inf_toqla_fr_fr].[DimUtilisateurSCDV2];
CREATE TABLE [inf_toqla_fr_fr].[DimUtilisateurSCDV2](
	[IdUtilisateurToqla] [int] IDENTITY(1,1) NOT NULL,
	[OssGuid] [varchar](255) NOT NULL,
	[ConsumerNumber] [varchar](50) NOT NULL,
	[IdEntiteClient] [varchar](255) NULL,
	[DateCreationCompte] [datetime2](7) NULL,
	[DateDerniereConnexionCompte] [datetime2](7) NULL,
	[DateDactivation] [datetime2](7) NOT NULL,
	[DateDeDesactivation] [datetime2](7) NULL,
	[ProfilToqla] [varchar](10) NOT NULL,
CONSTRAINT [pk_DimUtilisateurSCDV2] PRIMARY KEY CLUSTERED 
(
	[OssGuid] ASC,
	[ConsumerNumber] ASC,
	[DateDactivation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
 
DROP TABLE [stg_toqla_fr_fr].[TESTSCD_RefBeneficiaire]
CREATE TABLE [stg_toqla_fr_fr].[TESTSCD_RefBeneficiaire](
	[ClientEntiteId] [varchar](20) NULL,
	[ConsumerNumber] [varchar](10) NULL,
	[GdpDateCreated][datetime2](7) NOT NULL
) ON [PRIMARY]
GO
 
INSERT INTO [stg_toqla_fr_fr].[TESTSCD_RefBeneficiaire] (ClientEntiteId,ConsumerNumber,GdpDateCreated)
VALUES ('client1', 'CN100BRS', '2023-01-16'), ('client2', 'CN001HYB', '2023-01-16'), ('client2', 'CN002HYB', '2023-01-16');
 
TRUNCATE TABLE [stg_toqla_fr_fr].[TESTSCD_RefBeneficiaire];
INSERT INTO [stg_toqla_fr_fr].[TESTSCD_RefBeneficiaire] (ClientEntiteId,ConsumerNumber,GdpDateCreated)
VALUES ('client1', 'CN100BRS', '2023-06-15'), ('client2', 'CN001HYB', '2023-06-15'), ('client3', 'CN003HYB', '2023-06-15');
 
SELECT * FROM [stg_toqla_fr_fr].[TESTSCD_RefBeneficiaire];
 
INSERT INTO [stg_toqla_fr_fr].[TESTSCD_RefBeneficiaire] (ClientEntiteId,ConsumerNumber,GdpDateCreated)
VALUES ('test1', 'CN100BRS', '2023-06-16'), ('2test', 'CN001HYB', '2023-06-16');
 
/***************************/
DROP TABLE [stg_toqla_fr_fr].[TESTSCD_RefUtilisateurToqla]
CREATE TABLE [stg_toqla_fr_fr].[TESTSCD_RefUtilisateurToqla](
	[UtilisateurId] [int] NULL,
	[IdConvive] [nvarchar](20) NULL,
	[ConsumerNumber] [nvarchar](20) NULL,
	[IdEntiteClient] [nvarchar](20) NULL,
	[IdSite] [nvarchar](10) NULL,
	[NomSite] [nvarchar](100) NULL,
	[DateCreationCompte] [datetime2](7) NULL,
	[DateDerniereConnexionCompte] [datetime2](7) NULL,
	[GdpDateCreated][datetime2](7) NOT NULL
) ON [PRIMARY]
GO
 
INSERT INTO [stg_toqla_fr_fr].[TESTSCD_RefUtilisateurToqla] 
(UtilisateurId, IdConvive, ConsumerNumber, IdEntiteClient, IdSite, DateCreationCompte, DateDerniereConnexionCompte, GdpDateCreated)
VALUES (1111, 'convive1', Null, 'entiteClient1', 'Site1', '2023/02/06', Null, '2023-01-16')
, (2222,'convive2','CN001HYB', 'entiteClient2', 'Site1', '2023/02/06', Null, '2023-01-16')
, (3333,'convive3','CN002HYB', 'entiteClient2', 'Site1', '2023/02/06', Null, '2023-01-16');
 
TRUNCATE TABLE [stg_toqla_fr_fr].[TESTSCD_RefUtilisateurToqla];
 
INSERT INTO [stg_toqla_fr_fr].[TESTSCD_RefUtilisateurToqla] 
(UtilisateurId, IdConvive, ConsumerNumber, IdEntiteClient, IdSite, DateCreationCompte, DateDerniereConnexionCompte, GdpDateCreated)
VALUES (1111, 'convive1', 'CN003HYB', 'entiteClient1', 'OSS->HYB', '2023/02/06', Null, '2023-06-15')
, (3333,'convive3',Null, 'entiteClient2', 'HYB->OSS', '2023/02/06', Null, '2023-06-15')
, (4444,'convive4','CN100BRS', 'entiteClient1', 'BRS->HYB', '2023/06/01', Null, '2023-06-15');
 
SELECT * FROM [stg_toqla_fr_fr].[TESTSCD_RefUtilisateurToqla]
 
INSERT INTO [stg_toqla_fr_fr].[TESTSCD_RefUtilisateurToqla] 
(UtilisateurId, IdConvive, ConsumerNumber, IdEntiteClient, IdSite, DateCreationCompte, DateDerniereConnexionCompte, GdpDateCreated)
VALUES  (3333,'convive3',Null, 'toto', 'HYB->OSS', '2023/02/06', Null, '2023-06-16')
, (4444,'convive4','CN100BRS', 'Tata', 'BRS->HYB', '2023/06/01', Null, '2023-06-16');
