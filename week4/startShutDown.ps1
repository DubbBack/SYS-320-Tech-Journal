function Get-StartShutdownEvents {
	    param(
	    	[Parameter(Mandatory=$true)]
		[int]$DaysBack
	        )
$startShutdowns = Get-EventLog -LogName System -After (Get-Date).AddDays(-$DaysBack) | Where-Object { $_.EventID -eq 6005 -or $_.EventID -eq 6006 }

$startShutdownTable = @()

foreach ($event in $startShutdowns) {
	$eventType = ""
	if ($event.EventID -eq 6005) { $eventType = "Startup" }
	if ($event.EventID -eq 6006) { $eventType = "Shutdown" }
	
$startShutdownTable += [PSCustomObject]@{
			                "Time"  = $event.TimeGenerated
	        		        "Id"    = $event.EventID
					"Event" = $eventType
					"User"  = "System"
				
				}
				
}

return $startShutdownTable
}

$DaysBack = 14

$startShutdownResult = Get-StartShutdownEvents -DaysBack $DaysBack
$startShutdownResult | Format-Table -AutoSize

