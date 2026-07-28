# Write-up: SQL injection UNION attack, retrieving data from other tables @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security/sql-injection/union-attacks/lab-retrieve-data-from-other-tables>  
Difficulty: PRACTITIONER

![Lab description](img/description.png)

## Exploitation
I start by determining how many columns the product category filter query returns and which ones can hold text, as they will need to hold a list of usernames and passwords. Using methods from previous labs, I figure out that the query returns 2 columns, both of which can hold text.

Next, I draft a payload that will allow me to attach the desired data into the product retrieval results. By injecting the following text, I am able retrieve data from the `users` table:

![Payload](img/payload.png)

Reminder that the injected payload must be encoded (i.e. `'+UNION+SELECT+username,+password+from+users--`) so that the URL can interpret it; Burp Suite does this for you. The success of this injection is validated by the updated page displaying usernames and passwords among the products.

![Page results](img/page_results.png)

Now I am able to log in with the administrator credentials.

![Login as administrator](img/login.png)

![Success banner](img/success.png)