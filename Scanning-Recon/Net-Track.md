# Net Track Notes
- Use `nc` to get into the server.
- The full command is hostname and then port 
    - `nc net-track.services.cityinthe.cloud 8090`
- Now that you are in the server, it looks like it didn't work. However type anything in except for a blank line to get a help message
- This help message tells us to use the command help to get a list of commands.
- `help` list this:
```
Here is a list of commands
version
list
get
help
```
- `version` list the software and it's version
    - `RadicalShell v9`
- `list` lists the files on the server
- `get (filename)` outputs the contents of the file
    - Use `get secret` to get the flag of SKY-NCAT-3071
- To figure out which is the largest file we need to get every file listed.
- Once that is done the file we will look at the file with the most text in it(this is the schedule file)
- Now since each text character is one byte we can count how many text characters there in the file manually. This includes spaces as well.
    - This comes out to 40 text characters, so 40 bytes is the size of the largest file in bytes. 
