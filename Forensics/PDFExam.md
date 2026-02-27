# PDF Examination

This challenge is crazy easy, it uses a total of two tools.

## EXIFTOOL

This tool extracts metadata, this is how you get the first two questions. Metadata is just data about the file or more broadly data about other data. Specifically in cases like this, it gives you where the file came from, when it was made, versions etc.

## Some PDF editor

There are web ones, I used LibreOffice Writer, adobe will do it in windows. This answers the last two questions.

### What is the name of the program that exported this PDF file?

`exiftool api.pdf | grep ifwanted`

this will let you view the information about the file, for this question you just need the program that made it which is `Photoshop`

### What PDF version is this file?

`exiftool -q api.pdf | grep PDF`

Same exact command, the q flag just tells it to output fields it normally ignores, and thats needed for the PDF to show up without the grep. If you try greps it will find them even if they arent in the normal output, but I wanted to show the flag in case people just want to see more information about the file. The answer is `1.4`.

### What software was used to redact the file and insert a watermark?

Open in a pdf editor, and just delete the black boxes, the watermark IS the software used to insert the black boxes and watermark. The answer is `PDFTRON`.

### What is the flag?

This one is just uncovered when you delete the black boxes, its about halfway down on the far right. The flag is 'SKY-PDRD-2390'
