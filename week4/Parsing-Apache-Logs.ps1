function ApacheLogs1(){
    $logsNotformatted = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()

    for($i = 0; $i -lt $logsNotformatted.Count; $i++){
        $words = $logsNotformatted[$i].Split(" ")

        $tableRecords += [pscustomobject]@{ "IP" = $words[0]; `
                                            "Time" = $words[1].Trim('['); `
                                            "Method" = $words[2].Trim('"'); `
                                            "Page" = $words[3]; `
                                            "Protocol" = $words[4]; `
                                            "Response" = $words[5]; `
                                            "Referrer" = $words[6]; `
                                            "Client" = $words[11..($words.Length)]; }
    }
    return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap