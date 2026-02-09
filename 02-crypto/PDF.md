## PDF

Using John and the Rockyou password list you can crack weak or commonly used passwords easily. PDF passwords can easily be cracked if the password is not strong its best practice to use a long unique password.

# John
[Openwall for John](https://www.openwall.com/john/)

Linux download - 'sudo apt install John'

To extract the PDF to hash: `pdf2john encrypted.pdf > hash.txt`

Have John check Rockyou list with hash given: `john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt`

To view password: `john --show hash.txt`