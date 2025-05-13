DROP PROCEDURE IF EXISTS sp_BorrowersOverdue
    GO

CREATE PROCEDURE sp_BorrowersOverdue
AS
BEGIN
	SELECT BorrowerID 
	INTO #OverdueBorrowers
	FROM Loans
	WHERE Date_Returned IS NULL OR Date_Returned > Due_Date

	SELECT #OverdueBorrowers.BorrowerID, Loans.BookID
	FROM #OverdueBorrowers
	JOIN Loans
	ON Loans.BorrowerID = #OverdueBorrowers.BorrowerID
	WHERE Date_Returned IS NULL OR Date_Returned > Due_Date

END

/* usage

EXEC sp_BorrowersOverdue

 */