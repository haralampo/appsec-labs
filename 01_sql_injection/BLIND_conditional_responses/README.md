# Write-up: Blind SQL injection with conditional responses @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security/sql-injection/blind/lab-conditional-responses>  
Difficulty: PRACTITIONER

![Lab description](img/description.png)

## Exploitation
I am told that the tracking cookie value is used for an SQL query, so I'm going to use this as my objection point. I am going to assume that the SQL query looks something like

``` sql
SELECT TrackingId FROM TrackedUsers WHERE TrackingId = 'abc'
```

where `TrackingId=abc` is the cookie value. First, I'm going to test a query that should return True, and thus should cause the page to display "Welcome back". When I modify the payload to be 

`TrackingId=abc' AND '1'='1`

the page shows

![Welcome back message](img/welcome.png)

This makes sense because `'1'='1'` evaluates to True. I try again with `'1'='2'` and the "Welcome back" message disappears, which checks out. Next, I'm going to validate the existence of the `users` table and the `administrator` username with the following inputs:

`TrackingId=abc' AND (SELECT 'a' FROM users LIMIT 1) = 'a`
`TrackingId=abc' AND (SELECT 'a' FROM users WHERE username = 'administrator') = 'a`

If the table and username exist, `'a'` will be selected, and `'a'='a'` will evaluate to True. Expectedly, the website shows the "Welcome back" message for both payloads. Now I want to figure out how long the password is. 

`TrackingId=abc' AND length(password) > 10`

I start by determining how many columns the product category filter query returns and which ones can hold text, as I will need one to hold a list of concatenated usernames and passwords. Using methods from previous labs, I figure out that the query returns 2 columns, and only the second one can hold text.

Next, I draft a payload that will allow me to attach the usernames and passwords into the second column. Note that `||` is a string concatenation operator on Oracle. I inject the following text:

![Payload](img/payload.png)

and the success of this request is reflected in the updated page, now showing `<username>~<password>` among the product list:

![Page results](img/page_results.png)

I can now use the administrator credentials to log in.

![Login as administrator](img/login.png)

![Success banner](img/success.png)