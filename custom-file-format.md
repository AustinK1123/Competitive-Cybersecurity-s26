# Guide: Parsing the SKY Custom Binary Log
**Objective:** Decode a proprietary binary format to extract network host information, flags, and traffic statistics.

---

## 🏗️ 1. Understanding the File Structure
Before running commands, we must map out the bytes based on the provided specification. The SKY format uses **Big-Endian** notation (most significant byte first).

### **Header Map (Starting at Offset 0)**
| Field | Offset | Size (Bytes) | Data Type |
| :--- | :--- | :--- | :--- |
| **Magic Bytes** | 0 | 8 | Hex (0x91534B590D0A1A0A) |
| **Version** | 8 | 1 | Byte (0x01) |
| **Creation Timestamp** | 9 | 4 | Unix Timestamp |
| **Hostname Length** | 13 | 4 | Integer |
| **Hostname** | 17 | Dynamic | ASCII String |
| **Flag Length** | 31* | 4 | Integer |
| **Flag** | 35* | Dynamic | ASCII String (Base64) |
| **Number of Entries**| 55* | 4 | Integer |

*\*Note: Offsets for Flag and Number of Entries assume a 14-byte Hostname and 20-byte Flag as per the challenge walk-through.*

### **Body Item Map (16 Bytes per Entry)**
| Field | Offset | Size | Data Type |
| :--- | :--- | :--- | :--- |
| **Source IP** | +0 | 4 | IPv4 (Integer) |
| **Destination IP** | +4 | 4 | IPv4 (Integer) |
| **Timestamp** | +8 | 4 | Unix Timestamp |
| **Bytes Transferred**| +12 | 4 | Integer |

---

## 🛠️ 2. Step-by-Step Extraction

### **A. Extract Hostname & Flag**
To find the hostname and flag, we use `od` (octal dump) to read specific byte ranges.
1.  **Read Hostname Length (Offset 13):**
    ```bash
    od -j 13 -N 4 -t u4 --endian=big "Custom File Format.sky"
    ```
2.  **Read Hostname (Offset 17, Length 14):**
    ```bash
    od -j 17 -N 14 -t c "Custom File Format.sky"
    ```
3.  **Read Flag (Offset 35, Length 20):**
    ```bash
    # Extract the string and decode from Base64
    od -j 35 -N 20 -t c "Custom File Format.sky" | awk '{print $2$3$4...}' | base64 -d
    ```

### **B. Parse the Data Body**
The body starts at **Offset 59**. We will use `od` to format the binary data into a readable text file.


1.  **Generate a Hex Log:**
    This command skips the header, reads the body, and formats it into 16-byte rows (4 columns of 4-byte integers).
    ```bash
    od -j 59 -v -A n -t u4 --endian=big "Custom File Format.sky" > hex.log
    ```

2.  **Convert to Human-Readable Format:**
    Use `awk` or Python to convert the integers in `hex.log` into IP addresses and readable dates. 
    * **Column 1 & 2:** IPs (e.g., `192.168.1.1`)
    * **Column 3:** Timestamp (e.g., `date -d @<timestamp>`)
    * **Column 4:** Bytes

---

## 📊 3. Analyzing the Results

Once you have your `merged.log` (formatted as: `SrcIP DstIP Date Bytes`), use `awk` for high-speed analysis.

### **Total Transferred Bytes**
Sum the 4th column of your parsed log:
```bash
awk '{sum += $4} END {print sum}' merged.log
```

### **Find the Top Sender**
Identify which IP sent the most data:
```bash
awk '{sums[$1]+=$4} END {for (ip in sums) print sums[ip], ip}' merged.log | sort -rn | head -n 1
```

### **Identify the Busiest Day**
Group by the date column (Column 3) and sum the bytes:
```bash
awk '{sums[$3]+=$4} END {for (d in sums) print sums[d], d}' merged.log | sort -rn | head -n 1
```

---

## 💡 Key Tips
* **Big-Endian:** Always ensure your `od` or `python` script specifies Big-Endian (`>I` in Python struct) or the numbers will be gibberish.
* **Timestamp Conversion:** In Linux, convert a Unix timestamp quickly using: `date -u -d @1637500000`.
* **Unique IPs:** To count unique IPs across both columns:
    ```bash
    awk '{print $1; print $2}' merged.log | sort -u | wc -l
    ```

---