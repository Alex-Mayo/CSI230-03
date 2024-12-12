#!/bin/bash

pageAddress="10.0.17.6/IOC.html"

fullPage=$(curl -sL "$pageAddress")

page=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"//html//body//table//tr//td[1]")


echo "$page" | sed 's/<\/td>/\n/g' | \
	       sed -e 's/<td[^>]*>//g' | \
	       sed -e 's/&#13;//g' \
		> IOC.txt
