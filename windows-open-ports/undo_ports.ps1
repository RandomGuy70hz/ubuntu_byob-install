$ports = @(1337, 1338, 1339)
$protocols = @("TCP", "UDP")

ForEach ($port in $ports) {
    ForEach ($protocol in $protocols) {
        $ruleName = "OpenPort-$port-$protocol"
        $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
        if ($existingRule) {
            # Disable the rule
            Set-NetFirewallRule -DisplayName $ruleName -Enabled False

            # Delete the rule
            Remove-NetFirewallRule -DisplayName $ruleName
        }
    }
}
