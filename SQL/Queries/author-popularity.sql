SELECT Author, SUM(dbo.fn_BookBorrowingFrequency(BookID)) AS [Total Borrwing Count],
	DENSE_RANK () OVER (ORDER BY SUM(dbo.fn_BookBorrowingFrequency(BookID)) DESC) AS [Author rank]
FROM Books
GROUP BY Author


