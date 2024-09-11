Get-Process -Name "C*"

Get-Process | Where-Object { $_.Path -notcontains "*system32*" }

Get-Service | Where-Object { $_.Status -eq "Stopped" } | Sort-Object | Export-Csv -Path "C:\Users\champuser\CSI230-03\week2\services.csv"

$ChromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$StartPage = "champlain.edu"

if(Get-Process chrome) { Stop-Process -processname chrome } else { Start-Process -FilePath $ChromePath -ArgumentList $StartPage }