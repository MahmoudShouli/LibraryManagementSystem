WITH BorrowersWithAgeGroup AS (
	SELECT 
    BorrowerID,
    CASE
      WHEN DATEDIFF(YEAR, Date_of_Birth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
      WHEN DATEDIFF(YEAR, Date_of_Birth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
      WHEN DATEDIFF(YEAR, Date_of_Birth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
      WHEN DATEDIFF(YEAR, Date_of_Birth, GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
      WHEN DATEDIFF(YEAR, Date_of_Birth, GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
      WHEN DATEDIFF(YEAR, Date_of_Birth, GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
      WHEN DATEDIFF(YEAR, Date_of_Birth, GETDATE()) BETWEEN 61 AND 70 THEN '61-70'
      ELSE '71+'
    END AS AgeGroup
  FROM Borrowers
),
GenreCounts AS (
	SELECT Genre, AgeGroup, COUNT(*) AS BorrowCount
	FROM BorrowersWithAgeGroup
	JOIN Loans ON Loans.BorrowerID = BorrowersWithAgeGroup.BorrowerID
	JOIN Books ON Loans.BookID = Books.BookID
	GROUP BY AgeGroup, Genre
),
RankedGenres AS (
	SELECT *,
		DENSE_RANK() OVER (PARTITION BY AgeGroup ORDER BY BorrowCount DESC) AS [Genre Rank]
	FROM GenreCounts
)
SELECT AgeGroup, Genre AS [Top Genre], BorrowCount
FROM RankedGenres
WHERE [Genre Rank] = 1
ORDER BY AgeGroup
