function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.26/Courses.html

$trs = $page.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){

    $tds = $trs[$i].getElementsByTagName("td")

    #$TimeField = $tds[5].innerText.Trim()
    #$Times = if ($TimeField -match "(.+?)\s*-\s*(.+)") { @($matches[1], $matches[2]) } else { 
    $Times = $tds[5].innerText.Split("-").Trim()

    $FullTable += [PSCustomObject]@{"Class Code" = $tds[0].innerText;
                                    "Title"      = $tds[1].innerText;
                                    "Days"       = $tds[4].innerText;
                                    "Time Start" = $Times[0];
                                    "Time End"   = $Times[1];
                                    "Instructor" = $tds[6].innerText;
                                    "Location"   = $tds[9].innerText;
                                    }
}
return $FullTable
}