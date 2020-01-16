/*
    The CASE statement always goes in the SELECT clause.

    CASE must include the following components: WHEN, THEN, and END. ELSE is an optional 
    component to catch cases that didn’t meet any of the other previous CASE conditions.

    You can make any conditional statement using any conditional operator (like WHERE) 
    between WHEN and THEN. This includes stringing together multiple conditional 
    statements using AND and OR.

    You can include multiple WHEN statements, as well as an ELSE statement again, 
    to deal with any unaddressed conditions.
    Example
*/
SELECT account_id, 
    CASE WHEN standard_qty = 0 OR standard_qty IS NULL
        THEN 0
    ELSE 
        standard_amt_usd / standard_qty END AS unit_price
    FROM orders
