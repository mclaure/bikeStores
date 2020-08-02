CREATE TABLE [dbo].[stocks]
(
	[store_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	CONSTRAINT PK_stocks PRIMARY KEY([store_id],[product_id])
)
GO
ALTER TABLE [dbo].[stocks] ADD CONSTRAINT DF_stocks_rowguid DEFAULT NEWID() FOR [rowguid]
GO