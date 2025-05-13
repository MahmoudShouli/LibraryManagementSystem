-- Identify borrowers who've borrowed 2 or more books but haven't returned any --

WITH BorrowersThatReturnedAny AS (
	SELECT DISTINCT BorrowerID
	FROM Loans
	WHERE Date_Returned IS NOT NULL
),
BorrowersThatReturnedNone AS (
	SELECT BorrowerID, COUNT(*) AS NumberOfBooks
	FROM Loans
	WHERE BorrowerID NOT IN (SELECT * FROM BorrowersThatReturnedAny)
	GROUP BY BorrowerID
	HAVING COUNT(*) >= 2
)
SELECT * FROM BorrowersThatReturnedNone;
