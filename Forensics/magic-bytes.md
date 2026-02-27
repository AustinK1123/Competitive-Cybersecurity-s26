# Magic Bytes Documentation
* Within files there are magic bytes that say what type of file it is. These are differnt for each file
* [List of magic bytes for files provided by wikipedia](https://en.wikipedia.org/wiki/List_of_file_signatures)
* To view hex you can use vim or a tool
### VIM
* To use vim open the file flag.jpeg in vim and then escape into the command line.
* Then use `:%!xxd` to convert the hex.
* You can see on the right that it uses the IHDR block which jpegs don't. PNGs use this so the orginal file is a png.
![Picture shwoing the IHDR Block](
* Now that we know it is a png take this block of magic bytes `89 50 4E 47 0D 0A 1A 0A` and replace the first bytes with these.
* Use `:%!xxd -r` to change it back. Then escape into the command and `:wq`
* Once you do you can open the png and see the flag. Could do this using feh
### Hexedit
* To use hexedit open the file flag.jpeg in hexedit
* You can see on the right with the plaintext a IHDR block. Jpegs don't use these but pngs do. So png is the orginal file type.
* Using hexedit you can just copy and paste where your cursor is, don't highlight like normal copy and pasting, `89 50 4E 47 0D 0A 1A 0A`
* You can save with control + x
    * You can also quit without saving using control + c
* You can now open the file. Could do this using feh
