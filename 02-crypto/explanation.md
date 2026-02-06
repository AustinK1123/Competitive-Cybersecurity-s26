Who might use it 
Anybody might use it, primarily it would be those whom are trying to hack into more simple passwords systems, or people trying to practice with cracking hashes

What is it
John the ripper is a tool that is used to crack passwords and hashes, in order to install it run the following commands
sudo apt update
sudo apt install john -y

When would it be used
it would be used either during learning about hashcracking / practicing or by someone trying to hack something simple, with lower security as higher security john wouldnt work very well

Where would it be used
it would be used either in a student workspace, or by people practicing skills to unhack information or test cybersecurity strengths and weaknesses, it could also be used on the other side for people to test out lowend hacking

Why would it be used 
used to test hacking or to learn and test security systems that are set up

basic instructions on how to use john the ripper

First of all you need a password list, in this directory, 500_passwords.txt fills that role. 

you also need a pre hashed password (usually in a file)

500 passwords.txt would not be a good one for not the example im currently doing, because its only 500 options and the wordlist needs to actually have the 
password in it in order to 

important commands 
sha256sum, use this on the file that has your password to hash it, allowing john to break the hash
can also do sha512sum difference between sha 256 and sha 512 is amount of hashes  
john, used to hack the hash itself

johns syntax is as follows -
john (options) (hashfile) this is the basic context

john --wordlist=(wordlistname) (hashfile)
remove parenthesis and replace with the name of the files, for this one its 500_passwords.txt
and the hashfile isnt present but would be filename.hashes

how to see cracked passwords with john

john --show (hashfile)

to get a wordlist, either get one from online, which rockyou.txt is a very good one

you can also make one by just coming up with common passwords, but this is very slow

john has many permutations, some of which are l means lowercase u is uppercase c is capitalize, etc

these permutations are rules for how to use the command, you can also do rules=all when running john 
