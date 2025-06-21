#  Library Management System - SQL Project

This project demonstrates how a Library Management System's relational database can be designed and analyzed using **MySQL**. It covers core database concepts such as relationships, joins, filtering, and aggregation.

---

##  Tools & Technologies

- MySQL
- SQL (DDL & DML)
- Workbench (for ER diagrams)
- GitHub (for version control & collaboration)

---

##  Database Schema

The system includes the following main tables:

- `tbl_publisher`: Stores publisher details
- `tbl_book`: Stores book info and publisher relationship
- `tbl_book_authors`: Stores authors of books
- `tbl_library_branch`: Stores library branches
- `tbl_book_copies`: Tracks number of copies in each branch
- `tbl_borrower`: Contains borrower details
- `tbl_book_loans`: Stores loan transactions

 ER Diagram:  
![ER-Diagram](https://github.com/user-attachments/assets/241925af-962f-4547-94ed-2b8bf19d04c3)

---

##  Sample Queries & Use Cases

> Below are a few business questions addressed using SQL queries:

1. **How many copies of 'The Lost Tribe' exist in 'Sharpstown' branch?**
2. **Retrieve borrowers who haven’t checked out any books**
3. **Find books authored by ‘Stephen King’ and how many copies are at ‘Central’ branch**
4. **Which borrowers have checked out more than 5 books?**
5. **Loan details for books due on a specific date from a given branch**

 All queries are available in:  
` library_management_project.sql`

---

##  Key Skills Demonstrated

- Relational Database Design
- Foreign Key Constraints
- JOINs, GROUP BY, HAVING, Filtering
- Real-life data modeling and business logic in SQL
- Aggregation and multi-table analysis

---


---

##  How to Use

1. Clone or download the repo
2. Run the `.sql` file in MySQL Workbench or your SQL tool
3. Execute queries to explore different insights

---

##  Contact

For queries or collaborations:  
sujithkandula866@gmail.com
https://www.linkedin.com/in/sujithkandula
---


