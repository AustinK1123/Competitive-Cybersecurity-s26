# Webapp challenge write-up

This challenge is solved through `cat` `grep` `cut` `sort` and `wc` like most others, so I will not go back through those tools again here.

Awk and sed could also be used, but why bother? sure you can do more with one command, but using the more basic commands makes it easier to tell what you are doing step by step imo.

I did build up to these search commands, but it is literally just playing around with searches and reading some of the logs to get an idea of the log structure, and finding ways to seperate out what you want. Its good to try searches without cutting first so you can look at output, and trying to start super broad so you can make sure you don't miss anything.

Q1) Path of php file with most warnings?  
`cat Webapp.log | grep Warning` will give you a list of Warning lines, one file will account for almost every single warning, thats the one.

Q2) Internet Service Provider website hosted on?  
` cat Webapp.log | head` will give you some top level warnings, they start with a date stamp, then its a url, the googlebots are not the hosts, but the next ones are "xxxxxxx.somethingelse.com" if you cut all the beginning fluff, and check out the somethingelse.com, its a real website, and they sell internet service, thats the ISP.

Q3) Software platform website using?  
This one is just looking through the log and knowing that `wp-login` is the hint needed to figure this out.

Q4) Unique php files triggering warnings or notices?  
`cat Webapp.log | grep php | cut -d'~' -f2 | cut -d' ' -f1 | sort -u | wc -l` will give you this answer, this is searching for php files, cutting the lines right at the path, because there are not a set number of columns before the path for all of them, and then cutting everything off after the path, and then sorting, removing duplicates, and then counting the lines

Q5) How many events in log?  
`cat Webapp.log | grep America | wc -l` all the unique entries start with a date/time stamp, and then say "America/Toronto" rather than try and pattern match to the date, I search for the common word, as a lot of the entries are multiple lines, but even those only have one "America" and so print just those, and then counting

Q6) How many bans?  
`cat Webapp.log | grep banned | wc -l` this will search for the lines of users being banned, and then count how many there are

Q7) Unique IP addresses banned?  
`cat Webapp.log | grep Address | sort -u | wc -l` this prints just the lines where users listed, and this log only does this when banning, and then it sorts them while removing dupes, and then counts them

Q8) Unique URIs application ban for visiting?  
`cat Webapp.log | grep URI | sort -u | wc -l` same as above, print just the lines where it says what uri was visited during the ban, sort and remove dupes, then count
