# TODO Gym

In this gym we are entering java script (.js) into the entry filed because the sites .js file that read the script has no formatting on entry check allowing us to use `XSS` exploitation. With this we will enter a script to be saved so that anybody else that enters the site will run the script and display what we are looking for.

If we were to inspect the button to see what it does, then we would find  
`<button class="ui blue fluid button" type="submit">Add Item</button>`  
This tells us it’s a button that uses a submit for labeled function add item.

To find the `Add item` function we will have to look for a main.js file.

![image](/Web-App/Image/TODO-function.png)

in the function we find the fetch command to retrieve the information sent to the server.  
Then we can modify it to fit our needs.

`<script>
fetch('/item', {
    method : 'POST',
    headers : {
      'Content-Type' : 'application/json',
    },
    body : JSON.stringify({ item : btoa(#replace#) }),
  });
  </script>`

Looking at the function it looks like it is taking the value you input and using stringify to add it to the list.  
To get the info we want we are going to use an XSS exploit as the data that is sent is not filtered and get the host to send info from the server side.

To do this we will take the script used to send the entry back to your page and edit it.  
Instead of sending back the value you sent we will tell it to send cookies back with `document.cookie` put it in the #replace# spot.

To find the user agent we will use the same script, but we are going to be looking for `navigator.userAgent` put it in the #replace# spot.

Once you have entered the script you may need to refresh to see the data populate.  
![image](/Web-App/Image/TODO-Fullv2.png)

