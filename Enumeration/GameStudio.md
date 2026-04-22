### Game Studio

Game studio was the medium challenge for the practice game. When completing this challenge you had to use the terminal that was provided so this challenge can no longer be completed.

## Problem description

You've been contracted by Metropolis Game Studio to pentest their servers to ensure that users cannot access files they do not have permissions to. The game studio has created an standard user account for you and provided you with the default password of "password" (very secure) and has asked that if you can extract the file flag.txt from the root user's home directory then you will be awarded handsomely.

## Solution (if possible)

Contents of the flag.txt file?

The contents of the file where just the flag not able to give the exact question or exact answer.

Running the command `sudo -l` gives you the output `(ALL, !root) /bin/bash`
From some research this is intended to let you run bash scripts as any user except root. This seems like it would be great but in sudo versions before 1.8.28 you could bypass it by specifying the user id of -1. 
Using the command `sudo -u#-1 /bin/bash` it lets you switch to the root user and you can navigate to the flag from there.

Another way to complete this lab is to get the version of sudo using `linPeas`.