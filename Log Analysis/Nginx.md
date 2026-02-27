## Nginx

Analyzing an nginx access log with commands like grep, sort, cut, etc. The nginx access log shows all of the users that have accessed the site and there IP addresses. The chart below shows all the commands used and what they do.

| Command | Purpose | Common Flags |
|---------|---------|--------------|
| `grep` | Search for a pattern in files or input | `-i` ignore case, `-r` recursive, `-n` line numbers, `-v` invert match, `-c` count matches |
| `egrep` | Extended grep (supports full regex) | Same as grep + `-E` enabled by default; supports `+`, `?`, `\|`, `{}` |
| `sort` | Sort lines of text | `-n` numeric, `-r` reverse, `-u` unique, `-k` sort by field, `-t` field delimiter |
| `cut` | Extract columns/fields from lines | `-d` delimiter, `-f` field number(s), `-c` character position(s) |
| `uniq` | Filter or report duplicate lines (input must be sorted) | `-c` count occurrences, `-d` only duplicates, `-u` only unique, `-i` ignore case |
| `awk` | Pattern scanning and text processing language | `-F` field separator, `-v` set variable; use `$1`, `$2`… for fields |

# Questions

1. How many different IP addresses reached the server?

`cat access.log | cut -d " " -f 1 | sort | uniq | wc -l`

Extract the first field (with the IP addresses), sort the IP addresses, get the unique IP addresses, and then get a line count

2. How many requests yielded a 200 code?

`cat access.log | cut -d '"' -f 3 | cut -d ' ' -f 2 | sort | uniq -c | sort -rn`

Extract the third field (with the IP addresses), sort the IP addresses, get the unique values with a count of the occurrences of each IP address, and then sort in descending numeric order

3. How many requests yielded a 400 code?

`cat access.log | cut -d '"' -f 3 | cut -d ' ' -f 2 | sort | uniq -c | sort -rn`

4. What IP address rang at the doorbell?

`cat access.log | grep "bell"`

Search the log for any lines that contain “bell”

5. What version of the Googlebot visited the website?

`cat access.log | grep "Googlebot"`

Search the log for any lines that contain “Googlebot”

6. Which IP address attempted to exploit the Shellshock vulnerability?
Search online for details about the Shellshock vulnerability. You should be able to find that the presence of this sequence of characters () { :; }; is an indication of an attempted exploitation of this vulnerability.  

`cat access.log | grep '() { :; };'`

Search the log for any lines that contain () { :; };

7. What was the most popular version of Firefox used for browsing the website?

`cat access.log | egrep -o "Firefox/.*" | sort | uniq -c`

Search the log for all lines that contain “Firefox” and the following characters which make up the version number, sort those values, and then get a unique count. 

8. What is the most common HTTP method used?

`cat access.log | awk -F " " '{print $6}' | sort | uniq -c | sort -rn`

Extract the 6th field (with the HTTP method), sort, get the unique values with a count of the occurrences of each value, and then sort in descending numeric order. 

9. What is the second most common HTTP method used?

`cat access.log | awk -F " " '{print $6}' | sort | uniq -c | sort -rn`


10. How many requests were for \x04\x01\x00P\xC6\xCE\x0Eu0\x00?

`cat access.log | grep '\\x04\\x01\\x00P\\xC6\\xCE\\x0Eu0\\x00' | wc -l`

Search the log for all lines that contain that sequence of characters and then get a line count. Note that that command requires two backslashes for each original backslash to perform a proper escape sequence for the backslash.