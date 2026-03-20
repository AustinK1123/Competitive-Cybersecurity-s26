## NCL Egov

1. Using a new tab with Google Chrome open the login page
`https://0c3a0c3647d83a62959f212565b01639-egov.web.cityinthe.cloud`

2. Open the devloper tools in Chrome by hitting F12.

3. Go to the application tab.
    - On the left hand side click `Cookies`
    - If there is nothing undercookies, try to login to the site. Refresh the page. Now you should see a new entry `admin` with a value of false. Change the value to true.
    - Click the `sources` tab. 
    - Expand the target website.
        - Click js
        - Click login.js
            - Notice the after a successful login. The user will be dropped to `/admin`.
4. In the address bar add `/admin` after the url. Enter.

- What is the flag obtained from logging in?  
    - SKY-YOSU-6051

    Here is a formal, comprehensive write-up you can add to your CTF notes. I have broken down the exploit into a clear, sequential methodology so you have a precise record of your attack vector and the underlying mechanics.

---

## CTF Vulnerability Write-Up: NCL Egov Login Panel

### 1. Executive Summary

* **Challenge Name:** NCL Egov
* **Objective:** Obtain the hidden flag by bypassing the login panel.
* **Vulnerabilities Exploited:** Insecure Client-Side State Management, Information Disclosure (Client-Side Logic), and Broken Access Control (Forced Browsing).
* **Flag Captured:** `SKY-YOSU-6051`

### 2. Vulnerability Details

The application relies on a vulnerable client-side authentication mechanism. Instead of validating user session privileges securely on the backend, the server trusts a localized browser cookie (`admin=false`) to determine access controls. Furthermore, the frontend JavaScript (`login.js`) explicitly exposes the routing logic for the administrative dashboard, allowing an attacker to map the application's hidden endpoints.

### 3. Step-by-Step Exploitation

The following sequence details the exact methodology used to compromise the application and capture the flag:

1. **Initial Access:** Navigated to the target application at `https://0c3a0c3647d83a62959f212565b01639-egov.web.cityinthe.cloud` using Google Chrome.
2. **State Inspection:** Opened Chrome Developer Tools (F12) and navigated to the **Application** tab. Attempted a dummy login to force the application to set session variables, then refreshed the page.
3. **Cookie Manipulation (Privilege Escalation):** Under the **Cookies** section, identified a cookie named `admin` with a boolean value of `false`. Double-clicked the value and manually modified it to `true` to elevate local session privileges.
4. **Source Code Reconnaissance:** Switched to the **Sources** tab in Developer Tools. Expanded the target website's directory tree and inspected the client-side JavaScript files (`/js/login.js`).
5. **Endpoint Discovery:** Analyzed `login.js` and identified the post-authentication routing logic, which revealed that a successful admin login redirects to the `/admin` endpoint.
6. **Forced Browsing (Exploitation):** Appended the discovered endpoint (`/admin`) directly to the target URL in the browser's address bar. Because the local cookie was already modified to `admin=true`, the backend server accepted the forged authorization state.
7. **Flag Extraction:** Successfully bypassed the login screen, accessed the restricted administrative dashboard, and retrieved the flag: `SKY-YOSU-6051`.

### 4. Remediation Recommendations

To patch these vulnerabilities, the application developers must implement the following:

* **Server-Side Session Management:** Never store privilege levels or authentication states in plaintext client-side cookies. Use securely generated, cryptographically signed session IDs (e.g., HTTPOnly, Secure cookies) validated against a backend database.
* **Strict Access Control:** Ensure the `/admin` route enforces backend authorization checks for every request, rather than relying on frontend routing logic to restrict access.
* **Obfuscation / Logic Hiding:** Remove sensitive routing information and administrative logic from publicly accessible JavaScript files.

---

Would you like to move straight into the next CTF challenge, or is there another tool or concept from this one you want to dissect first?