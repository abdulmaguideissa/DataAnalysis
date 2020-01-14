/*
    Lab1.
    Q1 The Chinook database contains all invoices from the beginning of 2009 
    till the end of 2013. The employees at Chinook store are interested in 
    seeing all invoices that happened in 2013 only. Using the Invoice table, 
    write a query that returns all the info of the invoices in 2013.
*/
SELECT *
    FROM Invoice 
    WHERE InvoiceDate BETWEEN '2013-01-01' AND '2014-01-01';

/*
    Q2 The Chinook team decided to run a marketing campaign in Brazil, 
    Canada, india, and Sweden. Using the customer table, write a query 
    that returns the first name, last name, and country for all customers 
    from the 4 countries.
*/
SELECT FirstName, LastName, Country
    FROM Customer
    WHERE Country IN ('Brazil', 'Canada', 'India', 'Sweden');

/*
    Q3 Using the Track and Album tables, write a query that returns all 
    the songs that start with the letter 'A' and the composer field is not empty. 
    Your query should return the name of the song, the name of the composer, 
    and the title of the album.
*/
SELECT Track.Name AS track_name,
    Track.Composer AS track_composer,
    Album.Title AS album_title
    FROM Track
    JOIN Album 
        ON Track.AlbumId = Album.AlbumId
    WHERE Track.Name LIKE 'A%' AND Track.Composer IS NOT NULL;

/*
    Q4 The Chinook team would like to throw a promotional Music Festival 
    for their top 10 customers who have spent the most in a single invoice. 
    Write a query that returns the first name, last name, and invoice total 
    for the top 10 invoices ordered by invoice total descending."
*/
SELECT Customer.FirstName AS first_name, 
    Customer.LastName AS last_name, 
    Invoice.Total AS total_time
    FROM Invoice
    JOIN Customer
        ON Customer.CustomerId = Invoice.CustomerId
    ORDER BY total_time DESC
    LIMIT 10;