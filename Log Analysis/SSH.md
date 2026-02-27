## SSH

SSH is a service that allows a device to provide remote terminal access. If you’re unfamiliar with SSH logs, you can query the internet to find out more about how they are structured and what different terms used in the log mean. The message field will often include warnings or errors. The event details field will include when sessions initiate or authentication attempts. Looking more closely at the messages, it’s evident that connections are coming from various IP addresses for the same user in a very short amount of time. That seems like odd behavior for a legitimate user trying to login; therefore, looking at the “Failed password” attempts is critical to finding which IP addresses are attacking the server and which account is being targeted.

# Questions
1. What is the hostname of the SSH server that was compromised?
This can be solved by finding the hostname, which is listed directly after the timestamp for each entry in the log.
---
Oct 11 10:12:00 myraptor sshd[29459]: Server listening on 0.0.0.0 port 22.
---
myraptor

2. What was the first IP address to attack the server?
This can be solved by identifying the IP address of the attacker in the first “Failed password” entries. 

`grep Failed auth.log`
---
Oct 11 10:12:25 myraptor sshd[29465]: Failed password for harvey from 169.139.243.218 port 57273 ssh2
---
169.139.243.218

3. What was the second IP address to attack the server?
This can be solved in the same way as the previous question by looking at the subsequent “Failed password” entries.

`grep Failed auth.log`

4. What was the third IP address to attack the server?
This can be solved in the same way as the previous question by looking at the subsequent “Failed password” entries.

`grep Failed auth.log`

5. Which user was targeted in the attack?
This can be solved by identifying the name of the account that had failed password attempts. Search for “Failed password” and then look for the account name. 

`grep Failed auth.log`

harvey

6. From which IP address was the attacker able to successfully log in?
This can be solved by searching for the entry that has “Accepted password”.

`grep Accepted auth.log`
---
Oct 11 10:36:59 myraptor sshd[30003]: Accepted password for harvey from 30.167.206.91 port 55326 ssh2
---