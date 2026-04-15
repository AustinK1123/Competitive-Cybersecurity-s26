
# Title: Network Traffic Analysis - Weather

### Problem description

In this challage we are given a .log file which is packets sent between a device and weather information server. We are asked to find info from the logs

### Tools 

this Challage is relitivly easy as it is just reading the `Weather.pcap` and folowing the `TCP stream` with `tshark`.

### Solution 

After reading the logs in `wireshark` you can get a sence of the format and find information easly.

### Write up

the Command I used to view the file was `tshark -r Weather.pcap -z follow,tcp,ascii,0`.
reading the text i can make out a pattern for the days of the week with exact dates.

in the logs first it shows info on the app and device asking for the data.
Then in the next section it gives info on the server.

The later parts show data for each day using abreviations to substited for diffrent data points.  
```
<day d="7" t="Friday" dt="Feb 4"> = day of the week and date  
      <hi>62</hi> = high temprreture for the day  
      <low>41</low> = low temretue for the day
      <sunr>7:09 AM</sunr> = sun rise
      <suns>5:36 PM</suns> = sun set
      <part p="d"> = part of the Day -- day
        <icon>32</icon>
        <t>Sunny</t> = cloud cover
            <wind> = wind data item
             <s>6</s> = wind speed
            <gust>N/A</gust> = are there gusts
            <d>25</d> = 
            <t>NNE</t> = compass direction
            </wind>
        <bt>Sunny</bt>
        <ppcp>0</ppcp> = precipitation chance
        <hmid>58</hmid> = huminity
      </part>
      <part p="n"> = part of the Day -- night
        <icon>33</icon>
        <t>Mostly Clear</t>
        <wind>
          <s>3</s>
          <gust>N/A</gust>
          <d>33</d>
          <t>NNE</t>
        </wind>
        <bt>M Clear</bt>
        <ppcp>0</ppcp>
        <hmid>57</hmid>
      </part>
    </day>
```
