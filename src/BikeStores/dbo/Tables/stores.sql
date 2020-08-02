CREATE TABLE [dbo].[stores]
(
	[store_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[store_name] [varchar](255) NOT NULL,
	[phone] [varchar](25) NULL,
	[email] [varchar](255) NULL,
	[street] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[state] [varchar](10) NULL,
	[zip_code] [varchar](5) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	CONSTRAINT PK_stores PRIMARY KEY([store_id])
)
GO
ALTER TABLE [dbo].[stores] ADD CONSTRAINT DF_stores_rowguid DEFAULT NEWID() FOR [rowguid]
GO