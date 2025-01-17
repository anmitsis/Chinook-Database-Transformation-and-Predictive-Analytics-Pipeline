--STAGING

drop database if exists ChinookStaging
create database Chinookstaging
GO

--create & load table [Employees] in staging
use ChinookStaging


select
	c.CustomerID,
	c.FirstName,
	c.LastName,
	c.Country,
	c.City,
	Supportrepid,
	e.LastName AS SupportRepLastName,
	e.FirstName AS SupportRepFirstName
	into [Customer]
from [Chinook].[dbo].Customer c
	inner join [Chinook].[dbo].[Employee] e
	on c.[SupportRepId] = e.[EmployeeId]

select 
	Trackid,
	t.Name AS TrackName,
	g.Name AS GenreName,
	a1.Title AS AlbumName,
	a2.Name AS ArtistName
	into [Track]
from [Chinook].[dbo].Track t
	inner join [Chinook].[dbo].[Genre] g
	on t.[GenreID] = g.[GenreID]
	inner join [Chinook].[dbo].[Album] a1
	on t.[AlbumID] = a1.[AlbumID]
	inner join [Chinook].[dbo].[Artist] a2
	on a1.[ArtistID] = a2.[ArtistID]

	

select
	i1.InvoiceID,
	CustomerID,
	TrackID,
	InvoiceDate,
	UnitPrice,
	Total
	into [Sales]
from [Chinook].[dbo].Invoice i1
	inner join [Chinook].[dbo].[InvoiceLine] i2
	on i1.[InvoiceID] = i2.[InvoiceID]


SELECT MIN(InvoiceDate), MAX(InvoiceDate)
FROM [Chinook].[dbo].Invoice;