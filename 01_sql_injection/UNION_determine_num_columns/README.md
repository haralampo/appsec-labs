# Write-up: SQL injection UNION attack, determining the number of columns returned by the query @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security/sql-injection/union-attacks/lab-determine-number-of-columns>  
Difficulty: PRACTITIONER

![Lab description](img/description.png)

## Exploitation
In order for a UNION query to succeed, the number of columns selected from the new table must match the number of columns selected from the initial table. This second value is currently unknown, so I am going to attempt to UNION an increasing amount of `NULL` columns and see if the results have any giveaways. I can use `NULL` because the columns being joined also have to match in data type, and `NULL` is convertible to every common data type.

I am told the vulnerability is in the product category filter, so I start by choosing a category and intercepting the request. By doing this, I can see the payload `/filter?category=Pets`. I try injecting `' UNION SELECT NULL--`, representing 1 column, and get an internal server error:

![Internal server error](img/error.png)

so I know the query doesn't return only 1 column. I try again, this time selecting 2 columns (2 `NULL`s) and receive the same error. I try with 3 columns:

![Injection with 3 NULLs](img/three_nulls.png)

and the request goes through:

![No server error](img/no_error.png)

Thus, I know the product category query returns 3 columns.

### Second method
Another method involves trying to order the query result by incrementing column indexes, such as `' ORDER BY 1--`. The idea is that, if you get an error, you were trying to order by a column that doesn't exist, and so you know that the query returns one less than that number of columns.

I start by ordering by column 1 and increment until I get an error. I get my first internal server error message when injecting `' ORDER BY 4--`, so I know there are 3 columns. This matches my result from using the first method.

![Success banner](img/success.png)