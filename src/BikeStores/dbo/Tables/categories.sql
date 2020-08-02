
CREATE TABLE [dbo].[categories]
(
	[category_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[category_name] [varchar](255) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    CONSTRAINT PK_categories PRIMARY KEY ([category_id])
)
GO
ALTER TABLE [dbo].[categories] ADD CONSTRAINT DF_categories_rowguid DEFAULT NEWID() FOR [rowguid]
GO