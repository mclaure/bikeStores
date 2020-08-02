CREATE TABLE [dbo].[products]
(
	[product_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[product_name] [varchar](255) NOT NULL,
	[brand_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[model_year] [smallint] NOT NULL,
	[list_price] [decimal](10, 2) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    CONSTRAINT PK_products PRIMARY KEY([product_id])
)
GO
ALTER TABLE [dbo].[products] ADD CONSTRAINT DF_products_rowguid DEFAULT NEWID() FOR [rowguid]
GO