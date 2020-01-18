/*
    Quiz
    Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
*/
WITH total_sum_t AS (
    SELECT s.name AS sales_name, r.name AS region_name, SUM(o.total_amt_usd) AS total_spent
        FROM sales_reps s
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON o.account_id = a.id
        JOIN region r
        ON r.id = s.region_id
        GROUP BY 1, 2 
        ORDER BY 3 DESC
    ),
    total_max_t AS (
        SELECT region_name, MAX(total_spent) total_max
        FROM total_sum_t
        GROUP BY 1 
    )
SELECT s.sales_name, s.region_name, m.total_max
    FROM total_sum_t s
    JOIN total_max_t m
    ON s.region_name = m.region_name AND s.total_spent = m.total_max;

/*
    For the region with the largest sales total_amt_usd, how many total orders were placed?
*/
WITH total_sum AS (
    SELECT r.name region_name, SUM(o.total_amt_usd) AS total_spent
        FROM sales_reps s
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON o.account_id = a.id
        JOIN region r
        ON r.id = s.region_id
        GROUP BY 1 
    ), 
    total_max AS (
        SELECT MAX(total_spent) AS max_sum
            FROM total_sum
    )
SELECT r.name region_name, COUNT(o.total)
    FROM sales_reps s
    JOIN accounts a
    ON a.sales_rep_id = s.id
    JOIN orders o
    ON o.account_id = a.id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY 1
    HAVING SUM(o.total_amt_usd) = (SELECT * FROM total_max)

/*
    For the account that purchased the most (in total over their lifetime as a customer) 
    standard_qty paper, how many accounts still had more in total purchases?
*/
WITH most_purchs AS (
    SELECT a.name account_name, SUM(o.standard_qty) std_qty_sum, SUM(o.total) total_sum
        FROM orders o
        JOIN accounts a
        ON a.id = o.account_id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 1 
    ),
    account AS (
        SELECT a.name account_name 
        FROM accounts a
        JOIN orders o
        ON o.account_id = a.id
        GROUP BY 1
        HAVING SUM(o.total) > (SELECT total_sum FROM most_purchs)
    )
SELECT COUNT(*) FROM account;

/*
    For the customer that spent the most (in total over their lifetime as a customer) 
    total_amt_usd, how many web_events did they have for each channel?
*/
WITH top_total_sum AS (
    SELECT a.id account_id, a.name account_name, SUM(o.total_amt_usd) total_usd
        FROM orders o
        JOIN accounts a
        ON a.id = o.account_id
        GROUP BY 1, 2
        ORDER BY 3 DESC
        LIMIT 1
    )
SELECT a.name account_name, w.channel event_ch, COUNT(*) total_web_events
    FROM web_events w
    JOIN accounts a
    ON w.account_id = a.id AND a.id = (SELECT account_id FROM top_total_sum)
    GROUP BY 1, 2
    ORDER BY 3 DESC;

/*
    What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
*/
WITH top_total_sum AS (
    SELECT a.id account_id, a.name account_name, SUM(o.total_amt_usd) total_usd
        FROM orders o
        JOIN accounts a
        ON a.id = o.account_id
        GROUP BY 1, 2
        ORDER BY 3 DESC
        LIMIT 10
    )
SELECT AVG(total_usd) 
    FROM top_total_sum;

/*
    What is the lifetime average amount spent in terms of total_amt_usd, 
    including only the companies that spent more per order, on average, than the average of all orders.
*/
WITH grand_avg AS (
        SELECT AVG(o.total_amt_usd) 
            FROM orders o
            JOIN accounts a
            ON a.id = o.account_id
    ),
    total_avg AS (
        SELECT a.id, AVG(o.total_amt_usd) avg_orders
            FROM orders o
            JOIN accounts a
            ON a.id = o.account_id
            GROUP BY 1
            HAVING AVG(o.total_amt_usd) > (SELECT * FROM grand_avg) 
    )
SELECT AVG(avg_orders)
    FROM total_avg;