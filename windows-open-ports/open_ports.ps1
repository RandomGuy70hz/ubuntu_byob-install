$ports = @(1337, 1338, 1339)
$protocols = @("TCP", "UDP")
$directions = @("Inbound", "Outbound")

ForEach ($port in $ports) {
    ForEach ($protocol in $protocols) {
        ForEach ($direction in $directions) {
            $ruleName = "OpenPort-$port-$protocol-$direction"
            $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
            if (-not $existingRule) {
                New-NetFirewallRule -DisplayName $ruleName -Direction $direction -Action Allow -Protocol $protocol -LocalPort $port
            }
        }
    }
}
