# Doctor Writeup
* Using binwalk on a file shows hidden file descriptions. Such as that the file is a zip archive
  * 'binwalk SuperAwesomeDoc.docx'
[Image of binwalk](Forensics/Image/Binwalk Screenshot.jpg)
* You can then unzip the file using 'unzip SuperAwesomeDoc.docx'
* This unzips a word file which after looking around in I found a media file with png files.
* To view pngs inside the terminal use feh
  * 'sudo apt install feh'
* The file image0.png contains the secert flag and opening it with feh shows the flag is SKY-RATL-8439
  * 'feh image0.png'
 
