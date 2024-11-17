#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
	allLogs=$(cat "$file" | cut -d' ' -f7 | tr -d "/")
}

function counter(){
	echo "$allLogs" | sort | uniq -c | sort -n
}

getAllLogs
counter
