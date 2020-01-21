/*
    COALESCE function returns the first of its arguments that is not null.
    Quiz.
    Use COALESCE to fill in the accounts.id column with the account.id for the NULL
    values for the table 1 (given).
*/
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc,
       a.sales_rep_id, o.*
    FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id
    WHERE o.total IS NULL;

/*
    Use COALESCE to fill in the orders.account_id with accounts.id for the NULL values
    FROM table 1.
*/
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc,
       a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, o.standard_qty, o.gloss_qty, 
       o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
    FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id
    WHERE o.total IS NULL;

/*
    USE COALSECE to fill in each of the qty and usd NULL values with 0.
*/
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc,
       a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) std_qty, 
       COALESCE(o.gloss_qty, 0) gloss_qty, COALESCE(o.poster_qty, 0) poster_qty, o.total, COALESCE(o.standard_amt_usd, 0) std_amt, 
       COALESCE(o.gloss_amt_usd, 0) gloss_amt, COALESCE(o.poster_amt_usd, 0) poster_amt, COALESCE(o.total_amt_usd, 0) total_amt
    FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id
    WHERE o.total IS NULL;

/* 
    Run query in 1 with WHERE removed and COUNT the ids. 
*/
SELECT COUNT(*)
    FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id;

/* 
    Run query in 5 but with questions in 2 through 4.
*/
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc,
       a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) std_qty, 
       COALESCE(o.gloss_qty, 0) gloss_qty, COALESCE(o.poster_qty, 0) poster_qty, o.total, COALESCE(o.standard_amt_usd, 0) std_amt, 
       COALESCE(o.gloss_amt_usd, 0) gloss_amt, COALESCE(o.poster_amt_usd, 0) poster_amt, COALESCE(o.total_amt_usd, 0) total_amt
    FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id;
