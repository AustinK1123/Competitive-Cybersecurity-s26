# Blocks writeup

1) What application generated these logs?
This one is just look, it says what web server it connects to, and it also says what service it is running. It is `Minecraft`

2) What game version was the server running?
Again, first couple lines, `1.16.3`

3) How many unique players joined the server?
`cat latest.log | grep joined | cut -d':' -f4 | sort -u` the answer is 4.

4) How many times did boneappletea die?
`cat latest.log | grep boneappletea` and then just count the death lines, the answer was 11.

5) Who was the player that killed boneappletea?
Same search, just look for the player. It is gardensnek.

6) How many chat messages are sent while the server is up?
`cat latest.log | grep ": <[^>]*>" | wc -l`

7) Which player got the most advancements?
`cat latest.log | grep advancement | cut -d':' -f4 | sort | grep garden | wc -l` and just switch out users to see how many each has, the one there is the correct answer.

8) How many advancements did said player get?
The last command gives this one

9) Who was kicked from the server first?
`cat latest.log | grep kick` there is only one

10) Why was said player kicked from the game?
last command will show you

11) What was the error that caused the server to crash?
Just look at the end, it is Input/Output Error.
