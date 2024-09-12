#Get-EventLog system -source Microsoft-Windows-Winlogon


$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
$loginoutsTable = @()
for( $i = 0; $i -lt $loginouts.Count; $i++){
    $event = ""
    if($loginouts[$i].EventID -eq 7001) {$event = "logon"}
    elseif($loginouts[$i].EventID -eq 7002) {$event = "logoff"}

    $user = $loginouts[$i].ReplacementStrings[1]

    #Comment out the following 2 lines for question 2
    $SID = New-Object System.Security.Principal.SecurityIdentifier($user)
    $user = $SID.Translate([System.Security.Principal.NTAccount])


    $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                         "ID" = $loginouts[$i].EventID; `
                                         "Event" = $event; `
                                         "User" = $user
                                        }
}

#Question 4
function getLogInOutsTable($days){
    
    $loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays($days)
    $loginoutsTable = @()
    for( $i = 0; $i -lt $loginouts.Count; $i++){
        $event = ""
        if($loginouts[$i].EventID -eq 7001) {$event = "logon"}
        elseif($loginouts[$i].EventID -eq 7002) {$event = "logoff"}

        $user = $loginouts[$i].ReplacementStrings[1]

        #Comment out the following 2 lines for question 2
        $SID = New-Object System.Security.Principal.SecurityIdentifier($user)
        $user = $SID.Translate([System.Security.Principal.NTAccount])


        $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                         "ID" = $loginouts[$i].EventID; `
                                         "Event" = $event; `
                                         "User" = $user
                                        }
    }
    return $loginoutsTable
}


#Question 5
function getStartAndStopTime($days){
    $startUpAndDown = Get-EventLog -LogName System | Where-Object {($_.EventID -eq 6005) -or ($_.EventID -eq 6006)}
    $startUpAndDownTable = @()

    for( $i = 0; $i -lt $startUpAndDown.Count; $i++){
       $event = ""
       if($startUpAndDown[$i].EventID -eq 6005) {$event = "startup"}
       elseif($startUpAndDown[$i].EventID -eq 6006) {$event = "shutdown"}
       else{ continue; }

       $startUpAndDownTable += [pscustomobject]@{"Time" = $startUpAndDown[$i].TimeGenerated; `
                                                "ID" = $startUpAndDown[$i].EventID; `
                                                "Event" = $event; `
                                                "User" = "System"
                                                }
        }
    return $startUpAndDownTable
}


#$loginoutsTable
getLogInOutsTable(-50)
getStartAndStopTime(-50)