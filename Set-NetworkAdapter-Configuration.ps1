function Set-NetworkAdapter-Configuration($adapterName, $ipArray, $subnet, $gateway, $dns) {
    $netadapter = get-wmiobject win32_networkadapter | ?{ $_.NetConnectionId -eq $adapterName }
    $config = $netadapter.GetRelated("Win32_NetworkAdapterConfiguration")
	
	$subnetArray = @()
    ForEach ($ip in $ipArray){
        $subnetArray += $subnet
    }  
  
    $netadapter.EnableStatic($ipArray, $subnetArray)
    $netadapter.SetGateways($gateway)
    $netadapter.SetDNSServerSearchOrder($dns)
}