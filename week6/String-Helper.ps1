<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>

function checkPassword {
    param (
        [Parameter(Mandatory = $true)]
        [System.Security.SecureString]$password
    )
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $PlainTextPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

    # Write-Host $PlainTextPassword
    # Write-Host "Checking length requirement"

    if ($PlainTextPassword.Length -lt 6){
        Write-Host "Password FAILS Legth Requirements"        
        return $false
    }
    Write-Host "Password meets Legth Requirements"   
        


    $hasLetter = $PlainTextPassword -match "[a-zA-Z]"
    # Write-Host "has letter" $hasLetter
    $hasNumber = $PlainTextPassword -cmatch "[0-9]"
    # Write-Host "has number" $hasNumber
    $hasSpecialChar = $PlainTextPassword -match "[^a-zA-Z\d]"
    # Write-Host "has special char" $hasSpecialChar
    # Write-Host "Checking character requirement"
    if ($hasLetter -and $hasNumber -and $hasSpecialChar){
        Write-Host "Password meets character Requirements"
        return $true
    }else{
        Write-Host "Password FAILS character Requirements"
        return $false
    }


}

<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}