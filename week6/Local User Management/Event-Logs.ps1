. (Join-Path $PSScriptRoot String-Helper.ps1)


<# ******************************
     Function Explaination
****************************** #>
function getLogInAndOffs($timeBack){

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays("-"+"$timeBack")

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){

$type = ""
if($loginouts[$i].InstanceID -eq 7001) {$type="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$type="Logoff"}


# Check if user exists first
$user = (New-Object System.Security.Principal.SecurityIdentifier `
         $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                    "Event" = $type; `
                                     "User" = $user;
                                     }
} # End of for

return $loginoutsTable
} # End of function getLogInAndOffs




<# ******************************
     Function Explaination
****************************** #>
function getFailedLogins($timeBack){
  
  $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timeBack") | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return $failedloginsTable
} # End of function getFailedLogins

function getAtRiskUsers($timesince){
    $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timesince") | Where { $_.InstanceID -eq "4625" }

    $users = ""

    for($i -eq 0; $i -lt $failedlogins.Count; $i++){
        $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
        $user = $usrlines[1].Split(":")[1].trim()

        if($users -contains $user){
            continue
        }         
        $count = 0

        for($j -eq 0; $j -lt $failedlogins.Count; $j++){
            $usrlines2 = getMatchingLines $failedlogins[$j].Message "*Account Name*"
            $user2 = $usrlines2[1].Split(":")[1].trim()

            if($user -eq $user2){
                count++
            }
        }
        if($count -gt 10){
            $users += $user
            $users += "`n"
        }
    }

    return $users
}