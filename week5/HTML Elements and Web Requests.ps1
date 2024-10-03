$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.21/ToBeScraped.html

#$scraped_page.Links.Count
#$scraped_page.Links

#$scraped_page.Links | Select-Object href, outerText

#$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText
#$h2s

$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where { $_.getAttributeNode("class").Value -ilike "div-1"} | select innerText
$divs1