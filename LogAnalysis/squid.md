question 1
it is a unix timestamp, so convert it
example 1286536308.779
date -d @1286536308
shows 2010 as the answer

question 2
awk '{print $2}' squid_access.log | sort -n | head -1
run this 

question 3
awk '{print $2}' squid_access.log | sort -n | tail -1
run this

question 4
awk '{print $3}' squid_access.log | sort | uniq | wc -l
run this

question 5
grep -c " GET " squid_access.log
run this 

question 6
grep -c " POST " squid_access.log
run this

question 7
grep "192.168.0.224" squid_access.log
will give the answer based upon the ip
