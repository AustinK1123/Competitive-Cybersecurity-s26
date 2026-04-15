## History
The tool used for this challenge is **`sqlite3`**

**Helpful commands**   
`.help` - See all avaliable dot commands  
`.databases` - Show current database connections  
`.tables` - View tables in the database  
`.schema` - View the schema (structure) of the tables  
`.quit` - Exit the SQlite prompt  
`.mode column` - Displays the data with columns  
`.headers on` - Adds headers to column  

**Run these commands to get started with the data.**

`sqlite3 browser.sqlite`  
`.tables`  
 `SELECT * FROM moz_hosts;`  
 `.headers on`
 `.mode column`

```
292|https://blockchain.info/tx/5274cfba585a4b5681527a37f95c76340428916bb7480cef6c545f0a28dcd2d7|Bitcoin Transaction 5274cfba585a4b5681527a37f95c76340428916bb7480cef6c545f0a28dcd2d7|ofni.niahckcolb.|1|0|0|16|-1|1443893741687300|j7U3OZdoQwLM|0
```
- Question 1
What did the user search for on craigslist?
The user’s search can be seen in row 23 inside the “query’ parameter in the URL

- Question 2
What was the current price of bitcoin when the user was browsing?  
The current price is listed in row 23 in of the “title” of Bitstamp’s homepage.  

- Question 3  
What Bitcoin exchange did the user log in to?  
The Bitcoin exchange is identified in row 253, which shows the user successfully loading their account page after logging in. 

- Question 4  
What is the email that was used to log into the exchange?    
The email can be found on row 47 in the “title” of the Gmail webpage. 

- Question 5  
What was the ID of the Bitcoin transaction that the user looked at?
Answer: 5274cfba585a4b5681527a37f95c76340428916bb7480cef6c545f0a28dcd2d7

- Question 6  
What was the total BTC of all the inputs of the Bitcoin transaction?
Answer: 0.22616302  
If you visit the link when the transctions took place, https://blockchain.info/tx/5274cfba585a4b5681527a37f95c76340428916bb7480cef6c545f0a28dcd2d7, you can see the transaction amounts (2 inputs, .01872 BTC and .03896302 BTC)  

- Question 7  
Which bitcoin address received the majority of the Bitcoin in the transaction?
Looking at the same URL from question 6, look at the right side of the site to see the transactions. In the "To" column, the most BTC (.1872) was sent to `18z6bTFjxkXCmhfp8YBetR2wgmoVjXGJZz`.


## Custom File Formats




### How many unique usernames appear in this log?  
`awk '{print $4}' login.log | sort | uniq | wc -l`

Here are the detailed steps explaining how this pipeline works:

awk '{print $4}' login.log: This command reads the file line by line and extracts only the fourth column, which contains the usernames.

sort: The extracted usernames are then piped into sort. This arranges all the usernames in alphabetical order, grouping any identical names together. This step is mandatory because uniq only detects duplicates that are adjacent to each other.

uniq -d: The -d (or --repeated) flag tells uniq to completely ignore unique lines and only print the items that appear more than once.

If you also want to see exactly how many times each of those duplicate usernames logged in, you can swap -d for -c (count) and add a numerical sort:  
  
### What is the username with the most login attempts?  
`awk '{print $4}' login.log | sort | uniq -c | awk '$1 > 1' | sort -nr`  

uniq -c: This counts the consecutive occurrences of each username and prints the count next to the name (e.g., 5 admin).

awk '$1 > 1': This evaluates the first column of the new output (the count number) and filters the results to only show lines where the count is greater than 1.

sort -nr: This performs a numerical sort (-n) in reverse order (-r), pushing the usernames with the highest number of duplicate logins to the very top of your terminal output.  

What is the date with the most login attempts?  

`awk '{print $1}' login.log | sort | uniq -c | awk '$1 > 1' | sort -nr`

### What is the username that had logins from the most unique IP addresses?  

`awk '{print $4, $3}' login.log | sort | uniq | awk '{print $1}' | sort | uniq -c | sort -nr`

`awk '{print $4, $3}' login.log`: Extracts only the Username and the IP address.

`sort | uniq`: Removes duplicate pairings. If a user logs in 50 times from the exact same IP, it is reduced to a single line.

`awk '{print $1}'`: Extracts just the Username from that deduplicated list.

`sort | uniq -c`: Counts how many times each username appears (which now equals their total number of unique IP addresses).

`sort -nr | head -n 5`: Sorts the final count in descending numerical order and displays the top 5 targets.

## VSFTPD

Analyze a VSFTPD log file that we obtained.  

What IP address did "ftpuser" first log in from?  

What is the first directory that ftpuser created?  

What is the last directory that ftpuser created?  

What file extension was the most used by ftpuser?  

What is the username of the other user in this log?  
awk '{print $6 $7 $8}' vsftpd.log  
jimmy  

What IP address did this other user log in from?  
`cat vsftpd.log | grep "jimmy"`

How many total bytes did this other user upload?  
`cat vsftpd.log | grep "jimmy" | grep "UPLOAD" | awk '{print $15}'`

How many total bytes did ftpuser upload?  

How many total bytes did ftpuser download?  

Identify the IP address of the suspicious login (the login with no subsequent activity)  

 