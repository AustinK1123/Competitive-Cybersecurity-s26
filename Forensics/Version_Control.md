## Basic wrightup on Version Control using Git commands

Using Git Commands we will look thru the logs and whats left in the Backup.

Starting with unzipping and accessing the backup File.
Unzip Using the Bash : `unxz yourfile.tar.xz`
Then access the file using cd command Bash : `cd git_backup/`

after you have acces to the Backup file you can look thru it using Bash : `ls` and `ls -la` to see what avaliable in the folder. 

![image](/Forensics/Image/for_1.png)

Once in you can use git commands to look through the logs after identifying whats there.
Bash : `git log`

![image](/Forensics/Image/for_2.png)

The Log shows the past commits to the git page and has an identifier attached. Using the command Bash : `git show 438fa54ba62144ad84376635d957e5e73d89066e` with the identifier it shows the log in an easy to read text.

![image](/Forensics/Image/for_3.png)

Next you can use the Bash : `git branch` to look at the branched that are stored in the backup. Then you can use the Bash : `git checkout yourBranch` to enter the branch you want to look through.

Once in the branch you can use the Bash : `git log & git show` used the previous steps to look through the logs and read them.

![image](/Forensics/Image/for_5.png)

