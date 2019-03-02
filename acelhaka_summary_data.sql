/************************************************************
*Amarilda Celhaka											*
*Assignment #5												*
*Chapter 5: How to code summary queries						*
*Due Date: 3/1/2019											*
*************************************************************/

/*Problem2
*Write a SELECT statement that returns two columns: VendorName and PaymentSum, where 
*PaymentSum is the sum of the PaymentTotal colums. Group the result set by VendorName. 
*Return only 10 rows, corresponding to the 10 vendors who've been paid most */

SELECT TOP 10 SUM ( PaymentTotal) AS PaymentSum, VendorName
	FROM Invoices JOIN Vendors
	ON Invoices.VendorID = Vendors.VendorID
	GROUP BY VendorName
	ORDER BY PaymentSum DESC;




/*Problem #4*/

SELECT AccountDescription, 
		SUM ( InvoiceLineItemAmount ) AS LineItemSum, 
		COUNT (*) AS LineItemCount
	FROM InvoiceLineItems JOIN GLAccounts
	ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
	GROUP BY AccountDescription
	HAVING COUNT (*) > 1
	ORDER BY LineItemCount;
	*/



/*Problem #5*/
/*Using ROLLUP the first row in the database will display the Grand Total of all accounts*/

SELECT  SUM(InvoiceLineItemAmount) AS TotalAmountforAccount,
		AccountNo
	FROM InvoiceLineItems
	GROUP BY AccountNo WITH ROLLUP
	ORDER BY AccountNo; 
	


/*Problem #7*/
/* Joining four tables */

SELECT	 VendorName,
		AccountDescription,
		COUNT (*) AS LineItemCount,
		SUM (InvoiceLineItemAmount) AS InvoiceLineItemAmount
	FROM Vendors 
		JOIN Invoices 
			ON Vendors.VendorID = Invoices.VendorID
		JOIN InvoiceLineItems 
			ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
		JOIN GLAccounts
			ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
	GROUP BY VendorName, AccountDescription WITH ROLLUP
	ORDER BY VendorName, AccountDescription;



/*Problem #8 */
/*Write a SELECT statement that answers: Which Vendors are being paid from more than one
*account? Return two columns: the vendor name and the total number of accounts that 
*apply to that vendor's invoices */


	SELECT  Vendors.VendorName,
		 COUNT (DISTINCT InvoiceLineItems.AccountNo) AS NumberofAccountPaid
	FROM Vendors 
		JOIN Invoices 
			ON Vendors.VendorID = Invoices.VendorID
		JOIN InvoiceLineItems 
			ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
		JOIN GLAccounts
			ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
		GROUP BY VendorName, InvoiceLineItems.AccountNo;
 


	
