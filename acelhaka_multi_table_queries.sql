/************************************************************
*Amarilda Celhaka											*
*Assignment #4												*
*Chapter 4: How to retrieve data from two or more table		*
*Due Date: 2/21/2019										*
*************************************************************/



/**Problem #2**/

SELECT VendorName, InvoiceNumber, InvoiceDate, 
	   InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Vendors JOIN Invoices
ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - (PaymentTotal + CreditTotal) > 0
ORDER BY VendorName ASC;




/**Problem #4**/
/**Generate the same result as previous problem but use implicit inner join syntax**/

SELECT VendorName, InvoiceNumber, InvoiceDate, 
	   InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Vendors, Invoices
WHERE Vendors.VendorID = Invoices.VendorID
AND InvoiceTotal - (PaymentTotal + CreditTotal) > 0
ORDER BY VendorName ASC;






/**Problem #5**/

SELECT VendorName AS Vendor,
	   InvoiceDate AS Date,
	   InvoiceNumber AS Number, 
	   InvoiceSequence AS #,
	   InvoiceLineItemAmount AS LineItem
FROM Vendors AS v 
	JOIN Invoices AS i ON ( v.VendorID = i.VendorID)
	JOIN InvoiceLineItems AS li ON (i.InvoiceID = li.InvoiceID)
ORDER BY VendorName, InvoiceDate, InvoiceNumber, InvoiceSequence;


/**Problem #7**/
/*Adding the invoiceLineItemAmount to check when the accountNo has never been used*/

SELECT GLAccounts.AccountNo, AccountDescription, InvoiceLineItemAmount
FROM GLAccounts LEFT jOIN InvoiceLineItems
	ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
ORDER BY AccountNo ASC;




/**Problem #8**/

	SELECT VendorName, 'CA' AS VendorState 
	FROM Vendors
	WHERE VendorState = 'CA'
UNION 
	SELECT VendorName, 'Outside CA' AS VendorState 
	FROM Vendors
	WHERE VendorState != 'CA'
ORDER BY VendorName;
	


