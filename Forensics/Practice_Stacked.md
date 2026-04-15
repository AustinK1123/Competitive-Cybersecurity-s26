# Forensics

## Tools (needed/used)

`file` Check the file type: Run the file command to ensure the magic bytes match the file extension.
`strings` strings stacked.jpg | grep -i "flag"
`exiftool` stacked.jpg Analyze the metadata for flags
`binwalk stacked.jpg` Check for Appended or Hidden Files
`dd` Data Definition

This can be a brief summary, I care more about the write up below.

## Write up

The commands `file` `strings` `exiftool` and `binwalk were used as a discovery phase to check for any hidden flags, file extensions were appropriate, and to identify any "gimmies" in metadata. 

`binwalk` revealed 3 files stacked on top of each other. Two of the files were JPEG and the last remaining file is a PNG.

From here I used the dd (data definition) tool to carve out the PNG file. Check the magic byte and fix the header.

gmaltby@MSI:/mnt/c/1-wsl/challenge-game$ binwalk stacked.jpg

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             JPEG image data, JFIF standard 1.01
49709         0xC22D          JPEG image data, JFIF standard 1.01
99525         0x184C5         PNG image, 500 x 116, 8-bit/color RGBA, non-interlaced

gmaltby@MSI:/mnt/c/1-wsl/challenge-game$ binwalk -e stacked.jpg

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------

WARNING: One or more files failed to extract: either no utility was found or it's unimplemented

gmaltby@MSI:/mnt/c/1-wsl/challenge-game$ dd if=stacked.jpg bs=1 skip=99525 of=hidden.png
10688+0 records in
10688+0 records out
10688 bytes (11 kB, 10 KiB) copied, 1.67105 s, 6.4 kB/s
gmaltby@MSI:/mnt/c/1-wsl/challenge-game$ dd if=stacked.jpg bs=1 skip=49709 count=49816 of=hidden2.jpg
49816+0 records in
49816+0 records out
49816 bytes (50 kB, 49 KiB) copied, 8.03189 s, 6.2 kB/s
gmaltby@MSI:/mnt/c/1-wsl/challenge-game$ ls
hidden.png  hidden2.jpg  stacked.jpg

