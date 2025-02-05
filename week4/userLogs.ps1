$loginouts = Get-EventLog -LogName System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){


$event = ""
if($loginouts[$i].EventID -eq 7001) {$event="Logon"}
if($loginouts[$i].EventID -eq 7002) {$event="Logoff"}

$userSid = $loginouts[$i].ReplacementStrings[1]

try { 
	$user = (New-Object System.Security.Principal.SecurityIdentifier($userSid)).Translate([System.Security.Principal.NTAccount]).Value 
} catch { 
	$user = $userSid
}
$loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated
				     "Id" = $loginouts[$i].EventID
				     "Event" = $event
				     "User" = $user
}
}

$loginoutsTable


