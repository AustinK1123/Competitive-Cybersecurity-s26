# Solution Guide: National League Cyber Challenge (CAN Bus)

This guide provides a detailed, step-by-step walkthrough for solving the CAN bus reverse-engineering challenge using the provided source code and packet capture (`Candump.pcap`).

---

## 1. Challenge Overview
The goal is to extract vehicle speed information from a CAN network capture. We are provided with a snippet of C code that defines the logic used by the vehicle's instrument cluster to process speed data.

### Given Logic:
* **CAN ID:** `589` (0x24D)
* **Data Start Position:** Index 3
* **Byte Order:** Big-Endian (Motorola)
* **Resolution:** 0.01 (km/h per bit)
* **Unit Conversion:** 0.6213751 (km/h to mph)

---

## 2. Tools Required
To solve this efficiently, the following tools are recommended:
* **Linux (Kali/Parrot):** For `can-utils`.
* **Python:** For automated parsing.
* **Wireshark:** To inspect the `.pcap` structure.  
  - Wireshark is a graphical interface for tshark. Tshark is a tool for inspecting network traffic using either your current traffic by reading right from your network cards, or from PCAP files which are just large detailed logs of all the things tshark would capture from network traffic it inspects. I am going to primarily use tshark as it outputs to command line where I can grep, cut, sort, etc, and that makes it FAR easier to analyze than using the interface and trying to figure out how to copy those functionalities from the GUI.
* **SavvyCAN:** (Optional) For visual signal analysis.

---

## 3. Step-by-Step Solution

### Q1 - How many unique CAN Bus IDs are present in this capture?

`tshark -r Candump.pcap -T fields -e _ws.col.Info | cut -d' ' -f 2 | sort -u | wc -l`

The -r tells tshark that it is looking at a pcap rather than trying to connect to a network interface etc, -T controls it so that it seperates the info by fiels, which can then be used to filter to just the column, the -e and argument after is to tell it to only output the info column. You can figure out column needed by doing a general output and running head on it or something similar to just see what information is where, or what I did which is opening wireshark and looking at it. I then cut to get just the ID number for the question, -d tells it how to seperate "columns" in the output, and -f tells it I want the "second" column, then sort with -u to get only unique id numbers, and then wc -l to count how many there are. The answer is 36.

### Q2 - How many speed update messages are present in this capture?



### Q3 - What is the maximum speed, in mph, that this vehicle reached in the capture? (round to the nearest hundredth)

#### Step 1: Analyze the Protocol Logic
From the provided C code, we can derive the mathematical formula for the speed:
$$Speed_{mph} = \left( \frac{(Byte_3 \cdot 256) + Byte_4}{100} \right) \cdot 0.6213751$$

This tells us that the vehicle speed is a **16-bit integer** spanning bytes 3 and 4 of CAN ID **589**.

#### Step 2: Filter the Traffic
Using `candump` (part of `can-utils`), we can isolate the traffic for this specific ID. If you have the file as a PCAP, you can replay it or parse it directly.

**Command to isolate ID 589:**
```bash
# If using a live or virtual bus
candump vcan0,589:7FF
```

#### Step 3: Identify the Maximum Speed Packet
By scanning the log, we look for the highest values in the 4th and 5th bytes (index 3 and 4). 

**Key Packet Found:**
* **Packet No:** 6860
* **CAN ID:** `0x24D`
* **Data:** `00 00 00 0C A8 00 00 00`

#### Step 4: Manual Calculation
Let's break down the data from packet #6860:
1. **Extract Bytes:** Index 3 is `0x0C` (12), Index 4 is `0xA8` (168).
2. **Combine Bytes (Big-Endian):** $(12 \times 256) + 168 = 3240$.
3. **Apply Scaling:** $3240 / 100 = 32.4$ km/h.
4. **Convert to MPH:** $32.4 \times 0.6213751 = \mathbf{20.132...}$

#### Step 5: Automated Extraction (Python)
For a large capture, use Python to ensure accuracy:

```python
import struct

# Simplified parsing logic
raw_payload = bytes.fromhex("0000000ca8000000")
byte3 = raw_payload[3]
byte4 = raw_payload[4]

speed_kmh = ((byte3 << 8) | byte4) / 100.0
speed_mph = speed_kmh * 0.6213751

print(f"Max Speed: {speed_mph:.2f} mph")
```

---

### 4. Final Result
* **Maximum Speed Recorded:** `20.13 mph`
* **Hexadecimal ID:** `0x24D`
* **Peak Data Payload:** `0000000ca8000000`

---
