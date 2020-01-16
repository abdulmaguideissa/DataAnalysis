/*
    For each account, determine the average amount of each type of paper 
    they purchased across their orders. Your result should have four columns - 
    one for the account name and one for the average quantity purchased for 
    each of the paper types for each account.
*/
SELECT accounts.name AS name, 
AVG(orders.standard_qty) AS std_qty_avg,
AVG(orders.poster_qty) AS poster_qty_avg, 
AVG(orders.gloss_qty) AS gloss_qty_avg
    FROM accounts
    JOIN orders
        ON orders.account_id = accounts.id
    GROUP BY name;

/*
    For each account, determine the average amount spent per order on each paper type. 
    Your result should have four columns - one for the account name and one for the 
    average amount spent on each paper type.
*/
SELECT accounts.name AS name, 
AVG(orders.standard_amt_usd) AS std_usd_avg,
AVG(orders.poster_amt_usd) AS poster_usd_avg, 
AVG(orders.gloss_amt_usd) AS gloss_usd_avg
    FROM accounts
    JOIN orders
        ON orders.account_id = accounts.id
    GROUP BY name;

/*
    Determine the number of times a particular channel was used in the web_events table 
    for each sales rep. Your final table should have three columns - the name of the sales rep, 
    the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
*/
SELECT sales_reps.name AS sales_name,
web_events.channel AS event_channel,
COUNT(*) AS occurrences_number
    FROM sales_reps
    JOIN accounts
        ON accounts.sales_rep_id = sales_reps.id
    JOIN web_events
        ON web_events.account_id = accounts.id
    GROUP BY event_channel, sales_name
    ORDER BY occurrences_number DESC;

/*
    Determine the number of times a particular channel was used in the web_events 
    table for each region. Your final table should have three columns - the region 
    name, the channel, and the number of occurrences. Order your table with the highest 
    number of occurrences first.
*/
SELECT region.name AS region_name,
web_events.channel AS event_channel,
COUNT(*) AS occurrences_number
    FROM web_events
    JOIN accounts
        ON accounts.id = web_events.account_id
    JOIN sales_reps
        ON sales_reps.id = accounts.sales_rep_id
    JOIN region
        ON region.id = sales_reps.region_id
    GROUP BY event_channel, region_name
    ORDER BY occurrences_number DESC;