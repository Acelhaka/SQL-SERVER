/************************************************************
*Amarilda Celhaka											*
*Assignment #2												*
*Chapter 3: How to retrieve data from a single table		*
*Due Date: 2/13/2019										*
*************************************************************/



/**Problem #1**/

SELECT VendorContactFName, VendorContactLName, VendorName
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName;






/**Problem #3**/

SELECT VendorContactLName + ',' + VendorContactFName AS FullName
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName;





/**Problem #4**/

 
SELECT InvoiceTotal, InvoiceTotal * 0.1 AS InvoiceRate,  InvoiceTotal * 0.1 + InvoiceTotal AS InvoiceAmount
FROM Invoices
WHERE InvoiceTotal > 1000
ORDER BY InvoiceTotal DESC;





/**Problem 6**/


SELECT VendorContactLName + ',' + VendorContactFName AS FullName
FROM Vendors
WHERE VendorContactLName LIKE 'A%' OR VendorContactLName LIKE 'B%' OR 
	   VendorContactLName LIKE 'C%' OR  VendorContactLName LIKE 'E%'
ORDER BY VendorContactLName, VendorContactFName;