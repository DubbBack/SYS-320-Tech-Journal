# Get the DHCP server IP and hide the table headers 
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "IPEnabled = TRUE" | Select-Object DHCPServer | Format-Table -HideTableHeaders
