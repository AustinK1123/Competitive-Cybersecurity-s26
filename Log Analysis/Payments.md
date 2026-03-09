## Payments

This challenge involves parsing a log file from a SOAP web server. SOAP is used to send messages using the Extensible Markup Language (XML). Solving this challenge requires a mechanism to parse the XML and query the underlying data. This can be done by extracting the relevant XML from the log file, converting the XML to CSV format, and then using a spreadsheet editor to query the data. 

When doing this challenge I was not able to convert the file to excel. Since I wasn't able to I used AI to convert it for me then was able to find all the answers through sorting the columns.

# Questions
1. How many transactions are contained in the log?

Count the number of lines that start with PPAPIService: Request: 
`192`

2. What is the transaction ID of the largest purchase made in the log?

Sort the requests by the order total column to find the largest purchase, then get the transaction ID from the corresponding response
`3a4da8c8-6934-4655-9ec5-335ab4540a2b`

3. Which state made the greatest number of purchases?

Get a count of the unique values for the state of the ship-to address
`50`

## SPOILER WARNING

# Gym Challenges

How many transactions are contained in the log?
`192`

What is the transaction ID of the largest purchase made in the log?
`3a4da8c8-6934-4655-9ec5-335ab4540a2b`

Which state made the greatest number of purchases?
`Massachusetts` 