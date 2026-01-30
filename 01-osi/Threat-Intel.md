# Threat-Intel Challenge write-up

Brandon Walker
29-Jan-2026

1. What is the CVE of the original POODLE attack?
    - Google the exact question, wikipedia, nist.gov and cisa.gov all agree `CVE-2014-3566`

2. What version of VSFTPD contained the smiley face backdoor?
    - Google, NIST.gov says `vsftpd 2.3.4 downloaded between 20110630 and 20110703`

3. What was the first 1.0.1 version of OpenSSL that was NOT vulnerable to heartbleed?
    - Google, CISA says `OpenSSL Version 1.0.1g addresses and mitigates this vulnerability`

4. What was the original RFC number that described Telnet?
    - Google, Wiki, and IBM say `RFC 854 and 855`

5. How large (in bytes) was the SQL Slammer worm?
    - Google, sources in general, including Wiki say `376 bytes` I dont list sources because I didn't see any exceptionally trustworthy ones

6. Samy is my…
    - `Hero`, according to wiki and news sources from when the virus came out

The ability to find CVE's, especially for vulnerabilities that might affect a system you maintain is important because if you don't know what attacks you are vulnerable to, you don't know what to try and protect yourself from.

A CPE is a `Common Platform Enumeration` aka, its an almost programatic string that describes your hardware or software.

My operating system doesn't truly have a defined CPE being CachyOS, but if it had one, it would be `cpe:2.3:o:cachyos_project:cachyos:-:*:*:*:*:*:*:*` or `cpe:2.3:o:archlinux:arch_linux:*:*:*:*:*:*:*:*` as it is downstream of arch, and thus generally will have the same vulnerabilities

The CPE of the software with the Smiley Face backdoor is `cpe:2.3:a:vsftpd_project:vsftpd:2.3.4:*:*:*:*:*:*:*`

CPE is important because it is how you tell what CVE's might apply to your system.

