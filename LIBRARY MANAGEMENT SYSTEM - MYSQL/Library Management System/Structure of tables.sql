create database library;

use library;

create table if not exists borrower(
borrower_CardNo tinyint primary key,
borrower_BorrowerName varchar(50),
borrower_BorrowerAddress varchar(50),
borrower_BorrowerPhone varchar(30)
);

create table if not exists publisher(
publisher_PublisherName  varchar(50) primary key ,
publisher_PublisherAddress varchar(100),
publisher_PublisherPhone varchar(20)
);

create table if not exists library_branch(
library_branch_BranchID INT auto_increment primary key ,
library_branch_BranchName varchar(20),
library_branch_BranchAddress varchar(20)
);

create table if not exists books(
book_BookID tinyint primary key,
book_Title varchar(60),
book_PublisherName varchar(50),
FOREIGN KEY (book_PublisherName) REFERENCES publisher(publisher_PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists book_authors(
book_author_AuthorID int auto_increment primary key,
book_authors_BookID tinyint,
book_authors_AuthorName varchar(20),
FOREIGN KEY (book_authors_BookID) REFERENCES books(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists book_copies(
book_copies_copiesID int auto_increment primary key,
book_copies_BookID tinyint,
book_copies_BranchID int,
book_copies_No_Of_Copies tinyint,
FOREIGN KEY (book_copies_BookID) REFERENCES books(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (book_copies_BranchID) REFERENCES library_branch(library_branch_BranchID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists book_loans(
book_loans_loansID int auto_increment primary key,
book_loans_BookID tinyint,
book_loans_BranchID int,
book_loans_CardNo tinyint,
book_loans_DateOut varchar(20),
book_loans_DueDate varchar(20),
FOREIGN KEY (book_loans_BookID) REFERENCES books(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (book_loans_BranchID) REFERENCES library_branch(library_branch_BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (book_loans_CardNo) REFERENCES borrower(borrower_CardNo) ON UPDATE CASCADE ON DELETE CASCADE
);





