function Set-NetworkAdapter-Configuration($adapterName, $ipArray, $subnet, $gateway, $dns) {
    $adapter = get-wmiobject win32_networkadapter | ?{ $_.NetConnectionId -eq $adapterName }
    $config = $adapter.GetRelated("Win32_NetworkAdapterConfiguration")
	
	$subnetArray = @()
    ForEach ($ip in $ipArray){
        $subnetArray += $subnet
    }  
  
    $config.EnableStatic($ipArray, $subnetArray)
    $config.SetGateways($gateway)
    $config.SetDNSServerSearchOrder($dns)
}