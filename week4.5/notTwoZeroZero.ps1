# Display only logs that does NOT contain 200 (ok)
Get-Content C:\xampp\apache\logs\access.log | Where-Object { $_ -notmatch "200" }
