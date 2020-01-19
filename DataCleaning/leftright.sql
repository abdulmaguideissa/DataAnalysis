/*
    Data Cleaning functions. LEFT & RIGHT Quiz.
    In the accounts table, there is a column holding the website for each company. 
    The last three digits specify what type of web address they are using. 
    Pull these extensions and provide how many of each website type exist in the accounts table.
*/
SELECT RIGHT(website, 3) AS extension, COUNT(website) type_count
    FROM accounts
    GROUP BY 1
    ORDER BY 2;

/*
    There is much debate about how much the name (or even the first letter of a 
    company name) matters. Use the accounts table to pull the first letter of 
    each company name to see the distribution of company names that begin with each 
    letter (or number).
*/
SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(name) counts
    FROM accounts
    GROUP BY 1
    ORDER BY 2 DESC;

/*
    Use the accounts table and a CASE statement to create two groups: one group 
    of company names that start with a number and a second group of those company 
    names that start with a letter. What proportion of company names start with a letter?
    Soln: 350 company name with letter and only 1 with number.
*/
WITH cats AS (
    SELECT name,
        CASE WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')
            THEN 1
        ELSE 0
        END AS Numb, 
        CASE WHEN LEFT(UPPER(name), 1) NOT IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')
            THEN 1
        ELSE 0
        END AS Letter
        FROM accounts)
SELECT SUM(Numb) nums, SUM(Letter) letters
    FROM cats;

/*
    Consider vowels as a, e, i, o, and u. What proportion of company names start 
    with a vowel, and what percent start with anything else?
    Soln: 271 ordinary and 80 vowls in company names.
*/
WITH vowels AS (
    SELECT name,
        CASE WHEN LEFT(UPPER(name), 1) IN ('A', 'E', 'I', 'O', 'U')
            THEN 1
        ELSE 0
        END AS Vowel, 
        CASE WHEN LEFT(UPPER(name), 1) NOT IN ('A', 'E', 'I', 'O', 'U')
            THEN 1
        ELSE 0
        END AS Ord
        FROM accounts
    )
SELECT SUM(Vowel) vls, SUM(Ord) ords
    FROM vowels;