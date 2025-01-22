# Get IPv4 Address from Ethernet0 Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "Ethernet0"}).IPAddress

# Get IPv4 PrefixLength from Ethernet Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "Ethernet0"}).PrefixLength

#Show me what classes there is of Win32 library that starts with net and Sort alphabetically
Get-WmiObject -List | Where-Object { $_.Name -like "Win32_Net*" } | Sort-Object Name

