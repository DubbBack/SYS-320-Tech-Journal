# Define the working directory 
$workingDir = Get-Location 
$files = Get-ChildItem -Path $workingDir -File
$files | Select-Object Name, FullName, Length, LastWriteTime
# Define the output folder and file path 
$outFolder = "$PSScriptRoot\outfolder" 
$outFile = "$outFolder\out.csv" 
# Ensure the "outfolder" directory exists 
if (!(Test-Path $outFolder)) { 
	New-Item -ItemType Directory -Path $outFolder 
} 
# list all files in the working directory 
$files = Get-ChildItem -Path $workingDir -File 
# Export the results to a CSV file 
$files | Select-Object Name, FullName, Length, LastWriteTime | Export-Csv -Path $outFile -NoTypeInformation 
# Confirm completion 
Write-Host "File list saved to $outFile"

