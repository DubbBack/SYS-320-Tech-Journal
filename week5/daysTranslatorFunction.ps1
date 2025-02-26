.\gatherClassesFunction.ps1

function daysTranslator($FullTable){

for($i=0; $i -lt $FullTable.length; $i++){
    $Days = @()

    if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday" }

    if($FullTable[$i].Days -ilike "*T[W,F,T]*"){ $Days += "Tuesday"} 
    ElseIf($FullTable[$i].Days -ilike "T"){ $Days += "Tuesday"}

    if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }

    if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thurday" }

    if($FullTable[$i].Days -ilike "*F"){ $Days += "Friday" }

    $FullTable[$i].Days = $Days
}
return $FullTable
}

daysTranslator
