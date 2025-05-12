-- Identify the most popular genre for a given month --

DECLARE @Month INT = 3;

SELECT TOP 1 B.Genre, COUNT(*) AS [Number of books],
	RANK() OVER (ORDER BY COUNT(*) DESC) AS [Genre rank]
FROM Loans L
JOIN Books B ON L.BookID = B.BookID
WHERE MONTH(Date_Borrowed) = @Month
GROUP BY B.Genre;


