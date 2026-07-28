# Write-up: SQL injection UNION attack, retrieving multiple values in a single column @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security/sql-injection/union-attacks/lab-retrieve-multiple-values-in-single-column>  
Difficulty: PRACTITIONER

![Lab description](img/description.png)

## Exploitation
I start by determining how many columns the product category filter query returns and which ones can hold text, as I will need one to hold a list of concatenated usernames and passwords. Using methods from previous labs, I figure out that the query returns 2 columns, and only the second one can hold text.

Next, I draft a payload that will allow me to attach the usernames and passwords into the second column. Note that `||` is a string concatenation operator on Oracle. I inject the following text:

![Payload](img/payload.png)

and the success of this request is reflected in the updated page, now showing `<username>~<password>` among the product list:

![Page results](img/page_results.png)

I can now use the administrator credentials to log in.

![Login as administrator](img/login.png)

![Success banner](img/success.png)