# Webapp challenge write-up

This challenge is solved through `cat` `grep` `cut` `sort` and `wc` like most others, so I will not go back through those tools again here.

Awk and sed could also be used, but why bother? sure you can do more with one command, but using the more basic commands makes it easier to tell what you are doing step by step imo.

I did build up to these search commands, but it is literally just playing around with searches and reading some of the logs to get an idea of the log structure, and finding ways to seperate out what you want. Its good to try searches without cutting first so you can look at output, and trying to start super broad so you can make sure you don't miss anything.

Q1) What is the path of the php file with the most warnings?
`cat Webapp.log | grep Warning` will give you a list of Warning lines, one file will account for almost every single warning, thats the one.

Q2) What is the Internet Service Provider that this website is being hosted on?
` cat Webapp.log | head` will give you some top level warnings, they start with a date stamp, then its a url, the googlebots are not the hosts, but the next ones are "xxxxxxx.rogers.com" if you cut all the beginning fluff, and check out rogers.com, its a real website, and they sell internet service, thats the ISP

Q3) What software platform is this website using?
This one is just looking through the log and knowing that `wp-login` is for wordpress, and thats the answer `Wordpress`.

Q4) How many unique php files are triggering warnings or notices?
`cat Webapp.log | grep php | cut -d'~' -f2 | cut -d' ' -f1 | sort -u | wc -l` will give you this answer, this is searching for php files, cutting the lines right at the path, because there are not a set number of columns before the path for all of them, and then cutting everything off after the path, and then sorting, removing duplicates, and then counting the lines

Q5) How many events are recorded in this log?
`cat Webapp.log | grep America | wc -l` all the unique entries start with a date/time stamp, and then say "America/Toronto" rather than try and pattern match to the date, I search for the common word, as a lot of the entries are multiple lines, but even those only have one "America" and so print just those, and then counting

Q6) How many times were bans given out for attempting to visit sensitive webpages?
`cat Webapp.log | grep banned | wc -l` this will search for the lines of users being banned, and then count how many there are

Q7) How many unique IP addresses were banned for attempting to visit sensitive webpages?
`cat Webapp.log | grep Address | sort -u | wc -l` this prints just the lines where users listed, and this log only does this when banning, and then it sorts them while removing dupes, and then counts them

Q8) How many unique URIs did the application ban users for visiting?
`cat Webapp.log | grep URI | sort -u | wc -l` same as above, print just the lines where it says what uri was visited during the ban, sort and remove dupes, then count
