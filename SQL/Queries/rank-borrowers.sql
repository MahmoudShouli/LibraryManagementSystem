-- Rank borrowers based on borrowing frequency --

SELECT BorrowerID, Count(*) AS NumberOfBooks, 
	DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS BorrowerRank
FROM Loans
GROUP BY BorrowerID;