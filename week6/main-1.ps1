. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users`n"
$Prompt += "10 - Exit`n"


$checkAll = $false

$operation = $true
Write-Host $Prompt | Out-String
$choice = Read-Host
while($operation){

    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        

        $operation = checkUser($name)

        if($operation -eq $false) {
            Write-Host "User already Exists"
            exit
        }

        $operation = checkPassword($password)

        if($operation -eq $false) {
            exit
        }

        # TODO: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        #
        # TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.
        $findUser = checkUser($name)
        if($findUser -eq $true){
            return "User Not Found"
            exit
        }
        Write-Host "Now Removing User" $name
        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        $findUser = checkUser($name)
        if($findUser -eq $true){
            return "User Not Found"
            exit
        }
        Write-Host "Enabling User" $name

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.
        $findUser = checkUser($name)
        if($findUser -eq $true){
            return "User Not Found"
            exit
        }
        Write-Host "Now disabling User" $name

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.

        $findUser = checkUser($name)
        if($findUser -eq $true){
            return "User Not Found"
            exit
        }
        Write-Host "Checking Logins for User" $name

        $nubDays = Read-Host -Prompt "Please enter the nuber of days you would like to check"
        Write-Host $nubDays
        $userLogins = getLogInAndOffs($nubDays)
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.

        $findUser = checkUser($name)
        if($findUser -eq $true){
            return "User Not Found"
            exit
        }

        Write-Host "Checking Failed Logins for User" $name

        $numDays = Read-Host -Prompt "Please enter the nuber of days you would like to check"
        Write-Host $numDays
        $userLogins = getFailedLogins($numDays)
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }
    elseif($choice -eq 9){

        $days = Read-Host "Enter the number of days you want to look at that have more than 10 failed login"
        $days = [int]$days
        #if ($days -match "^\d=$") {
        #    $days = [int]$days
        #}else{
        #    Write-Output "Invalid input. Please enter a numeric value"
        #}
        $startTime = (Get-Date).AddDays(-$days)

        $failedLogins = Get-WinEvent -FilterHashtable @{
                                                        LogName = 'Security'
                                                        ID = 4625
                                                        StartTime = $startTime
                                                        } -ErrorAction SilentlyContinue
                                                        
        $userFailures = $faildLogins | Group-Object -Property @{Expression={$_.Properties[5].Value}}

        $flaggedUsers = $userFailures | Where-Object { $_.Count -ge 10 }

        if ($flaggedUsers){
            Write-Output "`nUsers with 10 or more failed login attempts in the last $days days:`n"
            $flaggedUsers | ForEach-Object {
                [PSCustomObject]@{
                    Username = $_.Name
                    FailedAttempts = $_.Count
                }
            } | Format-Table -AutoSize
        }else{
            Write-Output "No users found with 10 or more failed login attempts in the last $days days."
        }
        
    }else{
        Write-Host "Not a valid choice please only enter a number 1-10"
        Write-Host $Prompt | Out-String
        $choice = Read-Host
    }


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    

}




