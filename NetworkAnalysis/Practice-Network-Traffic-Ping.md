
# Title: problem name / number / identifier

### Problem description

The point of this challage is to take the .PCAP file and find whats the hiiden flag

### Tools

I had to use `tshark` , `dd` , `grep` , `feh`.

### Solution

I was unable to complete the ping challenge and wanted to at least share my progress

### Write up


to start you will need to pull the outgoing packets with
```
tshark -r ping.pcap -Y "icmp and frame.len > 200" -T fields -e data > icmp.data
```
After I used vim icmp.data to look at the file and manually get rid of the tunnel headers

then in the file i used the command below to look for the beginning and end of the jpeg (FF D8 and FF D9)

```
START=$(grep -oba $'\xff\xd8' dump.bin | head -1 | cut -d: -f1)  
END=$(grep -oba $'\xff\xd9' dump.bin | tail -1 | cut -d: -f1)  
```

then to extract the JPEG i used
```
dd if=dump.bin of=fixed.jpg bs=1 skip=$START count=$((END-START+2)) status=none  
```
then i used file and feh to check and try to view the image
file fixed.jpg
feh fixed.jpg