# Pandoras Box

pcap is a file that is essentiall just a log of internet traffic at a certain port.

Tshark - this is the backend that wireshark gives you a graphic interface for. It can scan pcaps, or an internet port to scan traffic live.

    - r - This flag tells tshark that you are sending it a pcap instead of a port for it to analyze.
    - Y - This flag gives you filter options like you would use in wireshark in the filter bar.
    - q - This flag tells tshark to ignore the normal packet information and only show "statistical" info, whatever is specified later
    - z - This option lets you define "statistics" options
    - T - This flag tshark how you want to output, fields is an option that says only specific fields should be displayed
    - e - This option lets you declare the fields to show.
    - q - This flag tells tshark to not give its usual packet analysis
    - z - This tells it to give you "statistics" on packets, and then the options fed to it tells tshark what statistics to show for which packets

## What is the IP address of the server?

`tshark -r pandora.pcap -Y "tcp && !(tcp.port == 22) && !(tcp.port == 80)"`

This command I got from the basic functionality of tshark, but the filter options I slowly built up trying to narrow down the output, and from reading the guide on their custom protocol. I am filtering so only TCP traffic shows, but not tcp traffic on the ssh port or http traffic, and then you will see the first packets are one of the "suspects" trying to connect to the server.

## What is the IP address of the client?

Same command, but just use the sending ip instead of the recieving ip.

## What port is the server listening on?

Same command again, but look at the port -> port part, and the listening port is the second one.

## What is the magic 2-byte ID in decimal representation? 
## Through
## What is the hidden flag being sent over the protocol?

`tshark -r pandora.pcap -Y "tcp && !(tcp.port == 22) && !(tcp.port == 80)" -T fields -e tcp.stream`

This command gives the tcp stream number you will need for the next command.

`tshark -r pandora.pcap -q -z "follow,tcp,hex,stream#"`

This command tells tshark to get the hex data for the stream of that user connecting. The first line that doesnt seem full is the number of encrypt requests, the second line is the "magic id" and then the third line, the first 4 bytes are the length of the first request. To find the second request you have to find the magic id again, and then the next 4 bytes are the next length. For the length of the encrypt hash, the first line that is tabbed over to the right is the first line of the response, and the first 4 bytes are the length, which you then divide by the number of requests to get the length of an individual. The first encrypt response is the first 32 bytes that are offset to the right as that is the length of each encrypt response. For the last question you just copy the base64 data in the far right columns and use a base64 decoder, I used cyberchef for this, as the simple operations like this are the one time I like it, though I am sure vim and even command line can do it. The one thing that can make cyberchef easier is you have to subtract the part that is for the length of each request, so for the first request, where 0x58 is the "length" bytes, you need to subtract 88 from the "XTkNM" part, or 0x58, because it throws off the decryption, and if its off by a character it doesnt always recover, the last two requests seem to recover well and give all the info, but thats just a fluke of alignment.
