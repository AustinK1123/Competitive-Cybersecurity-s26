# This will be a writeup for "The Book" Challenge

This challenge primarily relies on volatility, though at least *SOME* other linux tools can be helpful. 

## Files

The files command gives information about a file based on its structure and/or magic bytes.

## Volatility

Volatility is a tool for analyzing memory extracted from a systems ram, know as a memdump. Volatility has a number of basic analysis tools built in such as malware detection etc, it also allows other tools to be connected as plugins. I was using both volatility3 and volatility2 through the provided container, neither of which worked perfectly for this though volatility3 seemed easier to me for the parts it worked for, which I now suspect is only limited because the challenge is broken.

### Challenge flags

To start you need to download the file, and then extract it. This will always be the case for memory dumps, in this case it is compressed with xz, so the command is `xz -d memdump.mem.xz`. The first question can be answered by running `file memdump.mem`.

`vol2 imageinfo -f memdump.mem` will return information wabout the image, it can give the same info as file, and needs to be run anyway to determine what profile to run volatility in as it will try some on its own, but it was unsuccessful in my case, the profile wasl `Win10x64`.

`vol2 envars --profile=Win10x64 -f memdump.mem` will return WAY too much info, but is a useful basis for a bunch of greps, you could even give it the good ol' `> envars.txt` and then `cat envars.txt | grep` for flags to not have to wait for it to run with seperate greps.

envars is just environment variables, for anyone that has taken any coding it is variables exactly as used in coding, but for the operating system and kernel to use as it runs.

`vol2 filescan --profile=Win10x64 -f memdump.mem` will return a list of files that were open at the time of the dump, this is useful for finding files that may have been used to exfiltrate data, or just files that may be interesting to look at.

You can grep the username in this case, in a broader context you could grep with negative matching to block out .dll's and any types of files that are going to be the system, or whatever you arent interested as you go to look around at less things, again `> somefile` is great for not rerunning across greps.


`vol2 -f memdump.mem --profile=Win10x64 dumpfiles -Q 'address of file above 0x0 format' -D 'directory you want to output it to'` will NORMALLY dump the file into your output directory, but is not currently working for me

at this point I *SHOULD* have documented better, but honestly if I had this would be monstrous. Chatgpt helped me figure out how to get part of the db that is apparently supposed to be what we get as output, and then use a strings filter to get out raw names, and then I guess the name, this took me hours, fuck this challenge.

`vol2 -f memdump.mem --profile=Win10x64 hashdump` will output a dump of the users hashes, and any NTLM cracker will be able to break it, I just used 'crackstation.net'
