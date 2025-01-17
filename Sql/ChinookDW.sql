--dw
create database ChinookDw
go

use ChinookDw
go

create table DimCustomer(
	CustomerKey INT IDENTITY(1,1) NOT NULL,
	CustomerID INT NOT NULL,
	CustomerFullName VARCHAR(40) NOT NULL,
	CustomerCountry VARCHAR(40) NOT NULL,
	CustomerCity VARCHAR(40) NOT NULL,
	CustomerSupportRepID INT NOT NULL,
	CustomerSupportRepFullName VARCHAR(40) NOT NULL,
	CONSTRAINT PK_CustomerKey PRIMARY KEY CLUSTERED (CustomerKey)
);

create table DimTrack(
	TrackKey INT IDENTITY(1,1) NOT NULL,
	TrackID INT NOT NULL,
	TrackName VARCHAR(255) NOT NULL,
	TrackGenreName VARCHAR(20) NOT NULL,
	TrackAlbumName VARCHAR(255) NOT NULL,
	TrackArtistName VARCHAR(255) NOT NULL,
	CONSTRAINT PK_TrackKey PRIMARY KEY CLUSTERED (TrackKey)
);

create table FactSales(
	InvoiceID INT NOT NULL,
	CustomerKey INT NOT NULL,
	TrackKey INT NOT NULL,
	InvoiceDateKey INT NOT NULL,
	UnitPrice DECIMAL(5,2) NOT NULL
);

--Creating the date dimension as a table in MSSQL
	

CREATE TABLE [dbo].[DimDate]
	(	[DateKey] INT primary key,
		[Date] DATETIME,
		[Year] CHAR(4),
		[Quarter] CHAR(1),
		[MonthName] VARCHAR(9),
		[DayofMonth] VARCHAR(2)
	)
;
	
-- Δήλωση μεταβλητών για εύρος ημερομηνιών
DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = MIN(InvoiceDate), 
	   @EndDate = MAX(InvoiceDate)
FROM [Chinook].[dbo].Invoice;
DECLARE @CurrentDate DATE = @StartDate;

-- Εισαγωγή δεδομένων στον πίνακα DimDate
WHILE @CurrentDate <= @EndDate
BEGIN
    INSERT INTO [dbo].[DimDate] ([DateKey], [Date], [DayOfMonth], [MonthName], [Quarter], [Year])
    VALUES (
        CONVERT(INT, FORMAT(@CurrentDate, 'yyyyMMdd')),       -- DateKey (μορφή yyyyMMdd)
        @CurrentDate,
		FORMAT(@CurrentDate, 'dd'),                          -- DayOfMonth
        DATENAME(MONTH, @CurrentDate),                       -- MonthName
        DATEPART(QUARTER, @CurrentDate),                     -- Quarter
        DATEPART(YEAR, @CurrentDate)                         -- Year
    );

    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate); -- Προσαύξηση της ημερομηνίας κατά 1 ημέρα
END;

-- Επιβεβαίωση δεδομένων
SELECT * FROM [dbo].[DimDate];



alter table [ChinookDW].[dbo].FactSales
	add constraint FactSales_DimCustomer_CustomerKey_fk
		foreign key (CustomerKey) references [ChinookDW].[dbo].DimCustomer (CustomerKey);


alter table [ChinookDW].[dbo].FactSales
	add constraint FactSales_DimTrack_TrackKey_fk
		foreign key (TrackKey) references [ChinookDW].[dbo].DimTrack (TrackKey);


alter table [ChinookDW].[dbo].FactSales
	add constraint FactSales_DimDate_InvoiceDateKey_fk
		foreign key (InvoiceDateKey) references [ChinookDW].[dbo].[DimDate] (DateKey);