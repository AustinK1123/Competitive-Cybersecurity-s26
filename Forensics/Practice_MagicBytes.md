# Magic Bytes (Medium)(100 points) / 2 / Forensics

Check the header in the file for the correct "Magic Bytes"

For example:

JPEGs always start with the hex values: FF D8 FF E0 (or FF E1)

PNGs always start with: 89 50 4E 47

PDFs always start with: 25 50 44 46

## Tools (needed/used)

xxd your_corrupted_file | head -n 5

Look at the right side of the output (the ASCII translation). Even if the very first bytes are scrambled, the bytes immediately following them often give away the file type.

If you see IHDR near the top, it's a PNG.

If you see JFIF or Exif, it's a JPEG.

If you see word/ or xl/ further down, it's a Microsoft Office XML file (which is actually a ZIP archive).

If you look closely at the ASCII text on the far right, you can see two conflicting file signatures crammed together: JFIF and IHDR.

Replace the fake JPEG bytes with the standard PNG signature.

Change the first 12bytes to 89 50 4e 47 0d 0a 1a 0a 00 00 00 0d
Save
Open the file with `feh` or `timg` for right in command line viewing.

