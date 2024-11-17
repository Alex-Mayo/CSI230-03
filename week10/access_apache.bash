#!bin/bash

file="/var/log/apache2/access.log"

page2Results=$(cat "$file" | grep "page2.html" | cut -d' ' -f1,7 | tr -d  "/")

echo "$page2Results"
