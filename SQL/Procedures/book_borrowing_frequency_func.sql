DROP FUNCTION IF EXISTS fn_BookBorrowingFrequency
GO

CREATE FUNCTION fn_BookBorrowingFrequency (
	@BookID INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Borrowing_Count INT

	SELECT @Borrowing_Count = COUNT(*) 
	FROM Loans
	WHERE BookID = @BookID

	RETURN @Borrowing_Count
END

/* usage :

SELECT BookID, dbo.fn_BookBorrowingFrequency(BookID) AS [Borrowing Count]
FROM Books

*/