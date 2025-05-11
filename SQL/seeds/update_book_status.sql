WITH BorrowedBooks(BookID) AS (
	SELECT DISTINCT BookID
	FROM Loans
	WHERE Date_Returned IS NULL
)
UPDATE Books
SET Current_Status = 'Borrowed'
WHERE BookID IN (
	SELECT * FROM BorrowedBooks
);

