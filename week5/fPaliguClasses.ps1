.\daysTranslatorFunction.ps1
$FullTable = gatherClasses
$NewTable = daysTranslator($FullTable)
# list all the classes of Indtructor Furkan Paligu
$NewTable | Where-Object {$_.Instructor -ilike "Furkan*" } | 
             Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End"