CREATE TABLE [dbo].[order_items]
(
	[order_id] [int] NOT NULL,
	[item_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[list_price] [decimal](10, 2) NOT NULL,
	[discount] [decimal](4, 2) NOT NULL,
	CONSTRAINT PK_order_items PRIMARY KEY([order_id],[item_id])
)
GO