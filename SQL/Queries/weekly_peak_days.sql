WITH DaysRanked AS (
	SELECT DATENAME(Weekday, Date_Borrowed) AS [Week day], COUNT(*) AS count_of_issues,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS [Rank]
	FROM Loans
	GROUP BY DATENAME(Weekday, Date_Borrowed)
)
SELECT TOP 3 [Week day], FORMAT(count_of_issues * 100.0 / SUM(count_of_issues) OVER (), 'N2') + '%' AS Percentage, [Rank]
FROM DaysRanked
