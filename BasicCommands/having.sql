/*
    HAVING is the “clean” way to filter a query that has been aggregated, 
    but this is also commonly done using a subquery. Essentially, any time 
    you want to perform a WHERE on an element of your query that was created 
    by an aggregate, you need to use HAVING instead.
*/
/*
    How many of the sales reps have more than 5 accounts that they manage?
*/
SELECT s.name, s.id, COUNT(*) AS accounts_num
    FROM accounts a
    JOIN sales_reps s
        ON s.id = a.sales_rep_id
    GROUP BY s.name, s.id
    HAVING COUNT(*) > 5
    ORDER BY accounts_num;

/*
    How many accounts have more than 20 orders?
*/
SELECT a.name, a.id, COUNT(*) AS orders_num
    FROM accounts a
    JOIN orders o
        ON o.account_id = a.id
    GROUP BY a.name, a.id
    HAVING COUNT(*) > 20
    ORDER BY orders_num;

/*
    Which account has the most orders?
*/
SELECT a.name, a.id, COUNT(*) AS orders_num
    FROM accounts a
    JOIN orders o
        ON o.account_id = a.id
    GROUP BY a.name, a.id
    ORDER BY orders_num DESC
    LIMIT 1;

/*
    How many accounts spent more than 30,000 usd total across all orders?
*/
SELECT a.name, a.id, SUM(o.total_amt_usd) AS orders_total
    FROM accounts a
    JOIN orders o
        ON o.account_id = a.id
    GROUP BY a.name, a.id
    HAVING SUM(o.total_amt_usd) > 30000 
    ORDER BY orders_num;

/*
    How many accounts spent less than 1,000 usd total across all orders?
*/
SELECT a.name, a.id, SUM(o.total_amt_usd) AS orders_total
    FROM accounts a
    JOIN orders o
        ON o.account_id = a.id
    GROUP BY a.name, a.id
    HAVING SUM(o.total_amt_usd) < 1000 
    ORDER BY orders_num;

/*
    Which account has spent the most with us?
*/
SELECT a.name, a.id, SUM(o.total_amt_usd) AS orders_total
    FROM accounts a
    JOIN orders o
        ON o.account_id = a.id
    GROUP BY a.name, a.id
    ORDER BY orders_num DESC 
    LIMIT 1;

/*
    Which account has spent the least with us?
*/
SELECT a.name, a.id, SUM(o.total_amt_usd) AS orders_total
    FROM accounts a
    JOIN orders o
        ON o.account_id = a.id
    GROUP BY a.name, a.id
    ORDER BY orders_num ASC 
    LIMIT 1;

/*
    Which accounts used facebook as a channel to contact customers more than 6 times?
*/
SELECT a.id, a.name, w.channel, COUNT(*) number_of_channels
    FROM accounts a
    JOIN web_events w
        ON a.id = w.account_id
    GROUP BY a.id, a.name, w.channel
    HAVING COUNT(*) > 6 AND w.channel = 'facebook'
    ORDER BY number_of_channels;

/*
    Which account used facebook most as a channel?
*/
SELECT a.id, a.name, w.channel, COUNT(*) number_of_channels
    FROM acounts 
    JOIN web_events w
        ON a.id = w.account_id
    GROUP BY a.id, a.name, w.channel
    HAVING w.channel = 'facebook'
    ORDER BY number_of_channels DESC
    LIMIT 1;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
    FROM accounts a
    JOIN web_events w
        ON a.id = w.account_id
    WHERE w.channel = 'facebook'
    GROUP BY a.id, a.name, w.channel
    ORDER BY use_of_channel DESC
    LIMIT 1;

/*
    Which channel was most frequently used by most accounts?
*/
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
    FROM accounts a
    JOIN web_events w
        ON a.id = w.account_id
    GROUP BY a.id, a.name, w.channel
    ORDER BY use_of_channel DESC
    LIMIT 1;
