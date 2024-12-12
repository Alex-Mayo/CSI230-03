#!/bin/bash

logFile="access.log"
iocFile="IOC.txt"
outputFile="report.txt"

ioc=()
while read -r line; do
	if [[ -n "$line" ]]; then
		ioc+=("$line")
	fi
done < "$iocFile"

suspicious=()
for i in "${ioc[@]}"; do
	suspicious+=$(cat "$logFile"| grep "$i" | cut -d " " -f  1,4,7 | sed 's/\[//g'| sort)
done

:>report.txt
for line in "${suspicious[@]}"; do
	echo "$line" >> "$outputFile"
done
