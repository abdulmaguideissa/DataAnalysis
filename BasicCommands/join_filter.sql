/*
    Provide a table that provides the region for each sales_rep along 
    with their associated accounts. This time only for the Midwest region. 
    Your final table should include three columns: the region name, the sales 
    rep name, and the account name. Sort the accounts alphabetically (A-Z) 
    according to account name.
*/
SELECT region.name AS region_name,
    sales_reps.name AS sales_name,
    accounts.name AS account_name
    FROM region
    JOIN sales_reps 
        ON sales_reps.region_id = region.id AND region.name = 'Midwest'
    JOIN accounts
        ON accounts.sales_rep_id = sales_reps.id
    ORDER BY accounts.name;

/*
    Provide a table that provides the region for each sales_rep along with 
    their associated accounts. This time only for accounts where the sales 
    rep has a first name starting with S and in the Midwest region. Your final 
    table should include three columns: the region name, the sales rep name,
     and the account name. Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT region.name AS region_name,
    sales_reps.name AS sales_name,
    accounts.name AS account_name
    FROM region
    JOIN sales_reps 
        ON sales_reps.region_id = region.id AND region.name = 'Midwest'
    JOIN accounts
        ON accounts.sales_rep_id = sales_reps.id AND sales_reps.name LIKE 'S%'
    ORDER BY accounts.name;

/*
    Provide a table that provides the region for each sales_rep along with 
    their associated accounts. This time only for accounts where the sales 
    rep has a last name starting with K and in the Midwest region. Your final 
    table should include three columns: the region name, the sales rep name, 
    and the account name. Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT region.name AS region_name,
    sales_reps.name AS sales_name,
    accounts.name AS account_name
    FROM region
    JOIN sales_reps 
        ON sales_reps.region_id = region.id AND region.name = 'Midwest'
    JOIN accounts
        ON accounts.sales_rep_id = sales_reps.id AND sales_reps.name LIKE '% K%'
    ORDER BY accounts.name;

/*
    Provide the name for each region for every order, as well as the account 
    name and the unit price they paid (total_amt_usd/total) for the order. 
    However, you should only provide the results if the standard order quantity
    exceeds 100. Your final table should have 3 columns: region name, account name, 
    and unit price. In order to avoid a division by zero error, adding .01 to the 
    denominator here is helpful total_amt_usd/(total+0.01).
*/
SELECT region.name AS region_name,
    accounts.name AS account_name,
    (orders.total_amt_usd / (orders.total + 0.01)) AS unit_price
    FROM orders
    JOIN accounts
        ON orders.account_id = accounts.id AND orders.standard_qty > 100
    JOIN sales_reps 
        ON sales_reps.id = accounts.sales_rep_id
    JOIN region
        ON sales_reps.region_id = region.id;

/*
    Provide the name for each region for every order, as well as the account
    name and the unit price they paid (total_amt_usd/total) for the order. 
    However, you should only provide the results if the standard order quantity
    exceeds 100 and the poster order quantity exceeds 50. Your final table
    should have 3 columns: region name, account name, and unit price.
    Sort for the smallest unit price first. In order to avoid a division 
    by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
*/
SELECT region.name AS region_name,
    accounts.name AS account_name,
    (orders.total_amt_usd / (orders.total + 0.01)) AS unit_price
    FROM orders
    JOIN accounts
        ON orders.account_id = accounts.id AND 
            orders.standard_qty > 100 AND
            orders.poster_qty > 50
    JOIN sales_reps 
        ON sales_reps.id = accounts.sales_rep_id
    JOIN region
        ON sales_reps.region_id = region.id
    ORDER BY unit_price;

/*
    Provide the name for each region for every order, as well as the account
    name and the unit price they paid (total_amt_usd/total) for the order. 
    However, you should only provide the results if the standard order quantity
    exceeds 100 and the poster order quantity exceeds 50. Your final table 
    should have 3 columns: region name, account name, and unit price. Sort for
    the largest unit price first. In order to avoid a division by zero error,
    adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
*/
SELECT region.name AS region_name,
    accounts.name AS account_name,
    (orders.total_amt_usd / (orders.total + 0.01)) AS unit_price
    FROM orders
    JOIN accounts
        ON orders.account_id = accounts.id AND 
            orders.standard_qty > 100 AND
            orders.poster_qty > 50
    JOIN sales_reps 
        ON sales_reps.id = accounts.sales_rep_id
    JOIN region
        ON sales_reps.region_id = region.id
    ORDER BY unit_price DESC;

/*
    What are the different channels used by account id 1001? Your final 
    table should have only 2 columns: account name and the different channels. 
    You can try SELECT DISTINCT to narrow down the results to only the unique values.
*/
SELECT DISTINCT accounts.name, web_events.channel
    FROM accounts
    JOIN web_events
        ON accounts.id = web_events.account_id AND 
            accounts.id = 1001;

/*
    Find all the orders that occurred in 2015. Your final table should have 4 columns: 
    occurred_at, account name, order total, and order total_amt_usd.
*/
SELECT orders.occurred_at, accounts.name,
    orders.total_amt_usd, orders.total 
    FROM orders
    JOIN accounts 
        ON orders.account_id = accounts.id AND 
            orders.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
    ORDER BY orders.occurred_at DESC;