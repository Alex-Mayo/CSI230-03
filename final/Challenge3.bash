#!/bin/bash

reportFile="report.txt"
outputFile="report.html"

:> "$outputFile"

echo "<html>" >> "$outputFile"
echo "<head><style>td {border: 1px solid black; }</style></head>" >> "$outputFile"
echo "<body>" >> "$outputFile"
echo "<h1>Access logs with IOC indicators:</h1>" >> "$outputFile"
echo "<table>" >> "$outputFile"

report=()
while read -r line; do
	report+=("$line")
done < "$reportFile"

for i in "${report[@]}"; do
	read -r ip date page <<< "$i"
	echo "<tr><td>" >> "$outputFile"
	echo "$ip" >> "$outputFile"
	echo "</td><td>" >> "$outputFile"
	echo "$date" >> "$outputFile"
	echo "</td><td>" >> "$outputFile"
	echo "$page" >> "$outputFile"
	echo "</td></tr>" >> "$outputFile"
done

echo "</table>" >> "$outputFile"
echo "</body>" >> "$outputFile"
echo "</html>" >> "$outputFile"

mv "$outputFile" /var/www/html/
