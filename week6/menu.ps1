. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot parseLogs.ps1)
. (Join-Path $PSScriptRoot startChrome.ps1)
. (Join-Path $PSScriptRoot Users.ps1)
clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display Last 10 Appache Logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Go to Champlain.edu`n"
$Prompt += "5 - Exit`n"

$operation = $true

Write-Host $Prompt | Out-String
$choice = Read-Host

while($operation){
    
    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $page = "http://10.0.17.26/index.html"   # Change this to the desired page
        $httpCode = "404"      # Change this to the desired HTTP response code
        $browser = "Chrome"   # Change this to the desired browser name


        $results = Get-ApacheLogIPs -Page $page -HttpCode $httpCode -Browser $browser


        $results | Format-Table -AutoSize

        $newResults = ApacheLogs1 
        $newResults | Format-Table -AutoSize -Wrap
    }

    elseif($choice -eq 2){
        $userLogins = getFailedLogins 100

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name*"} | Format-Table | Out-String)
    }

    elseif($choice -eq 3){
        $userLogins = getFailedLogins(100)
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name*"} | Format-Table | Out-String)
    }

    elseif($choice -eq 4){
        wantsToStartChrome

    } else {
        Write-Host "Not a valid choice please only enter a number 1-10"
        Write-Host $Prompt | Out-String
        $choice = Read-Host
    }
    Write-Host $Prompt | Out-String
    $choice = Read-Host

}