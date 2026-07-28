# Write-up: SQL injection vulnerability allowing login bypass @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security/sql-injection/lab-login-bypass>  
Difficulty: APPRENTICE

![Lab description](img/description.png)

## Exploitation
I assumed that the query to log in looked something like 

```sql
SELECT * FROM users WHERE username = '<USER>' AND password = '<PASS>'
```

When I attempted to log in as user `hello` and password `bye` and intercepted the request via Burp Suite, I could see the POST data:

![Payload](img/payload.png)

I wanted to bypass the need for a password by commenting it out of the query. Just like URL parameters, the username field was vulnerable to injection. Thus, I logged in with the username `administrator'--` in the website's login field. The password did not matter since it would not be used. This allowed me to successfully log in as the administrator:

![Administrator account](img/admin.png)

![Success banner](img/success.png)