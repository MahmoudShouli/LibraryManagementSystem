
--  Retrieve all books borrowed by a specific borrower --

DECLARE @BorrowerID INT = 162;

SELECT L.BookID, B.Title,  L.Date_Borrowed, L.Due_Date, L.Date_Returned
FROM Loans L
JOIN Books B ON L.BookID = B.BookID
WHERE L.BorrowerID = @BorrowerID;