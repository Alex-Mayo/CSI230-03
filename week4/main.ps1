. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot Parsing-Apache-Logs.ps1)

$ipsoftens = getVisitedIpAddresses "index.html" ' 200 ' "Chrome"
$counts = $ipsoftens | Group-Object IP
$counts | Select-Object Count, Name

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap