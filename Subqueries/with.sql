/*
    WITH statement is used to pull out the subqueries from the main query 
    for more readibilty and logic flow.
    QUESTION: You need to find the average number of events for each channel per day.
*/
WITH total_events AS (
    SELECT DATE_TRUNC('day', occurred_at) day, channel, COUNT(*) total_events
        FROM web_events w
        GROUP BY 1, 2
)
SELECT channel, AVG(total_events) total_events_avg
    FROM total_events
    GROUP BY channel
    ORDER BY 2 DESC;

/*
    We can create an additional table to pull from in the following way.
*/
WITH table1 AS (
          SELECT *
          FROM web_events),

     table2 AS (
          SELECT *
          FROM accounts)
SELECT *
    FROM table1
    JOIN table2
    ON table1.account_id = table2.id;