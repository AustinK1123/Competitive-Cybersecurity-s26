## Cyber Chef  
[Visit CyberChef](https://gchq.github.io/CyberChef/)
---
## Background
CyberChef is a web application that can be used to perform multiple operations related to cybersecurity. The operations range from simple encoding/decoding to complex encryption/decryption. Some of the operations are:

- Base64 encoding and decoding  
- Caesar cipher  
- Hashing, e.g. MD5 and SHA  
- ROT13 cipher  
- Railfence cipher  
- XOR 
- Morse code  
- AES encrypt and decrypt and more....

## History
CyberChef was developed by an analyst at GCHQ, which then decided to make it publicly available and open source. Anybody can contribute to its development. 

CyberChef is still under active development, please do not use it for anything that requires reliability or stability. CyberChef is also released under the Apache 2.0 license.

CyberChef, often called the "Cyber Swiss Army Knife," is a web-based application developed by GCHQ (the UK's intelligence and security agency). It is designed to perform all manner of "cyber" operations—encoding, decoding, formatting, and parsing data—quickly and easily within a browser.

It is widely used by security analysts, developers, and IT professionals to manipulate data without writing complex scripts.

# NCL Deployment

1. Cryptography (Primary Use Case)

    - This is where CyberChef shines the most. NCL crypto challenges often involve "encoded" strings rather than military-grade encryption.

    - Layered Decoding: Flags are often hidden behind multiple layers of encoding. You can build a "Recipe" to peel these back one by one.  
    
      Example: A flag might be encoded in Base64, then converted to Hex, then Rotated (ROT13). In CyberChef, you can drag and drop From Base64 -> From Hex -> ROT13 into the recipe area to see the result instantly.

    - The "Magic" Wand: When you don't know what encoding is used, the Magic operation attempts to guess the encoding based on common patterns and file headers. This is invaluable for beginners who cannot yet recognize Base64 or Hex by sight.

    - Brute Forcing: For simple ciphers like XOR or Caesar Box, CyberChef has built-in "Brute Force" operations that will display all possible shifts or keys, allowing you to visually pick the one that looks like English/Flag text.

2. Log Analysis  

    - NCL Log Analysis challenges often require you to parse messy server logs to find specific IP addresses, timestamps, or error codes.

    - Data Extraction: You can use the `Extract IP addresses`, `Extract URLs`, or `Extract Email Addresses` operations to instantly pull relevant data out of a massive log file.

    - Timestamp Conversion: Logs often use "Epoch time" (e.g., `1612345678`). CyberChef has a From UNIX Timestamp operation that converts these into human-readable dates (like `Mon, 22 Sep 2025`), which is essential when a question asks "At what time did the attack occur?"

    - Filtering: You can use `Find / Replace` or `Regular Expression` operations to remove noise and isolate the specific user or event the question asks about.

3. Forensics & Enumeration

    - File Analysis: If you extract a weird text string from a hidden file or image (Steganography), you can paste it into CyberChef to see if it decodes into a file signature (like `PK` for a zip file or `JFIF` for a JPEG).

    - De-obfuscation: Malware or scripts found in the Enumeration category often use `URL encoding` or `JavaScript packing` to `hide commands`. CyberChef can reverse this (e.g., URL Decode) to reveal the malicious command.

# Why use it?        

- Client-Side Security: It runs entirely in your browser. You can download the HTML file and run it offline, which is safe for analyzing potentially malicious strings without sending data to a server.

- Speed: Dragging blocks is significantly faster than writing a script to decode Base64 during a timed competition.

Sources  
VIDEO: [Cyber Skyline Live: Cracking Crypto with Cyberchef - March 23, 2023](https://youtu.be/wDPDh083cEM)  
ARTICLE: [CyberChef: Securing Cyber Space](https://www.infosectrain.com/blog/cyberchef-securing-cyber-space)

# quipquip

 Quipqiup is a fast and automated cryptogram solver. It can solve simple substitution ciphers, cryptoquips, patristocrats and more. The great thing about Quipquip is that you don't need to do anything grand, all you have to do is paste the encrypted text, hit Solve and wait for a few seconds. Quipquip will then try to find what encryption method was used and try to decrypt the text.  

![quipquip]("C:\Users\Veteran\Documents\GitHub\Competitive-Cybersecurity-s26\Cyber-Chef-Cipher.png")  

[QuipQuip: beta3](https://quipqiup.com/)

# Command Line Tools for Images

* `exiftool`
    - Parses the files headers to display data about how the file was created and handled



* `strings` command to check for anamolies in the header and footers of file
    - `strings -n 10 <example-image.jpg>`
    - `strings -t 10 <example-image.jpg>`

* hex dump  
SOFO (Start of Frame) Marker check  
    - xxd Steg1.jpg | grep "ffc0" -A 1

## Anamolies to look for
1. Mismatched Dimensions
2. Suspicious "Comment" or "Warning" Fields
3. Unusual Software or Profiles
4. Appended Data (Trailing Bytes)
5. Time Discrepancies

# Command-Line References

| Tool & Command | Practical Example | Why Use It (Intent) |
| :--- | :--- | :--- |
| **`strings`** | `strings Steg1.jpg | tail -n 20` | To find plain-text flags (like `SKY-TVJI-2063`) that are often appended after the binary image data. |
| **`grep`** | `strings Steg1.jpg | grep -i "CTF"` | To filter through thousands of lines of code to isolate specific flag patterns or keywords. |
| **`binwalk`** | `binwalk -e Steg1.jpg` | To detect and automatically extract hidden files (like a ZIP or second JPEG) embedded inside the carrier file. |
| **`exiftool`** | `exiftool -Comment Steg1.jpg` | To read hidden text inside metadata fields that are invisible to standard image viewers. |
| **`xxd`** | `xxd Steg1.jpg | head -n 20` | To inspect "Magic Bytes" (like `ffd8`) and headers to verify file integrity and look for manual tampering. |
| **`head` / `tail`** | `tail -c 100 Steg1.jpg` | To isolate the very end of a file where hackers commonly "paste" extra data after the End of Image marker. |
| **`md5sum`** | `md5sum Steg1.jpg` | To generate a unique "fingerprint." Sometimes the MD5 hash of the file itself is the required flag. |
| **`base64`** | `echo "ZmxhZw==" | base64 -d` | To translate "obscured" text (strings ending in `=`) back into readable English or binary. |

---

## Forensic "One-Liners" (Cheat Sheet)

Use these combinations for faster analysis during time-sensitive challenges:

### 1. The Keyword Sweep
Find any flag-related string regardless of case sensitivity:
`strings Steg1.jpg | grep -iE "flag|ctf|key|secret|pass"`

### 2. Recursive Extraction
Scan for hidden files and attempt to extract them into a folder:
`binwalk -re Steg1.jpg`

### 3. The "Tail" Hunt
Look for plain-text data appearing specifically after the JPEG "End of Image" marker (`FF D9`):
`xxd Steg1.jpg | grep -A 5 "ffd9"`

### 4. Base64 Discovery
Identify long continuous strings (20+ characters) that match the Base64 alphabet:
`strings Steg1.jpg | grep -E "[a-zA-Z0-9+/]{20,}"`

---
*Reference generated for Cybersecurity Lab: Strings (Easy)*
