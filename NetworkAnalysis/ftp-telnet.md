## FTP  

### What was the first username:password combination attempt made to log in to the server? (e.g. user:password)  

* Method 1
    - Load the ftp.pcap file in wire shark.
    - Right click on the first packet, select follow TCP stream

```
220-FileZilla Server 0.9.53 beta
220-written by Tim Kosse (tim.kosse@filezilla-project.org)
220 Please visit https://filezilla-project.org/

USER user1

331 Password required for user1

PASS cyberskyline

530 Login or password incorrect!

QUIT

221 Goodbye
```  
---
### What software is the FTP server running? (Include name and version)  

You can filter specifically for the server's welcome message.

Step 1: Apply the Filter  

In the Wireshark display filter bar, type the following query to isolate the specific FTP response code used for server greetings:
`ftp.response.code == 220`

Step 2: Inspect the Info Column  

Look at the Info column for the very first packet that appears. The server will usually state its software and version directly in this line (e.g., Response: 220 (vsFTPd 3.0.3) or Response: 220 ProFTPD 1.3.5a Server).

Step 3: Extract the Data  

Simply pull the name and the version number from that response to format your answer.  

![Wireshark Packet](./ftp-telnet/Screenshot%202026-02-25%20152953.png)  
---
### What is the first username:password combination that allows for successful authentication? (e.g. user:password)  

Load the Pcap file. Look at the last column "length info". Follow the packets until you see the first user "logged on".

`Response: 230` shows logged on on No.12. Back track two packets to see the user and pass.

user1:metropolis  

---  

### What is the first command the user executes on the ftp server?  

Look at packet 15, in the "length info" column after response code 230 `REQUEST: LIST` is the fist command. `LIST`

###  What file is deleted from the ftp server?  

Wireshark filter `ftp.request.command == "DELE"`

The deleted file is bank.cap.  

### What file is uploaded to the ftp server?  

FTP protocol, the command a client sends to upload a file is STOR (short for Store).

Wireshark filter `ftp.request.command == "STOR"`

Frame 23 compcodes.zip

### What is the filesize (in bytes) of the uploaded file?

Wireshark filter `ftp.response.code == 226`

Often, the server will append the exact size to the success message. It will look something like:
Response: 226 Transfer complete. 4821 bytes received.
If your server is configured this way, that number is your answer!

#### Alternate method

- Wireshark filter `ftp-data`. Look for the first instance of STOR compcodes.zip. Manually add up all the bytes related to the file transfrer.

### What file does the anonymous user download?

- Wireshark filter `ftp.request.command == "USER" || ftp.request.command == "RETR"`

Right click on the first frame that you see for USER anonymous. Click follow tcp stream. Look for the first file successfully downloaded in the stream. `compcodes.zip`


## Telnet  

When analyzing Telnet traffic, the most important thing to remember is that, just like FTP, it is completely unencrypted. Everything is sent in cleartext.

However, Telnet has a unique quirk: as a user types, the client often `sends the data one character at a time in separate packets, and the server echoes each character back`.

### What is the username that was used to log in?

Isolate the traffic by protocol in Wireshark. Right click on the first telnet frame and follow TCP stream.  

Blue Text: This is the data sent by the server (the prompts and echoes).

Red Text: This is the data sent by the client (what the user actually typed).

```
........... ..!.."..'.....#
..... ..#..'........!.."..... .....#.....'.........
....P...... .38400,38400....#.Sandbox:0.0....'..DISPLAY.Sandbox:0.0......xterm..
...
...
...
...
login: 
t
t
e
e
s
s
t
t

.

Password: 
capture
.

$ 
u
u
n
n
a
a
m
m
e
e
 
 
-
-
a
a

```
Notice how the server echos back the characters.  

### What is the password that was used to log in?  

capture.


The password does not get echoed back so it is in all red. 

### What command was executed once the user was authenticated?

uname -a

### In what year was this capture created?  

2011

### What is the hostname of the machine that was logged in to?

When the user executed the command uname -a, the server responded back with `Linux cm4116 2.6.30.2-uc0 #3 Tue Feb 22 00:57:18 EST 2011 armv4tl unknown`

The hostname is cm4116.

### What CPU architecture does the remote machine use?

The fifth field in that string represents the hardware platform. In this case, armv4tl indicates it is running on an older ARM architecture (specifically ARMv4 with Thumb support and Little-endian byte ordering), which is very common for embedded devices like routers or IoT hardware.

`Linux` `cm4116` `2.6.30.2-uc0 #3` `Tue Feb 22 00:57:18 EST 2011` `armv4tl` `unknown`

Kernel Name: Linux

Hostname: cm4116

Kernel Release: 2.6.30.2-uc0

Kernel Version: #3 Tue Feb 22 00:57:18 EST 2011

Machine Hardware (CPU Architecture): armv4tl

Operating System: unknown

The fifth field in that string represents the hardware platform. In this case, armv4tl indicates it is running on an older ARM architecture (specifically ARMv4 with Thumb support and Little-endian byte ordering), which is very common for embedded devices like routers or IoT hardware.