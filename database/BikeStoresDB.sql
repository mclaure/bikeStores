/*
Deployment script for BikeStores

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BikeStores"
:setvar DefaultFilePrefix "BikeStores"
:setvar DefaultDataPath "E:\Program Files\Microsoft SQL Server\MSSQL15.DEMO\MSSQL\DATA\"
:setvar DefaultLogPath "E:\Program Files\Microsoft SQL Server\MSSQL15.DEMO\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating [dbo].[brands]...';


GO
CREATE TABLE [dbo].[brands] (
    [brand_id]   INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [brand_name] VARCHAR (255)    NOT NULL,
    [rowguid]    UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    CONSTRAINT [PK_brands] PRIMARY KEY CLUSTERED ([brand_id] ASC)
);


GO
PRINT N'Creating [dbo].[categories]...';


GO
CREATE TABLE [dbo].[categories] (
    [category_id]   INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [category_name] VARCHAR (255)    NOT NULL,
    [rowguid]       UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED ([category_id] ASC)
);


GO
PRINT N'Creating [dbo].[customers]...';


GO
CREATE TABLE [dbo].[customers] (
    [customer_id] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [first_name]  VARCHAR (255)    NOT NULL,
    [last_name]   VARCHAR (255)    NOT NULL,
    [phone]       VARCHAR (25)     NULL,
    [email]       VARCHAR (255)    NOT NULL,
    [street]      VARCHAR (255)    NULL,
    [city]        VARCHAR (50)     NULL,
    [state]       VARCHAR (25)     NULL,
    [zip_code]    VARCHAR (5)      NULL,
    [rowguid]     UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED ([customer_id] ASC)
);


GO
PRINT N'Creating [dbo].[order_items]...';


GO
CREATE TABLE [dbo].[order_items] (
    [order_id]   INT             NOT NULL,
    [item_id]    INT             NOT NULL,
    [product_id] INT             NOT NULL,
    [quantity]   INT             NOT NULL,
    [list_price] DECIMAL (10, 2) NOT NULL,
    [discount]   DECIMAL (4, 2)  NOT NULL,
    CONSTRAINT [PK_order_items] PRIMARY KEY CLUSTERED ([order_id] ASC, [item_id] ASC)
);


GO
PRINT N'Creating [dbo].[orders]...';


GO
CREATE TABLE [dbo].[orders] (
    [order_id]      INT     IDENTITY (1, 1) NOT NULL,
    [customer_id]   INT     NULL,
    [order_status]  TINYINT NOT NULL,
    [order_date]    DATE    NOT NULL,
    [required_date] DATE    NOT NULL,
    [shipped_date]  DATE    NULL,
    [store_id]      INT     NOT NULL,
    [staff_id]      INT     NOT NULL,
    CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED ([order_id] ASC)
);


GO
PRINT N'Creating [dbo].[products]...';


GO
CREATE TABLE [dbo].[products] (
    [product_id]   INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [product_name] VARCHAR (255)    NOT NULL,
    [brand_id]     INT              NOT NULL,
    [category_id]  INT              NOT NULL,
    [model_year]   SMALLINT         NOT NULL,
    [list_price]   DECIMAL (10, 2)  NOT NULL,
    [rowguid]      UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED ([product_id] ASC)
);


GO
PRINT N'Creating [dbo].[staffs]...';


GO
CREATE TABLE [dbo].[staffs] (
    [staff_id]   INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [first_name] VARCHAR (50)     NOT NULL,
    [last_name]  VARCHAR (50)     NOT NULL,
    [email]      VARCHAR (255)    NOT NULL,
    [phone]      VARCHAR (25)     NULL,
    [active]     TINYINT          NOT NULL,
    [store_id]   INT              NOT NULL,
    [manager_id] INT              NULL,
    [rowguid]    UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    CONSTRAINT [PK_staffs] PRIMARY KEY CLUSTERED ([staff_id] ASC)
);


GO
PRINT N'Creating [dbo].[stocks]...';


GO
CREATE TABLE [dbo].[stocks] (
    [store_id]   INT              NOT NULL,
    [product_id] INT              NOT NULL,
    [quantity]   INT              NULL,
    [rowguid]    UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    CONSTRAINT [PK_stocks] PRIMARY KEY CLUSTERED ([store_id] ASC, [product_id] ASC)
);


GO
PRINT N'Creating [dbo].[stores]...';


GO
CREATE TABLE [dbo].[stores] (
    [store_id]   INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [store_name] VARCHAR (255)    NOT NULL,
    [phone]      VARCHAR (25)     NULL,
    [email]      VARCHAR (255)    NULL,
    [street]     VARCHAR (255)    NULL,
    [city]       VARCHAR (255)    NULL,
    [state]      VARCHAR (10)     NULL,
    [zip_code]   VARCHAR (5)      NULL,
    [rowguid]    UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    CONSTRAINT [PK_stores] PRIMARY KEY CLUSTERED ([store_id] ASC)
);


GO
PRINT N'Creating [dbo].[DF_brands_rowguid]...';


GO
ALTER TABLE [dbo].[brands]
    ADD CONSTRAINT [DF_brands_rowguid] DEFAULT NEWID() FOR [rowguid];


GO
PRINT N'Creating [dbo].[DF_categories_rowguid]...';


GO
ALTER TABLE [dbo].[categories]
    ADD CONSTRAINT [DF_categories_rowguid] DEFAULT NEWID() FOR [rowguid];


GO
PRINT N'Creating [dbo].[DF_customers_rowguid]...';


GO
ALTER TABLE [dbo].[customers]
    ADD CONSTRAINT [DF_customers_rowguid] DEFAULT NEWID() FOR [rowguid];


GO
PRINT N'Creating [dbo].[DF_products_rowguid]...';


GO
ALTER TABLE [dbo].[products]
    ADD CONSTRAINT [DF_products_rowguid] DEFAULT NEWID() FOR [rowguid];


GO
PRINT N'Creating [dbo].[DF_staffs_rowguid]...';


GO
ALTER TABLE [dbo].[staffs]
    ADD CONSTRAINT [DF_staffs_rowguid] DEFAULT NEWID() FOR [rowguid];


GO
PRINT N'Creating [dbo].[DF_stocks_rowguid]...';


GO
ALTER TABLE [dbo].[stocks]
    ADD CONSTRAINT [DF_stocks_rowguid] DEFAULT NEWID() FOR [rowguid];


GO
PRINT N'Creating [dbo].[DF_stores_rowguid]...';


GO
ALTER TABLE [dbo].[stores]
    ADD CONSTRAINT [DF_stores_rowguid] DEFAULT NEWID() FOR [rowguid];


GO
PRINT N'Creating [dbo].[sp_InsertOrGetBrandName]...';


GO
/*
 Procedure Name: [dbo].[sp_InsertOrGetBrandName]
 Inserts a new Brand name and returns the recently created Id
 If the brand already exists, returns the existing Id
*/
CREATE PROCEDURE [dbo].[sp_InsertOrGetBrandName]
(
	@brandName VARCHAR(255)
)
AS
BEGIN
	DECLARE @Id INT = 0;

	IF EXISTS(SELECT 1 
			  FROM [dbo].[brands]
			  WHERE [brand_name] = @brandName)
	BEGIN
		  SELECT @Id = [brand_id]
		  FROM [dbo].[brands]
		  WHERE [brand_name] = @brandName;
	END
	ELSE
	 BEGIN
		 INSERT INTO [dbo].[brands]([brand_name])
		 VALUES(@brandName);

		 SET @Id = SCOPE_IDENTITY();
	 END
	RETURN @Id;
END
GO
PRINT N'Update complete.';


GO
