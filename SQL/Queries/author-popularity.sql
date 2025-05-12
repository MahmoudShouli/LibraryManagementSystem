SELECT Author, dbo.fn_BookBorrowingFrequency(BookID) AS [Borrowing Count],
	DENSE_RANK() OVER (ORDER BY dbo.fn_BookBorrowingFrequency(BookID) DESC) AS [Author rank]
FROM Books;
