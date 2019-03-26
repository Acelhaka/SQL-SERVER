/************************************************************
*Amarilda Celhaka											*
*Assignment #6												*
*Chapter 6: How to code subqueries							*
*Due Date: 3/8/2019											*
*Problems: 1, 2, 4, 6, 9 (page 212-213)						*
*************************************************************/


--Problem #1--
--Write the same query below using subqueries instead of JOIN--
SELECT DISTINCT VendorName
FROM Vendors JOIN Invoices
	ON Vendors.VendorID = Invoices.VendorID
ORDER by VendorName;



SELECT DISTINCT VendorName
FROM Vendors
WHERE VendorID IN 
	(SELECT VendorID
	FROM Invoices)
ORDER by VendorName;



--Problem #2--
--Which invoices have a PaymentTotal that is a greater than the average PaymentTotal for all paid
--invoices? Return the InvoiceNumber and InvoiceTotal for each invoice

SELECT InvoiceNumber
	,InvoiceTotal
FROM Invoices
WHERE InvoiceTotal > (
		SELECT AVG(PaymentTotal)
		FROM Invoices
		WHERE PaymentTotal <> 0
		);



--Problem #4--
--Return AccountNo and AccountDescription from GLAccounts. The result should have 
--one row from each account number that has never been used. Used a correlated subquery 
--introduced with the NOT EXISTS. Sort by AccountNo--



SELECT AccountNo, AccountDescription
FROM GLAccounts --AS Gla_Main
WHERE EXISTS
	(SELECT *
	FROM  InvoiceLineItems -- GLAccounts AS Gla_Sub
	WHERE NOT InvoiceLineItems.AccountNo = GLAccounts.AccountNo --Gla_Sub.AccountNo = Gla_Main.AccountNo
	)
ORDER BY AccountNo;



--Problem #6--
--Write a select statement that returns a single value that represents the sum of the largest unpaid 
--invoices submitted by each vendor. Use a derived table that returns MAX(Invoice Total) grouped 
--by VendorId, filtering for invoices with a balance due.--



SELECT SUM(InvoiceMax) AS SumOfMaximums
FROM (
	SELECT VendorID
		,MAX(InvoiceTotal) AS InvoiceMax
	FROM Invoices
	WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
	GROUP BY VendorID
	) AS MaxInvoice;



/**
SELECT I_Sub.VendorID, 
	SUM(I_Sub.InvoiceTotal) AS SumOfInvoices
FROM Invoices AS I_Sub
WHERE InvoiceTotal - PaymentTotal > 0
GROUP BY I_Sub.VendorID;
**/


/**SELECT VendorID, MAX(SumOfInvoices)
FROM Invoices
WHERE SumOfInvoices 
	SELECT SUM(InvoiceTotal) AS SumOfInvoices
	FROM Invoices
	WHERE InvoiceTotal - PaymentTotal > 0
GROUP BY VendorID;
**/

--Problem #9--




WITH MaxInvoice
AS (
	SELECT VendorID
		,MAX(InvoiceTotal) AS InvoiceMax
	FROM Invoices
	WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
	GROUP BY VendorID
	)
SELECT SUM(InvoiceMax) AS SumOfMaximums
FROM MaxInvoice;


/**

WITH Summary AS
( 
	SELECT VendorID, SUM(InvoiceTotal) AS SumOfInvoices
	FROM Invoices
	WHERE InvoiceTotal - PaymentTotal > 0
	GROUP BY VendorID
),
MaxUnpaid AS 
(
	SELECT VendorID, MAX(SumOfInvoices) AS SumOfInvoices
	FROM Summary
	GROUP BY VendorID
)

SELECT Summary.VendorID, MaxUnpaid.SumOfInvoices
FROM Summary JOIN MaxUnpaid
	ON --Summary.VendorID = MaxUnpaid.VendorID AND 
	Summary.SumOfInvoices = MaxUnpaid.SumOfInvoices;


