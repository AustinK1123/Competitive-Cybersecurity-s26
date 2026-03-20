# Metro Clinic — SQL Injection CTF Write-Up

**Challenge:** Metro Clinic Medical Directory Security Audit  
**Category:** SQL Injection  
**Scope:** HTTPS only (no brute force, no additional ports)

---

## Overview

This challenge involves exploiting a **SQL Injection** vulnerability in a medical directory search application. The web app allows users to search for medical professionals by name. The vulnerability arises because the application directly embeds user input into a SQL query **without sanitizing or escaping it**, allowing an attacker to manipulate the query logic and extract unintended data.

---

## Background: What Is SQL Injection?

SQL (Structured Query Language) is the language used to communicate with relational databases. When a web application takes user input and directly inserts it into a SQL query string, an attacker can craft input that **breaks out of the intended query** and runs their own SQL commands.

**Example of a vulnerable query:**
```sql
SELECT name, type FROM users WHERE name LIKE "%" + user_input + "%";
```

If `user_input` is just `alice`, this works fine. But if `user_input` is crafted to contain SQL syntax, the entire query structure can be hijacked.

---

## Tools Used

### 1. The Web Browser + Developer Tools
- **What it is:** Every modern browser (Chrome, Firefox, Edge) includes built-in developer tools, accessible with `F12` or right-click → Inspect.
- **How it was used here:** The challenge's search bar is the primary attack surface. You type inputs directly into it and observe the results on the page. No special software is needed — just a browser and careful observation.

### 2. The Search Bar as a Query Interface
- **What it is:** The application's search field passes your input directly to a backend SQL query.
- **How it was used:** By sending different inputs (letters, SQL syntax, special characters), you can infer how the database is structured and what query is being executed.

> 💡 **No hacking tools like SQLMap or Burp Suite are required for this challenge.** It is solvable entirely through manual input in the search bar.

---

## Reconnaissance: Understanding the Application

### Step 1 — Search with a Single Letter

Enter `a` into the search bar.

**Result:** All professionals whose names contain the letter "a" are returned, with two visible columns: **Name** and **Profession**.

**What this tells us:**
- The database has at least a `name` and a `type` (profession) column.
- The query is using a `LIKE` clause with wildcard `%` characters to do partial matching.

### Step 2 — Search with a Blank Space

Enter a single **space** (` `) into the search bar.

**Result:** Every entry in the directory is returned, because every full name (first + last) contains a space.

**What this tells us:**
- This is an easy way to dump all records visible through the normal query.
- You can use this to answer questions 1–3.

### Step 3 — Probe for SQL Errors

Enter `SELECT * FROM name;` into the search bar.

**Result:** A **SQLite error** is returned, referencing a syntax issue and mentioning the `%` character.

**What this tells us:**
- The backend is using **SQLite**, a common lightweight SQL database.
- Our input is being embedded inside an existing SQL statement.
- The `%` symbol is part of the original query (confirming the `LIKE "%...%"` pattern).

---

## Reconstructing the Backend Query

Based on the recon above, the full SQL query being executed by the server looks like this:

```sql
SELECT name, [type] FROM users WHERE name LIKE "%" + your_input + "%";
```

> **Note:** `[type]` is in brackets because `type` is a reserved SQL keyword. The brackets tell SQLite to treat it as a column name, not a keyword.

So if you type `smith`, the server runs:

```sql
SELECT name, [type] FROM users WHERE name LIKE "%smith%";
```

---

## Confirming the Table Structure (Deeper Recon)

To verify table names and column names, you can query SQLite's internal schema table `sqlite_master`.

Enter into the search bar:
```
"; SELECT * FROM sqlite_master WHERE type="table" AND "%"="
```

**Result:** The schema for the `users` table is returned, revealing four columns:
- `name`
- `type` (profession)
- `password`
- `username`

---

## The SQL Injection Payload

Now that we know the query structure, we can **escape out of it** and run our own query.

### The Injection String:
```
1"; SELECT * FROM USERS WHERE "%"="
```

### How It Works — Step by Step:

| Part | Purpose |
|------|---------|
| `1` | A dummy value that won't match any name, so the first query returns no results (clean output) |
| `"` | Closes the opening `"` that wraps your input in the original query |
| `;` | Terminates the original SQL statement |
| `SELECT * FROM USERS WHERE "%"="` | Your injected query — selects **all columns** from the `users` table |
| `"%"="` | This becomes `"%"="%"` when combined with the trailing `%"` already in the original query, making the `WHERE` condition always `TRUE` |

### The Combined Query the Server Actually Runs:
```sql
SELECT name, [type] FROM users WHERE name LIKE "%1"; SELECT * FROM USERS WHERE "%"="%";
```

The yellow portion is your injected input. The result: **all four columns** (`name`, `type`, `password`, `username`) for **every user** in the database are returned.

---

## Answering the Questions

### Question 1 — What is the name of the only Orthopedist?

**Method:** Enter a space (` `) to retrieve all records. Scroll through the results and look for anyone whose profession is listed as **Orthopedist**.

**Why it works:** The blank space matches every name, dumping the whole directory through the normal query. No injection needed.

---

### Question 2 — What is Katie Cain's profession?

**Method:** Enter `Katie Cain` (or just `katie`) into the search bar. Her record will appear with her name and profession in the visible columns.

**Alternatively:** Use the space dump and `Ctrl+F` to find her name on the page.

---

### Question 3 — How many medical professionals are in the registry?

**Method:** Enter a space (` `) to return all records, then **count the total number of rows** returned.

> 💡 Tip: Use your browser's `Ctrl+F` (Find) with a unique string like the column header text to count repeated items, or simply count the visible rows.

---

### Question 4 — What is the name of the person with the password "greyblob"?

**Method:** Use the SQL injection payload:
```
1"; SELECT * FROM USERS WHERE "%"="
```

This reveals all four columns including `password`. Scan the `password` column for `greyblob` and note the corresponding `name`.

**Why injection is needed:** The password column is **not returned** by the normal query — you must break out of the intended query to access it.

---

### Question 5 — What is Mike Torres' password?

**Method:** Use the same SQL injection payload:
```
1"; SELECT * FROM USERS WHERE "%"="
```

Find the row where `name = Mike Torres` and read his `password` from the newly visible password column.

---

## Why This Vulnerability Exists

The root cause is **unsanitized user input** being directly concatenated into a SQL string. The fix is to use **parameterized queries** (also called prepared statements), which separate SQL code from data:

**Vulnerable (bad):**
```python
query = "SELECT name, type FROM users WHERE name LIKE '%" + user_input + "%'"
```

**Fixed (good):**
```python
query = "SELECT name, type FROM users WHERE name LIKE ?"
cursor.execute(query, ("%" + user_input + "%",))
```

With parameterized queries, even if a user types `"; DROP TABLE users; --`, it is treated as a **literal string to search**, not as SQL code.

---

## Key Takeaways

- **SQL Injection** is one of the most common and dangerous web vulnerabilities (consistently in the OWASP Top 10).
- Attackers don't need special tools — just a browser and an understanding of SQL syntax.
- The attack works by **escaping the developer's intended query** using `"` and `;`, then appending a new query.
- **Parameterized queries / prepared statements** are the correct defense.
- Always treat user input as **untrusted data**, never embed it directly into SQL strings.

---

## References

- [OWASP SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)
- [Khan Academy — Intro to SQL](https://www.khanacademy.org/computing/computer-programming/sql)
- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)