$scraped_page = Invoke-WebRequest -URI http://10.0.17.26/ToBeScraped.html

$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where-Object {$_.getAttributeNode("class").value -like "div-1" } | Select-Object innerText

$divs1