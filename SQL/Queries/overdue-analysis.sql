SELECT L.BookID, L.BorrowerID, B.First_Name, B.Last_Name
FROM Loans L
JOIN Borrowers B
ON L.BorrowerID = B.BorrowerID
WHERE dbo.fn_CalculateOverdueFees(LoanID) > 30
ORDER BY L.BookID;
