# CAN Bus challenge

Wireshark is a graphical interface for tshark. Tshark is a tool for inspecting network traffic using either your current traffic by reading right from your network cards, or from PCAP files which are just large detailed logs of all the things tshark would capture from network traffic it inspects. I am going to primarily use tshark as it outputs to command line where I can grep, cut, sort, etc, and that makes it FAR easier to analyze than using the interface and trying to figure out how to copy those functionalities from the GUI.

## How many unique CAN Bus IDs are present in this capture?

`tshark -r Candump.pcap -T fields -e _ws.col.Info | cut -d' ' -f 2 | sort -u | wc -l`

The -r tells tshark that it is looking at a pcap rather than trying to connect to a network interface etc, -T controls it so that it seperates the info by fiels, which can then be used to filter to just the column, the -e and argument after is to tell it to only output the info column. You can figure out column needed by doing a general output and running head on it or something similar to just see what information is where, or what I did which is opening wireshark and looking at it. I then cut to get just the ID number for the question, -d tells it how to seperate "columns" in the output, and -f tells it I want the "second" column, then sort with -u to get only unique id numbers, and then wc -l to count how many there are. The answer is 36.

##
