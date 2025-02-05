#Display only logs that contain 404 (Not Found) or 400 (Bad Request)
#Get-Content C:\xampp\apache\logs\access.log | grep '404'
Get-Content C:\xampp\apache\logs\access.log | grep '400'

