# Leek Challenge - Clear and Concise Guide

## Goal

Exploit the add-item endpoint to trigger a server-side memory leak and recover the flag.

## Vulnerability in One Line

The backend likely handles string and numeric JSON input differently; numeric input may be treated as Buffer length instead of text, causing leaked memory bytes.

## Tools

### Browser DevTools

Use Network, Payload, Preview/Response, and Headers tabs to:

- identify endpoint and request format,
- confirm backend clues (Express/Node),
- inspect how response data is returned.

### Copy as cURL

Export an exact working request from DevTools, then mutate only the JSON body.

### curl

Replay requests quickly while testing input type changes and size increases.

Optional: Burp Suite or ZAP can do the same with a GUI workflow.

## Solve Workflow

### Step 1: Capture baseline request

Add a normal grocery item and inspect the request payload.

Expected shape:
{
  "content": "Banana"
}

### Step 2: Confirm response clue

The response appears Buffer-like, not a clean sanitized string. Combined with Express headers, this strongly suggests Node Buffer handling in the backend.

### Step 3: Form hypothesis (key reasoning)

Why test 10 instead of "10"?

- JSON preserves type: "10" is string, 10 is number.
- Node Buffer behavior is type-sensitive: string input is encoded as text; numeric input can represent buffer size.
- If backend uses unsafe/deprecated buffer construction, numeric input can trigger allocation behavior instead of text handling.
- If that allocated memory is exposed without proper initialization/sanitization, stale server memory can leak.

So the test is not changing characters; it is changing type.

### Step 4: Replay with numeric payload

Start from copied request and change body:

curl 'https://<host>/add' \
  -H 'Accept: */*' \
  -H 'Content-Type: application/json' \
  --data-raw '{"content":10}'

Then refresh the app output and inspect results.

Expected result:

- Partial leaked bytes, often including part of the flag.

### Step 5: Increase leak size

If output is partial, increase numeric value (for example 32, 64, 100, 128):

curl 'https://<host>/add' \
  -H 'Accept: */*' \
  -H 'Content-Type: application/json' \
  --data-raw '{"content":100}'

Larger size can leak more bytes and reveal full flag content.

### Step 6: Extract flag

Repeat and compare outputs if noisy, then isolate the complete flag string.

## Why This Pattern Matters

- It teaches practical type-confusion testing in black-box web apps.
- It shows how high-level runtimes can still leak memory when unsafe APIs are misused.

## Quick Checklist

- Capture normal add request.
- Confirm content field and Buffer-like response.
- Switch payload from "10" to 10.
- Increase numeric size until leak is complete.
- Extract and submit flag.
