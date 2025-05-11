# Library Management System

This project is for a library that wishes to convert from traditional file-keeping to a robust digital system. It contains SQL queries for many operations using MS SQL.

## Schema

You can find the ERD in the Design folder which was created using [dbdiagram](https://dbdiagram.io/home).

It includes three entities : Books, Borrowers, and Loans.

The Books and Borrowers have a many-many relationship, hence the need for the middle junction table (Loans).

The DDL file that creates the tables and the constraints was generated from [dbdiagram](https://dbdiagram.io/home) as well.

## Seeds

[Mockaroo](https://www.mockaroo.com/) was used to generate 1000 rows for each table to populate the database with fake test data.




