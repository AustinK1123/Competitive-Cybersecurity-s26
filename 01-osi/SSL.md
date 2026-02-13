## SSL

SSL certificates help to secure the communication between a client and a server. Most modern browsers should have an interface to view the certificates in a SSL certificate chain.

## WHY?

SSL certificates are used to encrypt sensitive information, Authenticate Website Identity, Comply with Regulations, and Prevent Phishing Attacks. The SSL certificates protect the user of the site and it also helps the website owner build trust with their users. 

 To find the certificates click the icon next to URL. Then click on the “Connection is secure” section in the dropdown. 
![secure](/01-osi/image/SecureConnection.png)

The SSL chain can then be accessed by clicking on the “Certificate is valid” option.
![Valid](/01-osi/image/Valid.png)

This will open the certificate viewer which has general and detailed information about the certificates.
![Viewer](/01-osi/image/Viewer.png)

1. Who is the issuer for Cyber Skyline's SSL certificate?
Sectigo Public Server Authentication CA DV R36 (Issued By → Common Name)

2. How many bits long is the SSL key?
2048 bits (“Details” tab under “Certificate Fields → *.cyberskyline.com → Certificate → Subject Public Key Info → Subject’s Public Key”)

3. How many certificates are in the certificate chain?
3 (counted by looking at how many certificates are listed in the “Details” tab under “Certificate Hierarchy”)