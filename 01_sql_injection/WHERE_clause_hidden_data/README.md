# Write-up: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data @ PortSwigger Academy

![Lab title](img/title.png)
![Lab objective](img/description.png)

Lab-Link: <https://portswigger.net/web-security/sql-injection/lab-retrieve-hidden-data>  
Difficulty: APPRENTICE

## Objective
Have the website display unreleased projects by injecting an exploit.

## Exploitation
First, I chose a category (i.e. "Gifts") to see what the URL would show regarding the query. The payload showed `/filter?category=Gifts`. I know from the lab description that this is equivalent to the query

```sql
SELECT * FROM products WHERE category = 'Gifts' AND released = 1
```

I am assuming that the category parameter `Gifts` is taken directly from the URL. To show unreleased products, I need to make `AND released = 1` be ignored. If I inject `Gifts'--`, the query becomes

```sql
SELECT * FROM products WHERE category = 'Gifts'--' AND released = 1
```

I used the quotation mark to close the parameter string, and `--` to comment out the rest of the query. Now, the query does not only select products that have the released flag. In the URL, I inject

![Malicious payload](img/payload.png)

and the screen goes from showing 3 products to 4, proving that the released part of the query was ignored.

In order to display all products, including unreleased, regardless of category, I need to construct a query that evaluates to `TRUE` for every table entry. If I inject `Gifts' OR 1=1--`, the query becomes

```sql
SELECT * FROM products WHERE category = 'Gifts' OR 1=1--' AND released = 1
```

`1=1` always evaluates to `TRUE`, and everything after is commented out and ignored. When injecting via Burp Suite, the payload in the URL needs to be encoded via `Cmd+U`.

![Malicious payload](img/payload2.png)

The page changes to show all products and displays

![Success banner](img/success.png)