/*
    GROUP BY is used when extracting subset data from data with aggregation
    functions. 
    Which account (by name) placed the earliest order? Your solution 
    should have the account name and the date of the order.
*/
SELECT accounts.name, orders.occurred_at
    FROM accounts
    JOIN orders
        ON orders.account_id = accounts.id
    ORDER BY orders.occurred_at
    LIMIT 1;

/*
    Find the total sales in usd for each account. You should include two 
    columns - the total sales for each company's orders in usd and the company name.
*/
SELECT accounts.name, SUM(orders.total_amt_usd) 
    FROM orders
    JOIN accounts
        ON accounts.id = orders.account_id
    GROUP BY accounts.name;

/*
    Via what channel did the most recent (latest) web_event occur, which 
    account was associated with this web_event? Your query should return 
    only three values - the date, channel, and account name.
*/
SELECT web_events.channel, web_events.occurred_at, accounts.name 
    FROM web_events
    JOIN accounts
        ON web_events.account_id = accounts.id 
    ORDER BY web_events.occurred_at DESC
    LIMIT 1;

/*
    Find the total number of times each type of channel from the web_events was 
    used. Your final table should have two columns - the channel and the number 
    of times the channel was used.
*/
SELECT channel, COUNT(*) AS Total_Number
    FROM web_events 
    GROUP BY channel;

/*
    Who was the primary contact associated with the earliest web_event?
*/
SELECT accounts.primary_poc
    FROM accounts
    JOIN web_events 
        ON web_events.account_id = accounts.id
    ORDER BY web_events.occurred_at
    LIMIT 1;

/*
    What was the smallest order placed by each account in terms of total usd. 
    Provide only two columns - the account name and the total usd. 
    Order from smallest dollar amounts to largest.
*/
SELECT accounts.name, MIN(orders.total_amt_usd) smallest_order
    FROM orders
    JOIN accounts
        ON accounts.id = orders.account_id
    GROUP BY accounts.name
    ORDER BY smallest_order;

/*
    Find the number of sales reps in each region. Your final table should 
    have two columns - the region and the number of sales_reps. Order from fewest 
    reps to most reps.
*/
SELECT region.name, COUNT(*) sales_reps_number
    FROM region
    JOIN sales_reps 
        ON sales_reps.region_id = region.id
    GROUP BY region.name 
    ORDER BY sales_reps_number;