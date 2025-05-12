DROP FUNCTION IF EXISTS fn_CalculateOverdueFees
GO

CREATE FUNCTION fn_CalculateOverdueFees (
	@LoanID INT
)
RETURNS INT 
AS
BEGIN
	DECLARE @Due_Date DATE;
	DECLARE @Date_Returned DATE;
	DECLARE @Fee INT;


	SELECT @Due_Date = Due_Date, @Date_Returned = Date_Returned
	FROM Loans
	WHERE LoanID = @LoanID;

	-- still not returned
	IF @Date_Returned IS NULL
		SET @Date_Returned = GETDATE();

	-- no overdue
	IF @Date_Returned <= @Due_Date
		SET @Fee = 0;

	-- overdue
	ELSE
	BEGIN
		DECLARE @Overdue_Days INT = DATEDIFF(day, @Due_Date, @Date_Returned);
		IF @Overdue_Days <= 30
			SET @Fee = @Overdue_Days;
		ELSE
			-- algorithm for overdue by more than 30 days
			SET @Fee = 30 + ((@Overdue_Days - 30) * 2);
	END
		
	RETURN @Fee;
END


/* usage :

SELECT LoanID, dbo.fn_fn_CalculateOverdueFees(LoanID) AS [Overdue fee]
FROM Loans

*/