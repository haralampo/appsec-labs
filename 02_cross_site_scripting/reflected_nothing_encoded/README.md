# Write-up: Reflected XSS into HTML context with nothing encoded @ PortSwigger Academy

![Lab title](img/title.png)

Lab-Link: <https://portswigger.net/web-security/cross-site-scripting/reflected/lab-html-context-nothing-encoded>  
Difficulty: APPRENTICE

![Lab description](img/description.png)

## Exploitation
I was told there was an XSS vulnerability in the search functionality, so I inserted a script in hopes that my text is directly echoed and run: 

`<script>alert()</script>`

Upon return, I received a success message:

![Success banner](img/success.png)