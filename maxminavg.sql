/*
    When was the earliest order ever placed? You only need to return the date.
*/
SELECT MIN(occurred_at)
    FROM orders;

/*
    Try performing the same query as in question 1 without using an aggregation function.
*/
SELECT occurred_at
    FROM orders
    ORDER BY occurred_at
    LIMIT 1;

/*
    When did the most recent (latest) web_event occur?
*/
SELECT MAX(occurred_at)
    FROM web_events;

/*
    Try to perform the result of the previous query without using an aggregation function.
*/
SELECT occurred_at
    FROM web_events 
    ORDER BY occurred_at DESC
    LIMIT 1;


/*
    Find the mean (AVERAGE) amount spent per order on each paper type, as well 
    as the mean amount of each paper type purchased per order. Your final answer 
    should have 6 values - one for each paper type for the average number of sales, 
    as well as the average amount.
*/
SELECT AVG(standard_amt_usd) AS standard_type_avg_amt,
    AVG(gloss_amt_usd) AS gloss_type_avg_amt,
    AVG(poster_amt_usd) AS poster_type_avg_amt,
    AVG(stanard_qty) AS standard_type_avg_number,
    AVG(gloss_qty) AS gloss_type_avg_number,
    AVG(poster_qty) AS poster_type_avg_number
    FROM orders;

/*
    what is the MEDIAN total_usd spent on all orders?
    the solution assumes a pre-known number of rows (6912) and the two numbers represnting the median 
    are 3456 and 3457.
*/
SELECT *
    FROM (SELECT total_amt_usd
            FROM orders
            ORDER BY total_amt_usd
            LIMIT 3457) AS Table1
    ORDER BY total_amt_usd DESC
    LIMIT 2;