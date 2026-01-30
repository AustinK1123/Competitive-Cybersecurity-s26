# Barcode Reading

## Identify the Barcode Type  
* Not all barcodes are created equal. Before scanning, it helps to know what you are looking at, as different formats hold different amounts of data.
* 1D Barcodes: Traditional vertical lines (e.g., UPC, Code 128, Code 39). Code 128 is very common in CTFs because it supports ASCII characters.
* D Barcodes: Matrix patterns (e.g., QR Codes, Data Matrix, Aztec).

## Prepare the Image

Sometimes the file provided is small, blurry, or has inverted colors.

* Check for Inversion: Some scanners fail if the bars are white and the background is black. If it doesn't scan, use an image editor to Invert Colors.

* Zoom/Crop: If there is a lot of "noise" or other text around the barcode in the GIF, crop it down to just the barcode and the "quiet zone" (the white space immediately surrounding it).

## Use an Online Decoder

Since you are working on a computer, online tools are often faster than trying to hold your phone up to your monitor.   

* ZBar or ZXing Decoder: These are the industry standards for web-based decoding.  

*Visit the ZXing Decoder Online.

Upload your .gif file or paste the URL.
*  

