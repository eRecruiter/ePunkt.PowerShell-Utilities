function Create-Or-Replace-Node {
    param($xmlDocument, $tag, $keyName, $keyValue, $valueName, $valueValue)

    $rootNode = $xmlDocument.ChildNodes[1]
    foreach ($node in $rootNode.ChildNodes) {
        if ($node.LocalName -eq $tag -and $node.$keyName -eq $keyValue) {
            $node.SetAttribute($valueName, $valueValue)
            return
        }
    }

    $newNode = $xmlDocument.CreateElement($tag)
    $newNode.SetAttribute($keyName, $keyValue)
    $newNode.SetAttribute($valueName, $valueValue)
    $rootNode.AppendChild($newNode)
}

function Set-ConnectionStrings {
    param($connectionString, $rootDir)

    if ($rootDir -eq $NULL) {
        $rootDir =  (split-path -parent $MyInvocation.MyCommand.Definition)
    }
    Set-Location $rootDir

    Get-ChildItem -r -include ConnectionStrings.config | ForEach-Object {
        [XML]$xml = Get-Content $_.FullName
        Create-Or-Replace-Node $xml "add" "name" "ePunkt.Properties.Settings.ConnectionString" "connectionString" $connectionString
        $xml.Save($_.FullName)
    }
}

function Set-AppSettings {
    param($key, $value, $rootDir) 

    if ($rootDir -eq $NULL) {
        $rootDir =  (split-path -parent $MyInvocation.MyCommand.Definition)
    }
    Set-Location $rootDir

    Get-ChildItem -r -include AppSettings.config | ForEach-Object {
        [XML]$xml = Get-Content $_.FullName
        Create-Or-Replace-Node $xml "add" "key" $key "value" $value
        $xml.Save($_.FullName)
    }
}
