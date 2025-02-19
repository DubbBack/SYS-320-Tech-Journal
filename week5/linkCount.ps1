# Get the link count from your web page

$scraped_page = Invoke-WebRequest -URI http://10.0.17.26/ToBeScraped.html

$scraped_page.Links.Count