$chromeProcess = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($chromeProcess) {
	Stop-Process -Name "chrome" -Force
	Write-Host "Google Chrome was running and has been stopped."
} else {
        Start-Process "chrome.exe" -ArgumentList "https://www.champlain.edu"
        Write-Host "Google Chrome was not running and has been started with Champlain.edu."
}
	    
