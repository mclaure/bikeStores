SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[brands]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[brands] ADD
[brand_category] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_brands_brand_category] DEFAULT ('None')
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[sp_InsertOrGetBrandName]'
GO
/*
 Procedure Name: [dbo].[sp_InsertOrGetBrandName]
 Inserts a new Brand name and returns the recently created Id
 If the brand already exists, returns the existing Id
 Author: Marcelo Claure
*/
ALTER PROCEDURE [dbo].[sp_InsertOrGetBrandName]
(
	@brandName VARCHAR(255)
   ,@flag BIT =0
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
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
