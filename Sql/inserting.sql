Insert into [ChinookDW].[dbo].[DimCustomer](
	[CustomerId],
	[customerFullName], 
	[CustomerCountry], 
	[CustomerCity], 
	[CustomerSupportRepID], 
	[CustomerSupportRepFullName])
Select 
	[CustomerID], 
	concat([FirstName],' ',[LastName]) AS CustomerFullName, 
	[Country], 
	[City], 
	[SupportRepID], 
	concat([SupportRepLastName],' ',[SupportRepFirstName]) AS CustomerSupportFullName
FROM [ChinookStaging].[dbo].[Customer];

INSERT INTO [ChinookDw].[dbo].[DimTrack](
	[TrackID],
	[TrackName],
	[TrackGenreName],
	[TrackAlbumName],
	[TrackArtistName])
SELECT
	[TrackID],
	[TrackName],
	[GenreName],
	[AlbumName],
	[ArtistName]
FROM [Chinookstaging].[dbo].[Track];

INSERT INTO [ChinookDw].[dbo].[FactSales](
	[InvoiceID],
	[CustomerKey],
	[TrackKey],
	[InvoiceDateKey],
	[UnitPrice],
	[Total])
SELECT
	s.InvoiceID,
	c.CustomerKey,
	t.TrackKey,
	d.DateKey AS InvoiceDateKey,
	s.UnitPrice,
	s.Total
FROM [Chinookstaging].[dbo].Sales s
join [ChinookDW].[dbo].DimCustomer c
on s.[CustomerID] = c.CustomerID
join [ChinookDw].[dbo].DimTrack t
on s.[TrackID] = t.[TrackID]
join [ChinookDw].[dbo].DimDate d
on s.[InvoiceDate] = d.[Date];