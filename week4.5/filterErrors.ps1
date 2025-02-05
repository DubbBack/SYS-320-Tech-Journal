
#Define the path to the directory containing log files
$A = Get-Content C:\xampp\apache\logs\*.log | Select-String 'error'
$A[-5..-1]

