# Write-up: Blind SQL injection with conditional responses @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security/sql-injection/blind/lab-conditional-responses>  
Difficulty: PRACTITIONER

![Lab description](img/description.png)

## Exploitation
I was told that the tracking cookie value was used for an SQL query, so I used this as my injection point. I assumed that the SQL query looked something like

``` sql
SELECT TrackingId FROM TrackedUsers WHERE TrackingId = 'abc'
```

where `TrackingId=abc` was the cookie value. First, I tested a query that should return True, and thus should cause the page to display "Welcome back". When I modified the payload to be 

`TrackingId=abc' AND '1'='1`

the page showed

![Welcome back message](img/welcome.png)

This made sense because `'1'='1'` evaluates to True. I tried again with `'1'='2'` and the "Welcome back" message disappeared, which checked out. Next, I validated the existence of the `users` table and the `administrator` username with the following inputs:

`TrackingId=abc' AND (SELECT 'a' FROM users LIMIT 1) = 'a`
`TrackingId=abc' AND (SELECT 'a' FROM users WHERE username = 'administrator') = 'a`

If the table and username existed, `'a'` would be selected, and `'a'='a'` would evaluate to True. Expectedly, the website showed the "Welcome back" message for both payloads. Next, I needed to figure out how long the password was. 

`TrackingId=abc' AND length(password) > 10`

I started by determining how many columns the product category filter query returned and which ones could hold text, as I needed one to hold a list of concatenated usernames and passwords. Using methods from previous labs, I figured out that the query returned 2 columns, and only the second one could hold text.

Next, I drafted a payload that would allow me to attach the usernames and passwords into the second column. Note that `||` is a string concatenation operator on Oracle. I injected the following text:

![Payload](img/payload.png)

and the success of this request was reflected in the updated page, now showing `<username>~<password>` among the product list:

![Page results](img/page_results.png)

I could then use the administrator credentials to log in.

![Login as administrator](img/login.png)

![Success banner](img/success.png)