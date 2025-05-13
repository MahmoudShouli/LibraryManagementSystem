-- Rank borrowers based on borrowing frequency --

SELECT BorrowerID, Count(*) AS [Number of books], 
	DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS [Borrower rank]
FROM Loans
GROUP BY BorrowerID;