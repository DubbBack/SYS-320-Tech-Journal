.\daysTranslatorFunction.ps1
$FullTable = gatherClasses
$NewTable = daysTranslator($FullTable)

$NewTable | Where-Object { ($_.Location -eq "JOYC 310") -and ($_.days -contains "Monday")} |
            Sort-Object "Time Start" |
            Select-Object "Time Start", "Time End", "Class Code"