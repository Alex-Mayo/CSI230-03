. (Join-Path $PSScriptRoot "Functions and Event Logs 1-5.ps1")

clear

$loginoutsTable = getLogInOutsTable(-14)
$loginoutsTable

$startUpAndShutDownTable = getStartAndStopTime(-14)
$startUpAndShutDownTable