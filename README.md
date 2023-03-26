# Instructions for Ubuntu 20.04

***This repo was made for users having issues installing byob and nothing more. You can find the original repo here:***
[Firey BYOB Repo]: https://github.com/fireFerry/byob.git

### First, run the following commands:
```
chmod +x before_reboot.sh
chmod +x after_reboot.sh
chmod +x undo.sh
```
### Run the "before_reboot" script:
```
./before_reboot.sh
```
### After rebooting run the "after_reboot" script by:
```
./after_reboot.sh
```

* If you would like to undo all of the changes made in before_reboot & after_reboot run the undo.sh script.

* Please note: during the installation of ./startup.sh for BYOB you may require another reboot if it's your first time running the script.

### Head over to Windows and follow the instructions in the windows-open-ports folder.
* ***Please note:*** if your router doesnt support NAT loopback, this will ONLY work inside your internal network. This is only made for testing and educational purposes. Do not attempt to try this anywhere else without permission as its illegal and you will go to jail. Furthermore, make sure you have all virtual machines set as "bridged" in network settings.

* For automatically opening specific ports on Windows, you can use a PowerShell script. Below is an example script that opens ports 1337, 1338, and 1339 for both TCP and UDP protocols:

* Powershell script:
```
$ports = @(1337, 1338, 1339)
$protocols = @("TCP", "UDP")

ForEach ($port in $ports) {
    ForEach ($protocol in $protocols) {
        $ruleName = "OpenPort-$port-$protocol"
        $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
        if (-not $existingRule) {
            New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Action Allow -Protocol $protocol -LocalPort $port
        }
    }
}
```

* To run the script:
1. Open a text editor and paste the script above.
2. Save the file with a .ps1 extension, e.g., open_ports.ps1.
3. Right-click on the PowerShell icon in the Start menu, and select "Run as administrator."
4. Run this command in powershell to bypass execution policy or else you'll get an error:
```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```
5. Change the directory to where you saved the script, e.g., cd C:\Users\YourUsername\Documents.
6. Navigate to folder with scripts inside, Run the script by typing:
```
.\open_ports.ps1.
```
7. Please note that running PowerShell scripts can potentially harm your system if you don't know the script's source or purpose. Always review scripts before running them and ensure you understand their functionality.

* To undo the changes made in powershell, run the "undo_ports.ps1" file.
```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```
* Navigate to folder with scripts inside, Run the script by typing:
```
.\undo_ports.ps1
```

***Be sure to forward ports 1337-1339 in your default gateway.***

***For best use, navigate to the byob/byob directory and run the client.py file using the ip address found in your ubuntu machine. then run server.py and execute the payload on your windows machine.***
```
sudo python3 client.py <ip> <port>
```