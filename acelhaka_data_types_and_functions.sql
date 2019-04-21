/************************************************************
*Amarilda Celhaka											
*Assignment #8											
*Chapter 8: How to work with data types
*Chapter 9: How to use functions
*Due Date: 4/1/2019							
*************************************************************/

--------Chapter 8----------


/*Problem #1
Write a select statement that returns four columns based on the InvoiceTotal
column of the Invoices table: */


--Select statement returns 5 columns including the original column we are casting from 
SELECT InvoiceTotal,
	CAST(InvoiceTotal AS decimal(10,2)) AS DecimalIT,
	CAST(InvoiceTotal AS varchar) AS VarCharIT,
	CONVERT(varchar, InvoiceTotal, 0) AS ConvertVarCharIT,  --0 default value for 2 digits to the right of the decimal point
	CONVERT(varchar, InvoiceTotal, 1) AS ConvertVarCharITStyle1  --style 1 puts a comma to the left of the variable
FROM Invoices;




/**Problem #2
Write a select statement that returns four columns based on the invoiceDate column of the Invoices table*/

SELECT InvoiceDate,
	CAST(InvoiceDate AS varchar) AS VarCharIDate,
	CONVERT(varchar, InvoiceDate, 1) AS ConvertIDateStyle1,
	CONVERT(varchar, InvoiceDate, 10) AS ConvertIDateStyle10,
	CAST(InvoiceDate AS real) AS RealIDate
FROM Invoices;





----------Chapter 9--------------
 
 /**Problem #1
Write SELECT statement that returns two columns based on the Vendor table:
first columns "Contact": contact last name eg. Celhaka, A.
second column "Phone": vendorPhone columns without area code
only for vendors in 559 are code
sort by first and then last name **/


SELECT VendorContactLName + ',' + LEFT(VendorContactFName, 1) + '.' AS Contact,
	   RIGHT(VendorPhone, 8) AS PHONE	   
FROM Vendors
WHERE SUBSTRING(VendorPhone, 2,3) = 559
ORDER BY VendorContactFName, VendorContactLName;




/**Problem #2
Write a select statement that returns the Invoice Number and balance due for every invoice
with a non-zero balance and
InvoiceDueDate that is less than 30 days from today**/

SELECT *
FROM Invoices;



--I am considering year 2016 since there is no balance due close to the 2019 year (today's date)
SELECT InvoiceNumber, (InvoiceTotal - PaymentTotal) AS BalanceDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal != 0 AND
	 MONTH(InvoiceDueDate) = 3  AND
	 YEAR(InvoiceDueDate) = 2016;




/**Problem #4 
Write a summary query WITH CUBE that returns:
1-LineItemSum (sum of invoice LineItemAmount) grouped by 
2-Account an alias of AccountDescription
3-State an alias for VendorState.
Use the CASE and GROUPING function to substitute "ALL" for the summary rows with NULL values**/

--Columns  AccountNo and InvoiceLineItemAmount
SELECT *
FROM InvoiceLineItems;

--Columns AccNo and AccountDescription
SELECT *
FROM GLAccounts;

--Columns VendorState and DefaultAccountNo
Select *
FROM Vendors;


--Grouping by AccountNo
/**
SELECT AccountNo, SUM(InvoiceLineItemAmount) AS TotalAmountforAccount, COUNT(*) AS QTYAmount
FROM InvoiceLineItems
GROUP BY AccountNo WITH CUBE;**/


--used inner join for 3 tables to get AccountDescription part of GLAccount DB and State part of Vendor DB

SELECT 
	
	CASE 
		WHEN GROUPING(VendorState) = 1 THEN 'ALL'
		ELSE VendorState
		END AS State,
	CASE 
		WHEN GROUPING (AccountDescription) = 1 THEN 'ALL'
		ELSE AccountDescription
		END AS Account,
		SUM(InvoiceLineItemAmount) AS TotalAmountforAccount,
		COUNT (*) AS QTYAmount
FROM InvoiceLineItems
	JOIN GLAccounts ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo  
	JOIN Vendors ON InvoiceLineItems.AccountNo = Vendors.DefaultAccountNo
	GROUP BY VendorState, AccountDescription WITH ROLLUP;