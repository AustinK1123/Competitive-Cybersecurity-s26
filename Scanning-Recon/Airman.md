# Airman Flag Challenge

This writeup is on the flag challenge assigned by Matt Kijowski on the "airmanjoe" AWS instance.

Nmap is a powerful network scanner that maps a network to discover devices, open ports, and operating systems, acting like a security inventory tool. The only option used for this tool is -p to control the ports to scan.

Nc (Netcat) is a versatile networking tool often called the "Swiss Army knife," used to read/write data across connections to test, transfer, or debug network traffic. The following flags could be helpful in solving these flags:
    -z (Zero-I/O Mode): Tells Netcat to scan for listening daemons without sending any data to them. It is used for scanning ports to see if they are open rather than initiating a full connection.
    -v (Verbose): Enables verbose mode, which provides detailed output about the connection status. Using it twice (-vv) increases verbosity.
    -l (Listen Mode): Instructs Netcat to listen for incoming connections rather than initiating a connection to a remote host.
    -p (Local Port): Specifies the local port to use for the connection. In listen mode, it defines the port Netcat will listen on

arp -a is a command to print everything in the systems arp table, this is what I used to find the ip of the target, though `nmap 10.0.0.100/24` can also be used to find all addresses on the local network.

The command `nmap -A -p1-65535 10.0.0.25` can be used to get the flags for port 80, 1337, 9999, and 25565, as well as a hint for port 156 and 10000, and some information about port 2049. 

The flag for port 80 can also be gotten with a wget request, it is a port for hosting webdata, and the flag is on the "home" page.

The flag for 156 you need to try 4 digit pins and then it gives the flag. The Seq command will print a sequence of numbers within a given range, it can be used to pipe into the nc scan to try pins. If you run `nc 10.0.0.25 156` once, you will see you get output about a hint, which is helpful when you try to run seq on it as you are going to want to ignore all the failed attempts. The command I came up with was `seq 1-9999 | nc 10.0.0.25 156 | grep -v "Hints"`. The first part runs everything after it 9999 times trying every number in the range of one to 9999, nc is routing those pin attempts to the desired ip and port, and then grep -v is telling it to look for lines that DO NOT contain the word "Hints". This gives just the flag.

`nc 10.0.0.25 1337` or the command mentioned earlier will get you the flag from that port, same as 9999. If you run `nc 10.0.0.25 100000` you will be told the flag is on port 11000, and the flag for 10000 can thus be gotten with `nc -lp 11000`. If you run nc on 25565 it asks for a password with the hint that it is name of the game generally run on that port, but the nmap scan tells you that is minecraft, so you put in the password and get the answer.

port 2049's flags can both be gotten by using the setuid command in airmanjoe's home directory to set the user as airmanbob and then same idea for airmancharles except you have to make a new user. The home directories of the 3 users are actually on 10.0.0.25, and mounted to the local system, switching to the user that owns bobs directory lets you read it, but for charles there is no local user, and because the remote system only checks the user_id number, any new user made will have the next available uid, and thus will be given access to that directory.



80/tcp    http                  it^works
156/tcp   sqlsrv                rowdy#raiders
1337/tcp  waste                 mad#skillz
2049/tcp  nfs                   bob: butter+chicken
                                charles: naturally$better
9999/tcp  abyss                 correct+horse
10000/tcp snet-sensor-mgmt      silent=deadly
25565/tcp minecraft             creeper/spider

