Get-Process | Where-Object { $_.Path -and $_.Path -notlike "*system32*" }
