Get-Service | Where-Object { $_.Status -eq "Stopped" } | Sort-Object Name

$outputFile = "C:\Users\champuser\SYS-320-Tech-Journal\week3\StoppedServices.csv"

Get-Service | Where-Object { $_.Status -eq "Stopped" } | Sort-Object Name | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "Stopped services list saved to $outputFile"
