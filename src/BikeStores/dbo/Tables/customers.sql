CREATE TABLE [dbo].[customers]
(
	[customer_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[first_name] [varchar](255) NOT NULL,
	[last_name] [varchar](255) NOT NULL,
	[phone] [varchar](25) NULL,
	[email] [varchar](255) NOT NULL,
	[street] [varchar](255) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](25) NULL,
	[zip_code] [varchar](5) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	CONSTRAINT PK_customers PRIMARY KEY([customer_id])
)
GO
ALTER TABLE [dbo].[customers] ADD CONSTRAINT DF_customers_rowguid DEFAULT NEWID() FOR [rowguid]
GO