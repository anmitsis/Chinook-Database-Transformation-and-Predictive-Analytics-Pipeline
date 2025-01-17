USE chinook;

SELECT 
    e.EmployeeId,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName,
    e.HireDate,
    e.BirthDate,
    COUNT(i.InvoiceId) AS TotalInvoicesSold,
    SUM(i.Total) AS TotalRevenueGenerated,
    SUM(i.Total) / COUNT(i.InvoiceId) AS AverageRevenuePerInvoice
FROM 
    Employee e
INNER JOIN 
    Customer c 
    ON e.EmployeeId = c.SupportRepId
INNER JOIN 
    Invoice i
    ON i.CustomerId = c.CustomerId
GROUP BY 
    e.EmployeeId, e.FirstName, e.LastName, e.HireDate, e.BirthDate
ORDER BY 
    e.EmployeeId ASC;