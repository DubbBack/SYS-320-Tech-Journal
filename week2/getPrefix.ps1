#Get IPv4 PrefixLength from Ethernet0 Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "Ethernet0"}).PrefixLength

