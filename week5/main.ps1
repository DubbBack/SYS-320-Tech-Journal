.\gatherClassesFunction.ps1
.\daysTranslatorFunction.ps1
$FullTable = gatherClasses
$NewTable = daysTranslator($FullTable)
$NewTable
