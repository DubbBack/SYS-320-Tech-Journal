# Get DNS server IPs and display only the first one 
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet*" }).ServerAddresses[0]
