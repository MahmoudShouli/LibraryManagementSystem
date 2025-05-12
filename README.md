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
  


