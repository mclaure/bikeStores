SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
PRINT N'Altering [dbo].[sp_InsertOrGetBrandName]'
GO
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
GO
