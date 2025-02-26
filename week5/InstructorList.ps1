.\daysTranslatorFunction.ps1
$FullTable = gatherClasses
$NewTable = daysTranslator($FullTable)
$ITSInstructors = $NewTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or
                                              ($_."Class Code" -ilike "NET*") -or 
                                              ($_."Class Code" -ilike "SEC*") -or 
                                              ($_."Class Code" -ilike "FOR*") -or 
                                              ($_."Class Code" -ilike "CSI*") -or
                                              ($_."Class Code" -ilike "DAT*") 
                             } | Select-Object -Unique "Instructor" | Sort-Object Instructor
$ITSInstructors