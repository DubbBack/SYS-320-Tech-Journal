# Import the Apache-Logs.ps1 script
. .\Apache-Logs.ps1

# Define inputs
$page = "http://10.0.17.26/index.html"   # Change this to the desired page
$httpCode = "404"      # Change this to the desired HTTP response code
$browser = "Chrome"   # Change this to the desired browser name

# Call the function and store the results
$results = Get-ApacheLogIPs -Page $page -HttpCode $httpCode -Browser $browser

# Display results
$results | Format-Table -AutoSize

