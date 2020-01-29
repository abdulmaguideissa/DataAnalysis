/*
    COUNT is a function to count the number of rows in a table.
    COUNT the Number of Rows in a Table accounts.
*/
SELECT COUNT(accounts.id)
    FROM accounts;

/* 
    The above is equivalent to the next statement, with no NULLs. COUNT does not
    include the NULL rows in the result.
*/
SELECT COUNT(*)
    FROM accounts;