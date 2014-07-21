Import-Module WebAdministration

function Delete-Website-If-Exists {
    param($websiteName)
	
    If (Test-Path IIS:\Sites\$websiteName) {
        Remove-Item IIS:\Sites\$websiteName -Recurse
    }
}

function Create-AppPool-And-Website {
    param($websiteName, $path, $logPath, $username, $password)

    Create-AppPool $websiteName $userName $password

    Delete-Website-If-Exists $websiteName
    New-Item IIS:\Sites\$websiteName -Bindings @{protocol="http";bindingInformation="*:80:"} -PhysicalPath $path
    Set-ItemProperty IIS:\Sites\$websiteName -name applicationPool -value $websiteName

    $website = Get-Item IIS:\Sites\$websiteName
    $website.LogFile.Directory = $logPath
    $website.LogFile.LogExtFileFlags = "Date,Time,ClientIP, UserName, SiteName, ComputerName, ServerIP, Method, UriStem, UriQuery, HttpStatus, Win32Status, BytesSent, BytesRecv, TimeTaken, ServerPort, UserAgent, Cookie, Referer, ProtocolVersion, Host, HttpSubStatus"

    $website | Set-Item

    Remove-All-Bindings $websiteName
}

function Create-AppPool {
    param($websiteName, $username, $password)

    If (Test-Path IIS:\AppPools\$websiteName) {
        Remove-Item IIS:\AppPools\$websiteName -Recurse
    }
    New-Item IIS:\AppPools\$websiteName

    if ($username -ne "") {
        $appPool = Get-Item IIS:\AppPools\$websiteName
        $appPool.processModel.userName = $username
        $appPool.processModel.password = $password
        $appPool.processModel.identityType = 3
        $appPool | Set-Item
    }
}

function Set-Ssl-Certificate {
    param($websiteName, $ip, $hostHeader, $certificate)
    
    try {
        (Get-WebBinding -Name $websiteName -IPAddress $ip -HostHeader $hostHeader -Protocol https).AddSslCertificate($certificate, "WebHosting")
    }
    catch {
    	Write-Host ("Unable to set certificate " + $certificate + " for " + $websiteName + ": " + $_.Exception.Message)
    }
}

function Remove-All-Bindings {
    param($websiteName)

    foreach ($binding in Get-WebBinding -Name $websiteName) {
        Remove-WebBinding -InputObject $binding
    }
}

function Set-Http-Binding {
    param ($websiteName, $ip, $hostHeader)

    if ($null -ne (Get-WebBinding | where-object {$_.bindinginformation -eq ($ip + ":80:" + $hostHeader)})) {
        Remove-WebBinding -Name $websiteName -IP $ip -Port 80 -Protocol http -HostHeader $hostHeader
    }
    New-WebBinding -Name $websiteName -IP $ip -Port 80 -Protocol http -HostHeader $hostHeader
}

function Set-Https-Binding {
    param ($websiteName, $ip, $hostHeader, $certificate)

    if ($null -ne (Get-WebBinding | where-object {$_.bindinginformation -eq ($ip + ":443:" + $hostHeader)})) {
        Remove-WebBinding -Name $websiteName -IP $ip -Port 443 -Protocol https -HostHeader $hostHeader
    }
    New-WebBinding -Name $websiteName -IP $ip -Port 443 -Protocol https -HostHeader $hostHeader
    Set-Ssl-Certificate $websiteName $ip $hostHeader $certificate
}

function Set-Http-And-Https-Binding {
    param ($websiteName, $ip, $hostHeader, $certificate)
    Set-Http-Binding $websiteName $ip $hostHeader
    Set-Https-Binding $websiteName $ip $hostHeader $certificate
}
