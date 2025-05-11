```mermaid
erDiagram
    Books {
        BookID int PK
        Title string
        Author string
        ISBN string
        Published_Date date
        Genre string
        Shelf_Location string
        Current_Status string
    }
    Borrowers {
        BorrowerID int PK
        First_Name string
        Last_Name string
        Email string
        Date_of_Birth date
        Membership_Date date
    }
    Loans {
        LoanID int PK
        BookID int FK
        BorrowerID int FK
        Date_Borrowed date
        Due_Date date
        Date_Returned date
    }
    Books ||--o{ Loans : "has loans"
    Borrowers ||--o{ Loans : "makes loans"
