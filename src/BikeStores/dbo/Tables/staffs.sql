CREATE TABLE [dbo].[staffs]
(
	[staff_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[phone] [varchar](25) NULL,
	[active] [tinyint] NOT NULL,
	[store_id] [int] NOT NULL,
	[manager_id] [int] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	CONSTRAINT PK_staffs PRIMARY KEY([staff_id])
)
GO
ALTER TABLE [dbo].[staffs] ADD CONSTRAINT DF_staffs_rowguid DEFAULT NEWID() FOR [rowguid]
GO