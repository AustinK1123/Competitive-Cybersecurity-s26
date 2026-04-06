# Videoconference Challenge write-up

## Tool Primer: awk and jq

### jq

I used `jq` to parse JSON safely by field name instead of splitting raw text with `cut`.
This matters because JSON fields can move around or include extra punctuation, while `jq`
still returns exactly the fields I ask for.

In this write-up, `jq` is used to:

- pull values like `.participant`, `.meetingID`, and `.bytesProcessed`
- slice dates with `.date[0:10]` so results group by day
- format multiple fields as tab-separated output with `@tsv` so they can be piped into `sort`, `uniq`, and `awk`

### awk

I used `awk` for lightweight calculations and grouping in the shell pipeline.
It is good for operations like sum, count, and average without needing a separate script.

In this write-up, `awk` is used to:

- add numbers as they stream through (`sum += $1`)
- count records (`NR` or custom counters)
- calculate per-group averages using associative arrays (for example by date)

1) How many total records are present in the meeting log?  
`cat meeting.json | wc -l` will give the number of entries.

2) How many unique users are recorded in the meeting log?  
`cat meeting.json | cut -d':' -f7 | sort | cut -d',' -f1 | uniq | wc -l` this will output just the users, sort them to remove duplicates, and then count unique entries.

3) How many unique meetings are recorded in the logs?  
`cat meeting.json | cut -d':' -f6 | cut -d',' -f1 | sort -u | wc -l` this will output just the meeting id's and then count unique entries.

4) How many meetings had dial-in users?  
`cat meeting.json | grep Dial-In | cut -d':' -f6 | cut -d',' -f1 | sort -u | wc -l` this will look for entries where it says users dialed in, and then print just the meeting id, and then do the same as above, to get down to just unique entries.

5) What is the average number of bytes processed (round to nearest whole number)?  
`cat meeting.json | grep -oP '(?<=:)\d+(?=\}$)' | awk '{sum += $1} END {if (NR > 0) printf "%0f\n", sum / NR; else print 0}'` this command extracts the numeric bytes value from each record, feeds those numbers to `awk`, sums them, and divides by record count. `printf "%0f"` rounds to the nearest whole number for the final answer.

6) How many unique IPs are recorded in the logs?  
`cat meeting.json | grep \"ip\":\" | cut -d'"' -f20 | sort -u | wc -l` This will have one extra due to some ip fields being empty, those empty entries will be grouped together, and deduped down to one, it could probably be changed to remove those empty lines, but this was how I got the answer, and I am far enough behind I didn't want to spend extra time optimizing a command that already works.

7) What is the meeting ID with the most number of participants?  
`cat meeting.json | cut -d':' -f6 | cut -d',' -f1 | sort | uniq -c | sort -n` This will print just the meeting id's, and then sort them, and then tell how many times each meeting is listed, which should be a count of how many users, this worked, but if it didnt, you could have the first cut include more, or use the jq command I learned later to account by users specifically.

8) Which date had the most number of calls take place?  
`cat meeting.json | jq -r '[.date[0:10], .meetingID] | @tsv' | sort -u | cut -f1 | uniq -c | sort -n`
Short writeup: `jq` outputs date + meeting ID pairs, `sort -u` removes duplicate rows so each call is counted once per date, and then the pipeline counts calls per date. The largest count identifies the date with the most calls.

9) Which date had the highest average bytes processed for its calls?  
`cat meeting.json | jq -r '[.date[0:10], .bytesProcessed] | @tsv' | awk -F'\t' '{sum[$1]+=$2; count[$1]++} END {for (d in sum) print sum[d]/count[d], d}' | sort -n | tail -n 1` - `jq` outputs date and bytes as tab-separated columns. `awk` groups by date, tracks total bytes and number of records for each day, and computes average bytes per day. Sorting and taking the last line returns the highest daily average.

10) There was an unauthorized user on a call, what's the meeting ID of that call?  
`cat meeting.json | jq -r '.participant' | sort | uniq -c | sort -rn` look at the name that only appears once, and then how suspicious it looks.

11) We believe there was an account that was hacked, what is the name of the person that was hacked?  
`jq -r '[.participant, .device] | @tsv' meeting.json | sort -u | cut -f1 | uniq -d` this command builds participant-device pairs, removes exact duplicate pairs, then looks for participants that still appear more than once. A participant tied to multiple devices after dedupe is a strong indicator of account compromise.

12) What is the name of the attacker responsible for the breach referenced above?  
This one is multipart imo, it might be able to be done in less steps, but I really don't know how you would. The below command will get you the specific entry where Jeanne Lowe switched devices, you can figure that out by using MOST of the last command to get participants and devices without dupes, and then seeing that the iOS device is not her normal one.  
`cat meeting.json | grep "Jeanne Lowe" | grep iOS`  
From the above command you grab the ip address that her account logs in from when hacked, and see that its an ip another user is normally using, thus that user must be the attacker.  
`cat meeting.json | grep 132.12.5.210`
