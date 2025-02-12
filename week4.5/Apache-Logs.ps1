function Get-ApacheLogIPs{
	param(
		[string]$Page,
		[string]$HttpCode,
		[string]$Browser
	)

# Define log file path
$logFile = "C:\xampp\apache\logs\access.log"
# Define a regex to extract IP addresses
$regexIP = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
# Read and filter log data based on parameters
$filteredLogs = Get-Content $logFile | Where-Object {
	$_ -match $Page -and $_ -match $HttpCode -and $_ -match $Browser
}
# Extract IP addresses from filtered logs
$ips = $filteredLogs | ForEach-Object {
	if ($_ -match $regexIP) { $matches[0] }
}
# Count occurrences of each IP
$ipCounts = $ips | Group-Object | Select-Object Count, Name
# Return the result
return $ipCounts
}
