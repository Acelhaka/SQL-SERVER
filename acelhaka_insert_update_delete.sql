/************************************************************
*Amarilda Celhaka											*
*Assignment #7												*
*Chapter 7: How to insert, update and delete data			*
*Due Date: 3/25/2019										*
*************************************************************/


/*Problem #1
Write a SELECT INTO statement to create two tables, named VendorCopy and InvoiceCopy
that are complete copies of the Vendors and Invoices tables **/


SELECT *
INTO InvoiceCopy
FROM Invoices;



SELECT *
INTO VendorCopy
FROM Vendors;



--To check the inserted columns run the following query: 

/**
SELECT *
FROM InvoiceCopy;

SELECT *
FROM InvoiceCopy;

SELECT *
FROM VendorCopy;
**/






/**Problem #2
Write an INSERT Statement that adds a row to the InvoiceCopy table**/


 INSERT INTO InvoiceCopy	
	(VendorID, InvoiceTotal, TermsID, InvoiceNumber, PaymentTotal, InvoiceDueDate,  InvoiceDate, CreditTotal, PaymentDate) 
VALUES
	(32, 434.58, 2, 'AX-014-027', 0.00, '2016-07-08', '2016-06-21', 0.00, NULL);




--To check the affect row, run: 

/**
SELECT *
FROM InvoiceCopy
WHERE VendorID = 32;
**/







/**Problem #3
Write an INSERT statement that adds a row to the VendorCopy for each non california vendor 
in the table**/

SET IDENTITY_INSERT VendorCopy ON

INSERT INTO VendorCopy
	(VendorID, VendorName, VendorAddress1, VendorAddress2, VendorCity,
	VendorState, VendorZipCode, VendorPhone, VendorContactLName, VendorContactFName,
	DefaultTermsID, DefaultAccountNo)
SELECT 
	VendorID, VendorName, VendorAddress1, VendorAddress2, VendorCity,
	VendorState, VendorZipCode, VendorPhone, VendorContactLName, VendorContactFName,
	DefaultTermsID, DefaultAccountNo
FROM Vendors
WHERE VendorState != 'CA';


--To check the inseerted columns, run:

/**
SELECT *
FROM VendorCopy;
**/


/**Problem #6
Write an UPDATE statement that modifies the InvoiceCopy table. Change TermsID
to 2 for each invoice that's from a vendor with a DefaultTermsID of 2, using subqueries**/

/**Subquery to extract all columns with Default Terms ID = 2
Used to understand how I needed to update the data from the table

 SELECT *,
 	(SELECT DefaultTermsID = 2
	FROM Vendors
	WHERE Vendors.VendorID = Invoices.VendorID) AS LatestINV
 FROM Invoices;
 **/ 


UPDATE InvoiceCopy
SET TermsID = 2
WHERE VendorID IN  
	(SELECT VendorID	
	FROM VendorCopy
	WHERE DefaultTermsID = 2);


 



 /**Problem #7
 Solve the above problem using a join rather than a query**/

UPDATE InvoiceCopy
SET TermsID = 2
FROM InvoiceCopy JOIN VendorCopy
	ON InvoiceCopy.VendorID = VendorCopy.VendorID
WHERE DefaultTermsID = 2;

