## Git Gym Challage 

### aquireing the file
To get to the files you can eather clone the repository or look thru the web page.

I found it easer to look thru the web page to find the awnsers. 
Link: `https://gitlab.com/cybergit4823/my-awesome-flag-project`

To clone the repository you use the command.
Bash: `Git Clone https://gitlab.com/cybergit4823/my-awesome-flag-project.git`

### Questions
to start you will need to go to the site or cd into the repository Bash: `cd my-awesome-flag-project`

#### Question 1
What is the display name of the author of this git project?
using Bash: `Git log` you can see the name of the user who did the commit.

#### Question 2
What is the short commit hash (first 8 characters) of the initial commit?
Using Bash: `Git log` you can find a commit with the message inital commit telling you wich one it is.
on the website it is the first one on the list at the bottom.

#### Question 3
What is flag #1?
can be found in the readme.txt using Bash: `cat README.md`.
#1 = SKY-HSNO-2303

#### Question 4
What is flag #2?
The Flag is in another Branch to see it Bash: `Git Branch` then `Git Switch Flag2` after that you will be able to see the flag2.txt. using `Cat Flag2.txt` you can get the flag.
#2 = SKY-OZNW-3730

#### Question 5
What is flag #3?
can be found by Bash: `cat flag3.txt` or in the site open the .txt in the main branch
#3 = SKY-CCXL-4067

#### Question 6
What is flag #4?
flag 4 was deleted so you will have to look at the commit changes.Bash: `git show 58ae6017797836ea5c154643a7cce9b6f11a9a38` 
In the web it is shown by navigating to the commits and finding the red highlited flag.
#4 = SKY-IRRK-9672 

#### Question 7
What is flag #5?
can be found when Bash: `Git log` is ran it is in the commit where flag 5 was deleted.
#5 = SKY-DKIT-9801