CREATE TABLE [Books] (
  [BookID] int IDENTITY(1,1) PRIMARY KEY,
  [Title] nvarchar(255),
  [Author] nvarchar(255),
  [ISBN] nvarchar(255),
  [Published_Date] date,
  [Genre] nvarchar(255),
  [Shelf_Location] nvarchar(255),
  [Current_Status] nvarchar(255) DEFAULT 'Available'
)
GO

CREATE TABLE [Borrowers] (
  [BorrowerID] int IDENTITY(1,1) PRIMARY KEY,
  [First_Name] nvarchar(255),
  [Last_Name] nvarchar(255),
  [Email] nvarchar(255),
  [Date_of_Birth] date,
  [Membership_Date] date
)
GO

CREATE TABLE [Loans] (
  [LoanID] int IDENTITY(1,1) PRIMARY KEY,
  [BookID] int,
  [BorrowerID] int,
  [Date_Borrowed] date,
  [Due_Date] date,
  [Date_Returned] date
)
GO

ALTER TABLE [Loans]
ADD CONSTRAINT FK_Loans_BookID
FOREIGN KEY ([BookID]) 
REFERENCES [Books] ([BookID]) 
ON DELETE CASCADE;
GO

ALTER TABLE [Loans]
ADD CONSTRAINT FK_Loans_BorrowerID
FOREIGN KEY ([BorrowerID]) 
REFERENCES [Borrowers] ([BorrowerID]) 
ON DELETE CASCADE;
GO

