# TimeBomb Gym

### Questions 
What programming language is the program written in?

What exit code does the program exit with when it is not time?

What time (in UTC) does the software go "Boom"?

## File type / Language

To start We need to find out what type of code is used to run the software.
there are multiple ways to find out. I used JDK on WSL to find the type of file it was coded from.
`javap -v TimeBomb` this will view the TimeBomb.class file data.

![image](/Enumeration/Image/TimeGym.png)

## Exit code / viewing the code

Now that we know they type of code used to make the file we can decode it into viewable text.
to make it easy i used a online tool to decode and view. `https://www.decompiler.com/`

![image](/Enumeration/Image/TimeGym2.png)

## finding the UTC time

the time the program is looking for is in the code, but it is not is a easy to read format.
`1.65806352E12D` is given as the time the program is looing for not is not a whole number so to convert it from milliseconds to a readable time `1658063520000`.

![image](/Enumeration/Image/TimeGym4.png)

Then given the time in a milliseconds format we will convert it to a UTC date using `https://currentmillis.com/`

![image](/Enumeration/Image/TimeGym3.png)