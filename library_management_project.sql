create database library_management_project;
use library_management_project;

CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(150) PRIMARY KEY,
    publisher_PublisherAddress VARCHAR(500),
    publisher_PublisherPhone VARCHAR(15)
);

CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(150),
    borrower_BorrowerAddress VARCHAR(400),
    borrower_BorrowerPhone VARCHAR(15)
);

CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(400),
    book_PublisherName VARCHAR(250),
    FOREIGN KEY (book_PublisherName)
        REFERENCES tbl_publisher (publisher_PublisherName)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(150),
    FOREIGN KEY (book_authors_BookID)
        REFERENCES tbl_book (book_BookID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(150),
    library_branch_BranchAddress VARCHAR(500)
);

CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID)
        REFERENCES tbl_book (book_BookID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_copies_BranchID)
        REFERENCES tbl_library_branch (library_branch_BranchID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID)
        REFERENCES tbl_book (book_BookID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_loans_BranchID)
        REFERENCES tbl_library_branch (library_branch_BranchID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_loans_CardNo)
        REFERENCES tbl_borrower (borrower_CardNo)
        ON DELETE CASCADE ON UPDATE CASCADE
);


-- 1.How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
SELECT 
    b.book_Title, COUNT(*) AS 'copies of the book'
FROM
    tbl_book b
    
         JOIN
    tbl_book_copies b_c ON b.book_BookID = b_c.book_copies_BookID
         JOIN
    tbl_library_branch l_b ON l_b.library_branch_BranchID = b_c.book_copies_BranchID
WHERE 
    b.book_Title = 'The Lost Tribe'
        AND l_b.library_branch_BranchName = 'Sharpstown'
GROUP BY B.BOOK_TITLE;

-- 2.How many copies of the book titled "The Lost Tribe" are owned by each library branch?
SELECT 
    l_b.library_branch_BranchName,
    COUNT(*) AS 'copies of the book'
FROM
    tbl_book b
        LEFT JOIN
    tbl_book_copies b_c ON b.book_BookID = b_c.book_copies_BookID
        LEFT JOIN
    tbl_library_branch l_b ON l_b.library_branch_BranchID = b_c.book_copies_BranchID
WHERE
    b.book_Title = 'The Lost Tribe'
GROUP BY l_b.library_branch_BranchName;

-- 3.Retrieve the names of all borrowers who do not have any books checked out.
SELECT 
    b.borrower_BorrowerName
FROM
    tbl_borrower b
        LEFT JOIN
    tbl_book_loans b_l ON b.borrower_CardNo = b_l.book_loans_CardNo
WHERE
    b_l.book_loans_CardNo IS NULL;

-- 4.For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 
SELECT 
    b.book_Title,
    bor.borrower_BorrowerName,
    bor.borrower_BorrowerAddress
FROM
    tbl_book_loans b_l
        LEFT JOIN
    tbl_borrower bor ON bor.borrower_CardNo = b_l.book_loans_CardNo
        LEFT JOIN
    tbl_book b ON b.book_BookID = b_l.book_loans_BookID
        LEFT JOIN
    tbl_library_branch l_b ON l_b.library_branch_BranchID = b_l.book_loans_BranchID
WHERE
    l_b.library_branch_BranchName = 'Sharpstown'
        AND b_l.book_loans_DueDate = '2018-02-03';

-- 5.For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
SELECT 
    l_b.library_branch_BranchName,
    COUNT(*) AS 'total no of books'
FROM
    tbl_library_branch l_b
        LEFT JOIN
    tbl_book_loans b_l ON l_b.library_branch_BranchID = b_l.book_loans_BranchID
GROUP BY l_b.library_branch_BranchName;

-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
SELECT 
    bor.borrower_BorrowerName,
    bor.borrower_BorrowerAddress,
    COUNT(*) 'number od books checked out'
FROM
    tbl_borrower bor
        LEFT JOIN
    tbl_book_loans b_l ON bor.borrower_CardNo = b_l.book_loans_CardNo
GROUP BY bor.borrower_CardNo
HAVING COUNT(*) > 5;

-- 7.For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
SELECT 
    b.book_Title, b_c.book_copies_No_Of_Copies
FROM
    tbl_book_authors b_a
        LEFT JOIN
    tbl_book b ON b.book_BookID = b_a.book_authors_BookID
        LEFT JOIN
    tbl_book_copies b_c ON b.book_BookID = b_c.book_copies_BookID
        LEFT JOIN
    tbl_library_branch l_b ON l_b.library_branch_BranchID = b_c.book_copies_BranchID
WHERE
    b_a.book_authors_AuthorName = 'Stephen King'
        AND l_b.library_branch_BranchName = 'Central';




