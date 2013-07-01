#include dependencies directly from GitHub
iex (New-Object System.Net.WebClient).DownloadString("https://raw.github.com/saxx/ePunkt.PowerShell-Utilities/master/Set-NetworkAdapter-Configuration.ps1")

$subnet = "255.255.255.0"
$ips = @("192.168.1.1", "192.168.1.2", "192.168.1.3")
$dns = @("4.4.4.4", "8.8.8.8")
$gateway = "192.168.1.254"

Set-NetworkAdapter-Configuration "Ethernet" $ips $subnet $gateway $dns