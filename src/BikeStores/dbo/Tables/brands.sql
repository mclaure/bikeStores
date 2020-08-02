CREATE TABLE [dbo].[brands]
(
	[brand_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[brand_name] [varchar](255) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL,
	CONSTRAINT PK_brands PRIMARY KEY([brand_id])
)
GO
ALTER TABLE [dbo].[brands] ADD CONSTRAINT DF_brands_rowguid DEFAULT NEWID() FOR [rowguid]
GO