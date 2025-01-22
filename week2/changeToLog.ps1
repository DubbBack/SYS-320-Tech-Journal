
# Get the working directory
$workingDir = Get-Location

#Find all .csv files in the current directory (non-recursively)
$csvFiles = Get-ChildItem -Path $workingDir -Filter "*.csv" -File

# Rename each .csv file to .log
foreach ($file in $csvFiles) {
	$newName = [System.IO.Path]::ChangeExtension($file.FullName, ".log")
        Rename-Item -Path $file.FullName -NewName $newName
        Write-Host "Renamed: $($file.Name) -> $([System.IO.Path]::GetFileName($newName))"
}

# Recursively list all files without changing directories
Get-ChildItem -Path $workingDir -File -Recurse | Select-Object Name, FullName, Length, LastWriteTime
             
