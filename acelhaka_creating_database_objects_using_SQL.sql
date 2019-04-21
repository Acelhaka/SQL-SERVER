/***************************************************************
*  Amarilda Celhaka	
*  Assignment #9
*  How to create a database and its tables with SQL statements
*  Chapter 11
***************************************************************/


--Problem #1
--Create a new database named Membership

CREATE DATABASE Membership

--Problem #2
--Design the Membership database



CREATE TABLE Individuals
(IndividualID	INT		NOT NULL IDENTITY PRIMARY KEY,
FirstName		VARCHAR NOT NULL,
LastName		VARCHAR NOT NULL,
Adress			VARCHAR NULL,
Phone			VARCHAR NOT NULL);


--Checking if the table was created
Select *
FROM Individuals;

 CREATE TABLE GroupMembership
(GroupID		INT NOT NULL IDENTITY PRIMARY KEY,
 IndividualID	INT REFERENCES Individuals(IndividualID));

--Checking if the table was created
Select *
FROM GroupMembership;


CREATE TABLE Groups
(GroupID		INT REFERENCES GroupMembership(GroupID),
GroupName		VARCHAR		NOT NULL,
Dues			MONEY		NOT NULL DEFAULT 0);


--Checking if the table was created
Select *
FROM Groups;


--Problem #3
/*Write a create INDEX to create a clustered index on the groupID column and a nonclustered index
on the indiviudalID column*/


CREATE CLUSTERED INDEX IX_GroupID
ON GroupMembership(GroupID)

CREATE INDEX IX__IndividualID
ON GroupMembership(IndividualID);

--Problem #4
--Write an ALTER TABLE statements that adds a new column, DuesPaid, to the individual table
--data type: bit, no null values, assign Boolean value of false. 

ALTER TABLE Individuals
ADD DuesPaid BIT NOT NULL DEFAULT 0;




--Problem #5
-- Write an ALTER table that adds two check constraints to the
--Invoices table. The first should allow: 
--(1) PaymentDate (NULL only if PaymentTotal = 0) (NOT NULL if PaymentTotal > 0)
--(2) sum of PaymentTotal + CreditTotal < InvoiceTotal




ALTER TABLE Invoices
ADD CHECK ((PaymentDate IS NULL AND PaymentTotal = 0) OR
(PaymentDate IS NOT NULL AND PaymentTotal > 0)),
CHECK ((PaymentTotal + CreditTotal) <= InvoiceTotal);


SELECT *
FROM Invoices;





--Problem #6
--Delete the GroupMembership table
--Write a create Table statement that creates the table
--with a unique constraint that prevents an individual from being a member in the same group twice.

DROP TABLE GroupMembership;

CREATE Table GroupMembership
(GroupID int REFERENCES Groups(GroupID),
IndividualID int REFERENCES Individuals(IndividualID),
UNIQUE(GroupID, IndividualID));