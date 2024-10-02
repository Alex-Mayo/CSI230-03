function getVisitedIpAddresses($page, $HTTPCode, $WebBrowser){

    $Connections = Get-Content C:\xampp\apache\logs\access.log | Select-String $page, $HTTPCode, $WebBrowser

    $regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

    $IpAddresses = $regex.Matches($Connections)

    $ips = @()

    for($i = 0; $i -lt $IpAddresses.Count; $i++){
        $ips += [pscustomobject]@{ "IP" = $IpAddresses[$i].Value}
    }

    return $ips
}