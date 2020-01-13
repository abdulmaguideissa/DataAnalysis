/*
    All the companies whose names start with 'C'.
    All companies whose names contain the string 'one' somewhere in the name.
    All companies whose names end with 's'.
*/
#!/usr/bin/sql -Y mysql:///

SELECT name 
	FROM accounts
    WHERE name LIKE 'C%'

SELECT name 
	FROM accounts
    WHERE name LIKE '%one%'

SELECT name 
	FROM accounts
    WHERE name LIKE '%s'