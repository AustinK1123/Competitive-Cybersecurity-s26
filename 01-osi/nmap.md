Gary Maltby

## NMAP

1. What is the lowest open TCP port on the system?
`nmap -Pn -A -p- ports.cityinthe.cloud`
`-Pn` Treat host as online. Sends a ping to check if its alive or not.
`-A` Agressive Scan Options. Performs OS detection, Version detection, Script Scanning, Traceroute  
`-p-` Scan all ports. Shortcut for `-p 1-65535` forcing Nmap to check every port.
`ports.cityinthe.cloud` Target

* OUTPUT
```

```

2. What is the second lowest open TCP port on the system?  

3. What is the third lowest open TCP port on the system?  

4. What is the lowest open UDP port on the system?  

5. What software is being run on TCP port 16080?