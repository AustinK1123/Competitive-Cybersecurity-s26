# Doctor Writeup
* Using binwalk on a file shows hidden file descriptions. Such as that the file is a zip archive
  * `binwalk SuperAwesomeDoc.docx`

![Binwalk image](/Forensics/Image/Binwalk-Screenshot.jpg)

* You can also see what files it will unzip through binwalk. On the left you can see word and _rels which is some of the files/folders it unzips.
* You can then unzip the file using 'unzip SuperAwesomeDoc.docx'
* This unzips a word file which after looking around in I found a media file with png files.
* To view pngs inside the terminal use feh
  * `sudo apt install feh`
* The file image0.png contains the secert flag and opening it with feh shows the flag is SKY-RATL-8439
  * `feh image0.png`

![Image of iamge0.png feh](/Forensics/Image/image0-Screenshot.jpg)

# Feh
* Feh most any picture file format
  * Webp, jpeg, jpeg XL, png, bmp, etc etc.
  * It can open gifs but makes them static, same with any moving image.
* Feh will fail used on non image files like txt and unsupported formats. 
