
# Title: Network Traffic Analysis - Packet disection

### Problem description

This challage ask you to look thru the hex dump they aquired and find out what happend or what it is.

### Tools

i used `tshark` and `wireshark` to get the info and 

### Solution

the task is to take a snipit of text that is a hash dump and get it into a readble format to derive information from it.

### Write up

to do this gym i had to take the given text and turn it into a PCAP to let `wireshark` read it.
if you have wireshark on wsl you can use `Text2Pacp` whish makes the prosses easy.

after using Text2Pcap you will have a file that tshark or wireshark can read.

you will get a broken bit of text you will have to decode and find out which part means. 

the trasaction id is the `first 2 sets of byts` of a dump.

the total number of recods in the packet is the inital connection then any other sites if called for

the domain was a call to a `.com` site. 

the record type will come befor the domain in a `2 letter` abriviation

i had to use AI to help with this one as i can only see bits of info but the highst priorty was the first one with the domain `value of 1`.