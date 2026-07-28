# Write-up: SQL injection UNION attack, finding a column containing text @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security/sql-injection/union-attacks/lab-find-column-containing-text>  
Difficulty: PRACTITIONER

![Lab description](img/description.png)

## Exploitation
The objective was to make the database retrieve the string `Vv7Qcz`. Ultimately, I would attempt to inject a UNION query to accomplish this, but I first needed to figure out how many columns the website returned from the database. I was told the vulnerability was in the product category filter, so I chose a category and intercepted the request. I was able to see the payload `/filter?category=Gifts` and, using the [UNION column count method](https://portswigger.net/web-security/sql-injection/union-attacks/lab-determine-number-of-columns), I determined the query returned 3 columns.

Next, I needed to determine which columns could hold a string data type so that it could retrieve my string. I started by trying to inject the string `abc` into the first column:

![Payload](img/payload.png)

and received an internal server error. This meant the first column did not return the string data type. I tried again with the second column:

![Payload 2](img/payload2.png)

and the request went through. This was validated by the `abc` shown among the product list:

!['abc' retrieval](img/abc_retrieval.png)

Now, I could inject the string given by the lab.

![String retrieval](img/string_retrieval.png)

![Success banner](img/success.png)