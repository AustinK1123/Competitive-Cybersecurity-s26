## File Carving Gym

File Carving is relatively simple we will be carving up the file given into separate bits to read in a different format or way. in this gym we will find a gzip file in the green_file given. The goal is to separate and extract the file aka carving and read the txt file found and get the flag.

### The bash we will be using is :

Bash: `File green_file`

Bash: `Binwalk green_file`

Bash: `binwalk --extract --dd “png:png” green_file`

Bash: `cd _green_file.extracted/`

Bash: `tar xvf CAB`

![image](/Forensics/Image/W5Step1.png)

![image](/Forensics/Image/W5Step2.png)
