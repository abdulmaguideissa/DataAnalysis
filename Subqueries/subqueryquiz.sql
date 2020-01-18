/*
    Subqueries might return single value, in this case, it might be useful to
    use this value in conditional statement such as HAVING, WHERE, SELECT CASE.
    In this situation, using ALIAS is not required.
*/
/*
    Quiz
    Use DATE_TRUNC to pull the month level of the first order ever placed in order table.
    Use the result to pull all the orders that happened in this month and year and then
    pull all the averages of each paper qty of this month.
*/
SELECT AVG(gloss_qty) AS gloss_avg, AVG(poster_qty) AS poster_avg, 
       AVG(standard_qty) AS std_avg, SUM(total_amt_usd) AS total_spent
    FROM orders
    WHERE DATE_TRUNC('month', occurred_at) = (
        SELECT DATE_TRUNC('month', MIN(occurred_at)) AS first_month
            FROM orders
        );

/*
    Quiz
    Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
*/
SELECT names_table.sales_name, names_table.region_name, total_max_table.total_max
    FROM 
        (SELECT region_name, MAX(total_spent) total_max
            FROM (
                SELECT s.name AS sales_name, r.name AS region_name, SUM(o.total_amt_usd) AS total_spent
                    FROM sales_reps s
                    JOIN accounts a
                    ON a.sales_rep_id = s.id
                    JOIN orders o
                    ON o.account_id = a.id
                    JOIN region r
                    ON r.id = s.region_id
                    GROUP BY 1, 2 ) total_sum_table
            GROUP BY 1 ) total_max_table
    JOIN 
        (SELECT s.name AS sales_name, r.name AS region_name, SUM(o.total_amt_usd) AS total_spent
                FROM sales_reps s
                JOIN accounts a
                ON a.sales_rep_id = s.id
                JOIN orders o
                ON o.account_id = a.id
                JOIN region r
                ON r.id = s.region_id
                GROUP BY 1, 2 
                ORDER BY 3 DESC) names_table
    ON names_table.region_name = total_max_table.region_name AND names_table.total_spent = total_max_table.total_max;

/*
    For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
*/
SELECT r.name region_name, COUNT(o.total)
    FROM sales_reps s
    JOIN accounts a
    ON a.sales_rep_id = s.id
    JOIN orders o
    ON o.account_id = a.id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY 1
    HAVING SUM(o.total_amt_usd) = 
        (SELECT MAX(total_spent) AS max_sum
            FROM 
                (SELECT r.name region_name, SUM(o.total_amt_usd) AS total_spent
                    FROM sales_reps s
                    JOIN accounts a
                    ON a.sales_rep_id = s.id
                    JOIN orders o
                    ON o.account_id = a.id
                    JOIN region r
                    ON r.id = s.region_id
                    GROUP BY 1
            ) total_sum );  

/*
    How many accounts had more total purchases than the account name which has 
    bought the most standard_qty paper throughout their lifetime as a customer?
*/
SELECT COUNT(*) total_count FROM
    (SELECT a.name account_name 
        FROM accounts a
        JOIN orders o
        ON o.account_id = a.id
        GROUP BY 1
        HAVING SUM(o.total) > (SELECT total_sum FROM 
            (SELECT a.name account_name, SUM(o.standard_qty) std_qty_sum, SUM(o.total) total_sum
                FROM orders o
                JOIN accounts a
                ON a.id = o.account_id
                GROUP BY 1
                ORDER BY 2 DESC
                LIMIT 1) sum) 
                condition ) 
                total_count;

/*
    For the customer that spent the most (in total over their lifetime as a customer) 
    total_amt_usd, how many web_events did they have for each channel?
*/
SELECT a.name account_name, w.channel event_ch, COUNT(*) total_web_events
    FROM web_events w
    JOIN accounts a
    ON w.account_id = a.id 
        AND a.id = (SELECT account_id FROM 
            (SELECT a.id account_id, a.name account_name, SUM(o.total_amt_usd) total_usd
                FROM orders o
                JOIN accounts a
                ON a.id = o.account_id
                GROUP BY 1, 2
                ORDER BY 3 DESC
                LIMIT 1) sum )
    GROUP BY 1, 2
    ORDER BY 3 DESC;

/*
    What is the lifetime average amount spent in terms of total_amt_usd 
    for the top 10 total spending accounts?
*/
SELECT AVG(total_usd) avg_total_usd FROM
    (SELECT a.id account_id, a.name account_name, SUM(o.total_amt_usd) total_usd
        FROM orders o
        JOIN accounts a
        ON a.id = o.account_id
        GROUP BY 1, 2
        ORDER BY 3 DESC
        LIMIT 10) sub;

/*
    What is the lifetime average amount spent in terms of total_amt_usd, including 
    only the companies that spent more per order, on average, than the average of all orders.
*/
SELECT AVG(top_avg) FROM
    (SELECT o.account_id, AVG(o.total_amt_usd) top_avg
        FROM orders o
        GROUP BY 1
        HAVING AVG(o.total_amt_usd) > 
            (SELECT AVG(o.total_amt_usd) FROM 
                orders o)) grand_avg;
