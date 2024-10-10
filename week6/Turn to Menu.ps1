. (Join-Path $PSScriptRoot\"Local User Management" Event-Logs.ps1)
$Parent = Split-Path $PSScriptRoot -Parent
. (Join-Path $Parent\week4 Parsing-Apache-Logs.ps1)

$ChromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$StartPage = "champlain.edu"
$aLongTimeAgo = 999

$Prompt = "Please select an option`n"
$Prompt += "[1] Display last 10 Apache logs`n"
$Prompt += "[2] Display last 10 failed logins`n"
$Prompt += "[3] Display At Risk Users`n"
$Prompt += "[4] Go to champlain.edu`n"
$Prompt += "[5] Exit"

$operation = $true

while($operation){


    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 1){
        Write-Host "Gathering Apache Logs..." | Out-String
        $ApacheLogs = ApacheLogs1 | Select-Object -Last 10
        Write-Host ($ApacheLogs | Format-Table | Out-String)
    }
    
    elseif($choice -eq 2){
        Write-Host "Gathering Failed Login Attempts..." | Out-String
        $FailedLogins = getFailedLogins $aLongTimeAgo | Select-Object -Last 10
        Write-Host ($FailedLogins | Format-Table| Out-String)
    }

    elseif($choice -eq 3){
        Write-Host "Gathering At Risk Users..." | Out-String
        $atRiskUsers = getAtRiskUsers $aLongTimeAgo
        Write-Host($atRiskUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 4){
        if(Get-Process chrome){}
        else{ Start-Process -FilePath $ChromePath -ArgumentList $StartPage }
    }

    elseif($choice -eq 5){
        Write-Host "Goodbye..." | Out-String
        exit
        $operation = $false
    }

    else{
        Write-Host "Error: Invalid Input! Please select a valid option from the menu.`n" | Out-String
    }
}