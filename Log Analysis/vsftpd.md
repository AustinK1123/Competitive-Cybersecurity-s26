question 1, how i did it
in the downloaded file, look for the first instance of
ftpuser look for the first instance of this
OK LOGIN: Client "ip address"
the given ip address is the answer

q2 and q3  
search for MKD
ftpuser OK MKDIR: Client "10.0.0.123", "/home/ftpuser/FolderName" (find something like this)
first one is for question 2
last is for question 3

q4  
search for this 
STOR
RETR
STOR filename.jpg is what you wanna find
could also be png .txt, etc

q5  
What is the username of the other user in this log?  
awk '{print $6 $7 $8}' vsftpd.log  
jimmy  
OK LOGIN, search for this
youll see ftpuser and another name, the answer is ftpuser `Hint: no it isnt`

q6  
What IP address did this other user log in from?  
`cat vsftpd.log | grep "jimmy"`
OK LOGIN, search again, ip is next to user

q7  
How many total bytes did this other user upload?  
`cat vsftpd.log | grep "jimmy" | grep "UPLOAD" | awk '{print $15}'`
username OK UPLOAD search for this, an example would be
OK UPLOAD: Client "10.0.0.214", "/file.zip", 1048576 bytes, answer is bytes

q8 same as q7 but ftpuser OK UPLOAD

q9 ftpuser OK DOWNLOAD
add byte values and give final answer 

q10 OK LOGIN
check for ones with no actions after it, thats the one you want
