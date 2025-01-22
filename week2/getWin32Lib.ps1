# Show what classes there are in the Win32 library that start with 'Net', sorted alphabetically 
Get-WmiObject -List | Where-Object { $_.Name -like "Win32_Net*" } | Sort-Object Namie
