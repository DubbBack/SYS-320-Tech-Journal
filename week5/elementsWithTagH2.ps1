$scraped_page = Invoke-WebRequest -URI http://10.0.17.26/ToBeScraped.html

$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText

$h2s