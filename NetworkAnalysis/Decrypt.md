## Dycript Gym Challenge

The questions for decrypt can be found by using fileshark and looking through the 
packet information provided by the file `SSL_Decrypt.pcapng`.

the answers for the questions can be found under the layers provided.
`TLSv1.2 Record Layer: Handshake Protocol: Server Hello`
&
`TLSv1.2 Record Layer: Handshake Protocol: Certificate`

### Question 1

To find the data for questions 1 & 2, `Packet 6` holds the info.
![image](/NetworkAnalysis/image/q4.png)

this Image shows the layers to find the Cipher Suite.
![image](/NetworkAnalysis/image/q5.png)

### Question 2

for finding the Common name `Packet 6` still has the answer it just under the `Certificate` protocol.
the image below shows the path to find it.
![image](/NetworkAnalysis/image/q1.png)
![image](/NetworkAnalysis/image/q2.png)

### Question 3

For the last question we can find the answer in `Packet 10` 
to see the data we will have to enable TLS stream by going to `Edit then to Preferences` after that you will find the `Protocols`  in the Protocols you will need to find TLS and enable you need to select the `sslkeylog.log` file given under the master secret file name bar shown in the picture.
![image](/NetworkAnalysis/image/q6.png)

Once set up you can just right click then `follow then TLS Stream` the packet and show it in plane text.
![image](/NetworkAnalysis/image/q3.png)
![image](/NetworkAnalysis/image/q7.png)



