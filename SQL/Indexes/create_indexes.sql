-- Foreign Keys

CREATE INDEX FK_Loans_BookID ON Loans (BookID);
CREATE INDEX FK_Loans_BorrowerID ON Loans (BorrowerID);

-- Columns often in WHERE Clauses

CREATE INDEX IX_Loans_Date_Borrowed ON Loans (Date_Borrowed); 
CREATE INDEX IX_Loans_Date_Returned ON Loans (Date_Returned);

-- Columns in GROUP BY / ORDER BY

CREATE INDEX IX_Books_Author ON Books (Author); 
CREATE INDEX IX_Books_Genre ON Books (Genre); 

-- High cardinality or selectivity columns ( many unique values )

CREATE INDEX IX_Books_ISBN ON Books (ISBN); 
CREATE INDEX IX_Borrowers_Email ON Borrowers (Email); 

