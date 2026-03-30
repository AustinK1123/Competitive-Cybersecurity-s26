# Leek Challenge - Reworked Write-Up (Template Draft)

**Challenge Type:** Web application vulnerability
**Difficulty:** Easy-Medium
**Write-Up Mode:** Balanced depth with full transcript evidence

---

## 1. High-Level Synopsis

This challenge tests whether you can identify and exploit unsafe server-side memory handling in a web app endpoint. The app accepts JSON for adding grocery items, but different input types appear to trigger different backend behavior.

**Goal:** Trigger the memory leak path and recover the leaked flag from server responses.

---

## 2. Tools and Concepts Overview

### Tools Used

- **Browser Developer Tools (Chrome/Chromium):** capture live requests, inspect payloads, and inspect response data shape.
- **cURL:** replay and mutate requests quickly from terminal.
- **(Optional) Burp Suite / ZAP:** alternative request repeater/fuzzer workflow.

### Key Functionality Used in This Solve

- **DevTools -> Network tab:** to identify endpoint and request body schema.
- **DevTools -> Payload tab:** to confirm exact JSON key and type.
- **DevTools -> Preview/Response tab:** to observe Buffer-like response behavior.
- **DevTools -> Copy as cURL:** to export a valid baseline request.
- **cURL `--data-raw`:** to mutate JSON body while preserving endpoint/headers.
- **`Content-Type: application/json`:** ensures backend parses JSON and preserves primitive type.

### Commonly Useful Functionality for Similar Challenges

- **DevTools -> Headers tab:** verify backend/runtime hints and content handling.
- **Type mutation testing:** try `"text"`, `10`, `null`, `[]`, `{}` to detect type confusion.
- **Incremental payload scaling:** test `10`, `32`, `64`, `100`, `128` to expand leak windows.
- **Output capture and diffing:** compare responses across payloads to isolate meaningful bytes.

### Web Tools and References Used

- [Node.js Buffer documentation](https://nodejs.org/api/buffer.html)
- [Node.js deprecations and unsafe constructor history](https://nodejs.org/api/buffer.html#new-bufferarray)
- [cURL docs](https://curl.se/docs/manpage.html)

---

## 3. Detailed Walkthrough (Full Step Transcript)

### Step 1: Capture baseline request behavior

**Step Goal:** Identify the request schema and target endpoint used by the app when adding an item.

**Action:**

1. Open challenge page.
2. Open DevTools (`F12`).
3. Go to **Network** tab.
4. Add a normal item (example: `Banana`).
5. Inspect the `add` request payload.
6. Right-click that `add` request in Network, then select **Copy -> Copy as cURL**.
7. Paste the copied command into your terminal so you have a runnable baseline request.

**Observed payload shape:**

```json
{
  "content": "Banana"
}
```

**Logic:** You need a known-good request before mutation. This confirms endpoint, JSON key name, and valid baseline formatting.

### Step 2: Inspect response data characteristics

**Step Goal:** Determine whether the server response hints at direct buffer handling.

**Action:**

1. In the same captured `add` request, open **Preview**/**Response**.
2. Compare expected text behavior vs returned structure.

**Observation:** Response appears Buffer-like rather than a cleanly normalized string payload.

**Logic:** A Buffer-like response is a strong clue that backend memory/buffer logic may be exposed to user-controlled input.

### Step 3: Build and justify exploit hypothesis

**Step Goal:** Define a testable hypothesis for how input type affects backend execution path.

**Action (hypothesis-driven):**

- Compare `"10"` (string) vs `10` (number) in JSON.

**Logic:**

- JSON preserves primitive type.
- In Node-style buffer workflows, string input can be treated as text bytes while numeric input can be interpreted as size.
- If unsafe/deprecated buffer construction exists, numeric input may allocate and expose stale/uninitialized memory content.

### Step 4: Trigger leak path and scale payload until full flag appears

**Step Goal:** Use numeric JSON input to trigger the leak path, then increase values until the full flag is visible.

**Action:**

1. Use the copied cURL command from Step 1 in terminal and change only the JSON payload to a small numeric value:

    ```bash
    curl 'https://<host>/add' \
    -H 'Accept: */*' \
    -H 'Content-Type: application/json' \
    --data-raw '{"content":10}'
    ```

2. Run that command in terminal.
3. Refresh the app output (or inspect response flow) and check for partial leaked bytes.
4. If output is partial, rerun from terminal with larger numeric values until you get the full flag.
5. Record the exact final flag string from the leaked output.

**Logic:** The request stays syntactically valid while changing only type/size behavior. Larger numeric values can expose more bytes, turning partial leakage into full flag recovery.
