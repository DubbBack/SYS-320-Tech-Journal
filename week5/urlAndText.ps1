$scraped_page = Invoke-WebRequest -URI http://10.0.17.26/ToBeScraped.html

# Display only URL and its text
$scraped_page.Links | Select-Object outerText, href
#$scraped_page.Links.OuterText
#$scraped_page.Links.Href