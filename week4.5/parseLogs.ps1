function ApacheLogs1(){
	$logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
	$tableRecords = @()

	for ($i = 0; $i -lt $logsNotFormatted.Count; $i++) {
		$words = $logsNotFormatted[$i] -split " "

		$tableRecords += [PSCustomObject]@{
			"IP"        = $words[0]
			"Time"      = $words[3].TrimStart("[") + " " + $words[4].TrimEnd("]")  
			"Method"    = $words[5].Trim('"')
			"Page"      = $words[6]  
			"Protocol"  = $words[7].Trim('"') 
			"Response"  = $words[8]  
			"Referrer"  = $words[10].Trim('"')  
			"Client"    = $words[11]
		}
	}

	return $tableRecords | Where-Object { $_.IP -like "10.*" }
}

