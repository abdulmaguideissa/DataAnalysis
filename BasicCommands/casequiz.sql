/*
    Write a query to display for each order, the account ID, total amount of 
    the order, and the level of the order - ‘Large’ or ’Small’ - depending on 
    if the order is $3000 or more, or less than $3000.
*/
SELECT account_id, total_amt_usd,
    CASE WHEN total_amt_usd >= 3000
        THEN 'Large'
    ELSE 
        'Small'
    END AS "Level"
    FROM orders

/*
    Write a query to display the number of orders in each of three categories, 
    based on the total number of items in each order. The three categories are: 
    'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
*/
SELECT 
    CASE WHEN total >= 2000
        THEN 'At Least 2000'
    WHEN total < 2000 AND total >= 1000
        THEN 'Between 1000 and 2000'
    WHEN total < 1000
        THEN 'Less than 1000'
    END AS Categories, 
    COUNT(*) AS orders_count
    FROM orders
    GROUP BY 1;

/*
    We would like to understand 3 different branches of customers based on the 
    amount associated with their purchases. The top branch includes anyone with
    a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
    The second branch is between 200,000 and 100,000 usd. The lowest branch is 
    anyone under 100,000 usd. Provide a table that includes the level associated 
    with each account. You should provide the account name, the total sales of 
    all orders for the customer, and the level. Order with the top spending customers listed first.
*/
SELECT a.name AS account_name, SUM(o.total_amt_usd) AS total_usd,
    CASE WHEN SUM(o.total_amt_usd) > 200000
        THEN 'First Level'
    WHEN SUM(o.total_amt_usd) <= 200000 AND SUM(o.total_amt_usd) > 100000
        THEN 'Second Level'
    ELSE 
        'Third Level' 
    END AS levels
    FROM accounts a
    JOIN orders o 
        ON o.account_id = a.id
    GROUP BY account_name
    ORDER BY total_usd DESC;

/*
    We would now like to perform a similar calculation to the first, but we want to 
    obtain the total amount spent by customers only in 2016 and 2017. Keep the same 
    levels as in the previous question. Order with the top spending customers listed first.
*/
SELECT a.name AS account_name, SUM(o.total_amt_usd) AS total_usd,
    CASE WHEN SUM(o.total_amt_usd) > 200000
        THEN 'First Level'
    WHEN SUM(o.total_amt_usd) <= 200000 AND SUM(o.total_amt_usd) > 100000
        THEN 'Second Level'
    ELSE 
        'Third Level' 
    END AS levels
    FROM accounts a
    JOIN orders o 
        ON o.account_id = a.id
    WHERE o.occurred_at = '2015-12-31'
    GROUP BY account_name
    ORDER BY total_usd DESC;

/*
    We would like to identify top performing sales reps, which are sales reps
    associated with more than 200 orders. Create a table with the sales rep name, 
    the total number of orders, and a column with top or not depending on if 
    they have more than 200 orders. Place the top sales people first in your final table.
*/
SELECT s.name, COUNT(*) AS total_orders,
    CASE WHEN COUNT(*) > 200
        THEN 'Top Sales'
    ELSE 
        'NOT'
    END AS top_sales_list
    FROM orders o
    JOIN accounts a
        ON o.account_id = a.id
    JOIN sales_reps s
        ON a.sales_rep_id = s.id
    GROUP BY s.name
    ORDER BY total_orders DESC;

/*
    The previous didn't account for the middle, nor the dollar amount associated with the sales.
    Management decides they want to see these characteristics represented as well. 
    We would like to identify top performing sales reps, which are sales reps associated
    with more than 200 orders or more than 750000 in total sales. 
    The middle group has any rep with more than 150 orders or 500000 in sales. 
    Create a table with the sales rep name, the total number of orders, total sales across all orders, 
    and a column with top, middle, or low depending on this criteria. 
    Place the top sales people based on dollar amount of sales first in your final table.
*/
SELECT s.name, COUNT(*) AS total_orders, SUM(o.total_amt_usd) AS total_spent,
    CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000
        THEN 'top'
    WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000
        THEN 'middle'
    ELSE 
        'low'
    END AS top_sales_list
    FROM orders o
    JOIN accounts a
        ON o.account_id = a.id
    JOIN sales_reps s
        ON a.sales_rep_id = s.id
    GROUP BY s.name
    ORDER BY total_spent DESC;