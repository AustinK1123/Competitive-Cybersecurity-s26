# Blocks writeup

This challenge is even simpler than Webapp, it is very simple short searches, and some even just by reading small sections with no commands needed, the first two can be done before even downloading the log.

1) What application generated these?  
This one is just look, it says what web server it connects to, and it also says what service it is running.

2) Game version server running?  
Again, first couple lines.

3) Number unique players joined?  
`cat latest.log | grep joined | cut -d':' -f4 | sort -u`.

4) Number boneappletea deaths?  
`cat latest.log | grep boneappletea` and then just count the death lines.

5) Who killed boneappletea?  
Same search, just look for the player.

6) How many chat messages sent?  
`cat latest.log | grep ": <[^>]*>" | wc -l`

7) Player most advancements?  
`cat latest.log | grep advancement | cut -d':' -f4 | sort | grep garden | wc -l` and just switch out users to see how many each has, the one there is the correct answer.

8) How many?  
The last command gives this one

9) Kicked from server first?  
`cat latest.log | grep kick` there is only one

10) Why?  
last command will show you

11) Error caused server crash?  
Just look at the end, it is Input/Output Error.
