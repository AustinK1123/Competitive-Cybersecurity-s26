# base64
* base64 commands in vim are very similar to xxd.
  * You can encrpyt by line with !base64 or do the whole file with :%!base64
  * To decrpyt the by use !base64 -d or the whole file with !base64 -d
  * Decrpyting the whole file does not work if any of the file is not in base64 though. It will only decrypt what is and convert the rest into an error
# strings
* Downloaded the file with wget ![https://assets.super.so/2bd352bd-0121-4de9-82cb-b0261b7e35e9/images/44525691-991e-4a50-ad58-87b79b14fbf3/steg1.jpg]
* The strings command by default puts all binary data that is a text letter. So without grep it will be looking through a lot of nonsensical data.
* With grep following this format strings "file name" | grep "string you are looking for" you can search the binary data of a picture.
  * This is case senstitve. It will print the whole line that grep found with the characters you are looking for.
# Encryption
* Really struggling with getting it to work. 
