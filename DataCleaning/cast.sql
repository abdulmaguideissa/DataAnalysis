/*
    CAST function is used to convert a text from one format to another.
    Quiz.
    Write a query to look at the top 10 rows to inderstand the columns 
    and the row data in the dataset called sf_crime_data.
*/
SELECT *
    FROM sf_crime_data
    LIMIT ;

/*
    Write a query to change the date format to the proper SQL format.
*/
SELECT date, 
       CONCAT(SUBSTR(date, 7, 4), '-', SUBSTR(date, 1, 2), '-', SUBSTR(date, 4, 2)) AS sql_date
    FROM sf_crime_data;

/*
    Use either :: or CAST to convert the previous query into date.
*/
SELECT date, 
       CAST(CONCAT(SUBSTR(date, 7, 4), '-', 
                   SUBSTR(date, 1, 2), '-', 
                   SUBSTR(date, 4, 2)) AS DATE) AS sql_date
    FROM sf_crime_data;