/*
    Find the sales in terms of total dollars for all orders in each year, 
    ordered from greatest to least. Do you notice any trends in the yearly sales totals?
*/
SELECT DATE_PART('year', occurred_at) order_year, SUM(total_amt_usd) total_spent
    FROM orders
    GROUP BY order_year
    ORDER BY total_spent DESC;

/*
    Which month did Parch & Posey have the greatest sales in terms of total dollars? 
    Are all months evenly represented by the dataset?
*/
SELECT DATE_PART('month', occurred_at) order_month, SUM(total_amt_usd) total_spent
    FROM orders
    WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
    GROUP BY order_month
    ORDER BY total_spent DESC;

/*
    Which year did Parch & Posey have the greatest sales in terms of total number 
    of orders? Are all years evenly represented by the dataset?
*/
SELECT DATE_PART('year', occurred_at) order_year, COUNT(*) total_orders
    FROM orders
    GROUP BY order_year
    ORDER BY total_orders DESC;

/*
    Which month did Parch & Posey have the greatest sales in terms of total number of orders? 
    Are all months evenly represented by the dataset?
*/
SELECT DATE_PART('month', occurred_at) order_month, COUNT(*) total_orders
    FROM orders
    WHERE occurred_at BETWEEN '2013-01-01' AND '2017-01-01'
    GROUP BY order_month
    ORDER BY total_orders DESC;

/*
    In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
*/
SELECT DATE_TRUNC('month', occurred_at) order_date, SUM(gloss_amt_usd) gloss_total
    FROM orders o
    JOIN accounts a
        ON a.id = o.account_id
    WHERE a.name LIKE 'Walmart'
    GROUP BY order_date
    ORDER BY gloss_total DESC;
