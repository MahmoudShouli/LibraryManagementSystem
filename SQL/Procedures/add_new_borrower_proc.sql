DROP PROCEDURE IF EXISTS  sp_AddNewBorrower
GO

CREATE PROCEDURE sp_AddNewBorrower 
	@FirstName NVARCHAR(255), 
	@LastName NVARCHAR(255), 
	@Email NVARCHAR(255),
	@DateOfBirth DATE, 
	@MembershipDate DATE, 
	@ErrorMessage NVARCHAR(255) OUTPUT,
	@NewBorrowerID INT OUTPUT
AS 
BEGIN
	IF EXISTS (SELECT 1 FROM Borrowers WHERE Email = @Email)
	BEGIN
		SET @ErrorMessage = 'A borrower with this email already exists.';
		RETURN;
	END

	INSERT INTO Borrowers (First_Name, Last_Name, Email, Date_of_Birth, Membership_Date)
    VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);

	SET @NewBorrowerID = SCOPE_IDENTITY();
	SET @ErrorMessage = 'No error. Sucessfully added';
END;

/* usage

DECLARE @Msg NVARCHAR(255), @ID INT, @Today DATE = GETDATE();

EXEC sp_AddNewBorrower
    @FirstName = 'Lina',
    @LastName = 'Kamal',
    @Email = 'lina.kamal@example.com',
    @DateOfBirth = '1990-08-15',
    @MembershipDate = @Today,
    @ErrorMessage = @Msg OUTPUT,
    @NewBorrowerID = @ID OUTPUT;

SELECT @Msg AS Message, @ID AS BorrowerID;


 */