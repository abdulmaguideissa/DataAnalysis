/*
    JOIN indicates the second table. The ON clause specifies the column 
    on which you'd like to merge the two tables together 'boolean operation'.
    The below example pulls all the information only from orders table.
    Note That: We are able to pull data from two tables, orders and accounts.
*/
SELECT orders.*
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;

/* Example for specific column from a given table */
SELECT orders.name, orders.occurred_at
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;

/* Pull all the information from both accounts and orders */
SELECT *
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;

/* pulling standard_qty, gloss_qty, and poster_qty from the orders table, 
   and the website and the primary_poc from the accounts table. */
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty,
    accounts.website, accounts.primary_poc
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;

/* 
    Pulling multiple tables.
    Note that, we need to link each PK from the specified table to its
    FK in the joined table using ON.
*/
SELECT *
    FROM web_events
    JOIN accounts
    ON web_events.account_id = accounts.id 
    JOIN orders
    ON accounts.id = orders.account_id;
