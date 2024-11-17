 #!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function countingCurlAccess(){
	allLogs=$(cat "$file" | grep "curl" | cut -d' ' -f1,12)
	echo "$allLogs" | sort | uniq -c | sort -n
}

countingCurlAccess
