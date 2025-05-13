DROP PROCEDURE IF EXISTS sp_BorrowedBooksReport
GO

CREATE PROCEDURE sp_BorrowedBooksReport
	@StartDate DATE, 
	@EndDate DATE
AS 
BEGIN
	SELECT BookID, First_Name + ' ' + Last_Name AS [Borrower Name], Date_Borrowed AS [Borrowing Date]
	FROM Loans
	JOIN Borrowers
	ON Loans.BorrowerID = Borrowers.BorrowerID
	WHERE Date_Borrowed BETWEEN @StartDate AND @EndDate
	ORDER BY Date_Borrowed
END

/* usage

EXEC sp_BorrowedBooksReport @StartDate = '2024-02-26', @EndDate = '2024-06-26'

 */