## Windows

Windows stores passwords as NTLM hashes. These hashes are not salted, making them vulnerable to dictionary and rainbow table attacks.

These NTLM hashes are located in C:\Windows\System32\Config\SAM
The SAM file is locked while windows is running so you have to use tools like pwdump, samdump2, or mimikatz to extract the hashes.

# NTLM Examples

- Hello - 916A8E7B1540EC179F196F8DDB603D85
- Cybersecurity - 3556E3C87B02510B35B7718B03EDC2ED
- Austin hashed this - 39F5525B291C8AF239B018541BA55601

# Ophcrack

Ophcrack can be in installed on Windows or linux.

[Windows download](http://ophcrack.sourceforge.net/download.php?type=ophcrack) When downloading on Windows it will try to block download due to looking like a virus.

Linux download - sudo apt install Ophcrack

Must download XP [special wordlist](https://sourceforge.net/projects/ophcrack/files/tables/XP%20special/)

Load the hashes into Ophcrack then click crack.

Ophcrack has multiple tables you can use to crack passwords on different windows versions. 