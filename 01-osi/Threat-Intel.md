# Threat-Intel Challenge write-up

Brandon Walker
29-Jan-2026

A CVE is a standardized "address" system for known vulnerabilities that is in the form `CVE-YYYY-NNNN` where YYYY is the year of the CVE identification, and then the NNNN is an assigned number for that specific vulnerability. CVE's are connected to specific CPE's, a CPE is a standardized address system for hardware and software, this allows you to look up the CPE for a service or device, and find what vulnerabilities affect it. This could be used by security professionals to find weaknesses to guard, or bad actors looking to exploit a system by seeing what service etc is available, and then how to exploit it for unauthorized access. These can be googled, but THE source for these should always be ![NIST](https://nvd.nist.gov/vuln) or ![CISA](https://www.cisa.gov/news-events/cybersecurity-advisories?f%5B0%5D=advisory_type%3A93).

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

My operating system doesn't truly have a defined CPE being CachyOS, but if it had one, it would be `cpe:2.3:o:cachyos_project:cachyos:-:*:*:*:*:*:*:*` or `cpe:2.3:o:archlinux:arch_linux:*:*:*:*:*:*:*:*` as it is downstream of arch, and thus generally will have the same vulnerabilities

The CPE of the software with the Smiley Face backdoor is `cpe:2.3:a:vsftpd_project:vsftpd:2.3.4:*:*:*:*:*:*:*`

