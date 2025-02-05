# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

# Define a regex for IP addresses
$regex = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
# Get $notfounds records that match the regex
$ipsUnorganized = $regex.Matches($notfounds)
#Get IPs as PSCustomObject
$ips = @()
for ($i = 0; $i -lt $ipsUnorganized.Count; $i++) {
	$ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value }
}

# Filter IPs that start with "10."
$ips | Where-Object { $_.IP -like "10.*" }
#
