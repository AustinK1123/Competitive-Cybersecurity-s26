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
* PNGs are not able to edited in the way asked due to compression. Here is what I tried and learned though
  * PNG the first 8 bytes are the magic ones that determine the file type. The IHDR is the image header chunk and contains height, width, color depth, and compression method. It is always 13 bytes big
  * [https://blog.kubesimplify.com/the-complete-guide-to-the-dd-command-in-linux](A link to a guide for the dd command)
  * The command I was trying is dd if=tux-96.png of=tux-96.ecb bs=1 count=8 conv=notrunc
  * When editing the png file with a dd command if="file" is the input of="file" is the output bs=1 is number of bytes read/written in the operation, count="number" is how many bytes, conv=notrunc is saying to not overwrite the whole file. 
  * When looking at files in vim and using :%!xxd to convert the data, the metadata stops at the byte that contains IDAT. 
  * grep-abo IDAT tux-96.png | head -1 should print the byte that IDAT is located in. Going back 4 bytes because IDAT is 4 bytes the metadata should end at byte 107. 
    * -a is treating the file as text
    * -b prints the byte for the text found
    * -o prints only the text and not the whole line
    * head -1 tells grep to only care about the first IDAT found. 
