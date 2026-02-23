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

# Kali Linux Container

When using Ophcrack use the Kali Linux container provided.
When adding the xpspecial table it is located at `/usr/share/wordlists`.
Using this word list you should be able to crack all of the problems.

# Questions

1. 21259DD63B980471AAD3B435B51404EE:1E43E37B818AB5EDB066EB58CCDC1823
    `starf0x`
2. 11CB3F697332AE4C4A3B108F3FA6CB6D:13B29964CC2480B4EF454C59562E675C
    `P@ssword`
3. 65711C079DC4CD3CC2265B23734E0DAC:47F747C5190DC0F0B921AA4A07F06285
    `footba11`
4. FBBDA33FC12E83FB0C240E84A183686E:DDE9DC6E34E2E6E11EF9E51C6B27ED96
    `1trustno1`
5. 21C4E7C2EFE8E8D1C00B70065ED76AA7:A7A0F9AFD4A78F531A1CF4C42E531BBF
    `ectoplasm32`
6. E85B4B634711A266AAD3B435B51404EE:FD134459FE4D3A6DB4034C4E52403F16
    `"=Cxu&L`
7. BA756FB317B622DBAAD3B435B51404EE:C8405270B10B13AE8A24612BB853567A
    `yhM^GK7`
8. 199C926FA387EAB7AAD3B435B51404EE:F196F77BF8BB15781BA8364C649C5FD4
    `58?-<C6`
9. FE4AACAAAD7D986AAAD3B435B51404EE:3928E16F614E2316CA51C336FA5B3011
    `$xEn@=y`
10. 3613F7EC15407F56AAD3B435B51404EE:C82E164316183AA3AF3EA6BAA642A237
    `^B7e3D;`