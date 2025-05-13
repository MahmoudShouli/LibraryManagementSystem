# Library Management System

This project is for a library that wishes to convert from traditional file-keeping to a robust digital system. It contains SQL queries for many operations using MS SQL.

## Schema

You can find the ERD in the Design folder which was created using [dbdiagram](https://dbdiagram.io/home).

It includes three entities : Books, Borrowers, and Loans.

The Books and Borrowers have a many-many relationship, hence the need for the middle junction table (Loans).

The DDL file that creates the tables and the constraints was generated from [dbdiagram](https://dbdiagram.io/home) as well.

## Seeds

[Mockaroo](https://www.mockaroo.com/) was used to generate 1000 rows for each table to populate the database with fake test data.

## Complex Queries and Procedures


- List of Borrowed Books:
  - This is a simple query that returned borrowed books that belong to a specific borrower.
  - The borrower ID is given at the start using a local variable.
  - The Loans table is joined with the Books table just to get the book title for more clarity.




- Active Borrowers with CTEs:
  - This query retrieves borrowers who've borrowed 2 or more books but haven't returned any.
  - The first CTE (BorrowersThatReturnedAny) returns the borrowers that returned a book.
  - The second CTE (BorrowersThatReturnedNone) first excludes borrowers that returned any book.
  - It groups by the BorrowerID so that we can get hold of the count of books each borrower has.
  - Finally, it selects only those with two or more books.




- Borrowing Frequency using Window Functions:
  - This query ranks borrowers based on borrowing frequency.
  - Borrowers with most loans will have the highest rank.
  - It groups the table by borrowerID then applies the *COUNT* to calculate how many books that borrower has.
  - *DENSE_RANK()* is applied to prevent gaps and provide contiguous ranks.




- Popular Genre Analysis using Joins and Window Functions:
  - This query returns the most popular genre for a given month.
  - The month is a local variable.
  - Loans is joined with Books to get the book genre.
  - The *WHERE* filters the rows to get only books borrowed with the given month.
  - The result is grouped by genres so we can get hold of the count of books per genre.
  - *RANK()* is applied to rank genres, the genre with the highest number of books gets rank 1.
  - Finally, *TOP* is applied to only retrieve the most popular genre.




- Stored Procedure - Add New Borrowers:
  - This procedure inserts a new borrower with the given arguments to the borrowers table.
  - It checks if the given email already exists, if it does, it returns an error message.
  - If it doesn't, it inserts.
  - *SCOPE_IDENTITY()* is used to return the last identity value in the current scope, which is the new borrower id in our case.




- Database Function - Calculate Overdue Fees:
  - This function computes overdue fees for a given loan.
  - It accepts a loan ID and returns a calculated fee for that loan.
  - First, it retrieves the due date and returned date for the loan.
  - Second, it does multiple checks:
    - if the date returned is null, meaning the book hasn't been returned yet, then the returned det is set to today's date, i.e. the fee will be ongoing.
    - if the date returned is before or equal to the due date, then no fee will be given.
    - else the *DATEDIFF* is used to compute the difference in days.
    - \$1 for first 30 days, then \$2 after using an algorithm.




- Database Function -  Book Borrowing Frequency:
  - This function computes the frequency of borrowing for a given book.
  - It accepts a book ID and returns the number of times that book has been borrowed.
  - It does a simple query when it selects the *COUNT* of times that book ID is found in the Loans table.




- Overdue Analysis:
  - This query lists all books overdue by more than 30 days with their associated borrowers.
  - Loans is joined with Borrowers to get the borrower name.
  - the fn_CalculateOverdueFees function is reused here as loans with over \$30 fee will definitely be overdue for more than 30 days.




- Author Popularity using Aggregation:
  - This query ranks authors by the borrowing frequency of their books.
  - The books table is grouped by author to group each author with their books.
  - The *SUM* aggregate is used along with the fn_BookBorrowingFrequency to sum each author's total borrowing count.
  - Rank using *DENSE_RANK* by the total sum.




- Genre Preference by Age using Group By:
  - This query fetches the most popular book genre amongst different age groups.
  - First, the BorrowersWithAgeGroup CTE represents each borrower with what age group they belong to.
  - Second, the GenreCounts CTE calculates the count of each genre per age group, meaning how many times a book with that genre was borrowed from borrowers in that age group.
    - The BorrowersWithAgeGroup is joined with Loans to get the BookID that each borrower borrowed.
    - Then the joined table is joined with Books to get the book genre.
  - Third, the RankedGenres CTE breaks the table into partitions, each partition is the age group with all genres and counts.
  - Each partition is ranked based on the count.
  - Finally, we select records with the highest rank to get the most preferred genre for each group.




- Stored Procedure - Borrowed Books Report:
  - This procedure retrieves all books borrowed within the given range, with details like borrower name and borrowing date.
  - It accepts the start date and end date as parameters.
  - *BETWEEN* is used with the *WHERE* to filter borrowing dates that fall in the expected range.




- Trigger Implementation:
  - This trigger logs an entry into a separate AuditLog table whenever a book's status changes from 'Available' to 'Borrowed' or vice versa.
  - It is a DML trigger that fires upon updates to the Books table, specifically the Current_Status column.
  - It uses the *inserted* database to get the values of the row that was updated and triggered the trigger.




- SQL Stored Procedure with Temp Table:
  - This procedure retrieves all borrowers who have overdue books.
  - It stores borrowers with overdue books in a temporary table (OverdueBorrowers).
  - It then joins the temporary table with Loans to get the overdue books for those borrowers.