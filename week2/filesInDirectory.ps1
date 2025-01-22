# Choose a directory where you have some .ps1 files 
cd $PSScriptRoot 

# List files based on the file name 
$files = Get-ChildItem -Path . -Filter "*.ps1" | Select-Object -ExpandProperty Name 

for ($j=0; $j -lt $files.Length; $j++) { 
	if ($files[$j] -like "*.ps1") { 
		Write-Host $files[$j] 
	} 
}
