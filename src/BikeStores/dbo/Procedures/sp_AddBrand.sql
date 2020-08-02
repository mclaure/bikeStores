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