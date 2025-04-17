use library;

-- 1.How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

select sum(book_copies_No_Of_Copies),b.book_title from book_copies as bc
join library_branch as lb
on lb.library_branch_BranchID = bc.book_copies_BranchID
join books as b
on b.book_BookID = bc.book_copies_BookID
where b.book_Title = "The Lost Tribe"  and lb.library_branch_BranchName = "Sharpstown"
group by b.book_title;


-- 2.How many copies of the book titled "The Lost Tribe" are owned by each library branch?
select sum(book_copies_No_Of_Copies),lb.library_branch_BranchName,b.book_Title from book_copies as bc
join library_branch as lb
on lb.library_branch_BranchID = bc.book_copies_BranchID
join books as b
on b.book_BookID = bc.book_copies_BookID
where b.book_title = "The Lost Tribe"  
group by lb.library_branch_BranchName;


-- 3.Retrieve the names of all borrowers who do not have any books checked out.

select bo.borrower_CardNo,bo.borrower_BorrowerName from borrower as bo
left join book_loans as bl
on bo.borrower_cardno = bl.book_loans_CardNo
where bl.book_loans_DateOut is null;


-- 4.For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 

select b.book_title ,bo.borrower_BorrowerName,bo.borrower_BorrowerAddress from book_loans as bl 
join books as b
on b.book_BookID = bl.book_loans_BookID
join borrower as bo
on bo.borrower_CardNo = bl.book_loans_CardNo
join library_branch as lb
on lb.library_branch_BranchID = bl.book_loans_BranchID
where lb.library_branch_BranchName = "Sharpstown" and bl.book_loans_DueDate = "2018-02-03";


-- 5.For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

select lb.library_branch_Branchname ,count(book_loans_loansID) as total_copies  from library_branch as lb
join book_copies as bc
on lb.library_branch_BranchID = bc.book_copies_BranchID
join book_loans as bl
on bl.book_loans_BranchID = lb.library_branch_Branchid
group by lb.library_branch_Branchname;


-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

select bo.borrower_BorrowerName , bo.borrower_BorrowerAddress ,count(book_loans_loansID) from borrower as bo
left join book_loans as bl
on bo.borrower_CardNo =  bl.book_loans_CardNo
group by bo.borrower_BorrowerName , bo.borrower_BorrowerAddress
having count(book_loans_loansID)>5;


-- 7.For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

select b.book_title,count(bc.book_copies_copiesID) from book_copies as bc
join library_branch as lb
on bc.book_copies_BranchID = lb.library_branch_BranchID
join books as b
on bc.book_copies_BookID = b.book_BookID
join book_authors as ba
on ba.book_authors_BookID = b.book_BookID
where lb.library_branch_BranchName = "Central" and ba.book_authors_AuthorName = "Stephen King"
group by b.book_title , lb.library_branch_BranchName , ba.book_authors_AuthorName;