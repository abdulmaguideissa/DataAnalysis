/*
    DISTINCT is always used in SELECT statements, and it provides the unique 
    rows for all columns written in the SELECT statement. Therefore, you only 
    use DISTINCT once in any particular SELECT statement.
*/
/*
    Use DISTINCT to test if there are any accounts associated with more than one region.
*/
SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
    FROM accounts a
    JOIN sales_reps s
        ON s.id = a.sales_rep_id
    JOIN region r
        ON r.id = s.region_id;

/*
    Have any sales reps worked on more than one account?
*/
SELECT s.id AS "sales_id", s.name AS "sales_name", COUNT(*) Sales_Reps_Number
    FROM accounts a
    JOIN sales_reps s
        ON s.id = a.sales_rep_id
    GROUP BY s.id, s.name
    ORDER BY Sales_Reps_Number;