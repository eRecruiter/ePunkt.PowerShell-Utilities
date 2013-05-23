function Create-Replace-Or-Delete-Node {
    param($xmlDocument, $tag, $keyName, $keyValue, $valueName, $valueValue)

    $rootNode = [System.Xml.XmlElement]$xmlDocument.ChildNodes[1]
    foreach ($node in $rootNode.ChildNodes) {
        if ($node.LocalName -eq $tag -and $node.$keyName -eq $keyValue) {
            if ($value -eq $null) {
                $rootNode.RemoveChild($node)
                return
            }
            else {
                $node.SetAttribute($valueName, $valueValue)
                return
            }
        }
    }

    if ($value -ne $null) {
        $newNode = $xmlDocument.CreateElement($tag)
        $newNode.SetAttribute($keyName, $keyValue)
        $newNode.SetAttribute($valueName, $valueValue)
        $rootNode.AppendChild($newNode)
    }
}

function Set-ConnectionString-Recursive {
    param($connectionString, $rootDir)

    if ($rootDir -eq $NULL) {
        $rootDir =  (split-path -parent $MyInvocation.MyCommand.Definition)
    }

    $rootDir | Get-ChildItem -r -include ConnectionStrings.config | ForEach-Object {
        [XML]$xml = Get-Content $_.FullName
        Create-Replace-Or-Delete-Node $xml "add" "name" "ePunkt.Properties.Settings.ConnectionString" "connectionString" $connectionString
        $xml.Save($_.FullName)
    }
}

function Set-AppSetting-Recursive {
    param($key, $value, $rootDir) 

    if ($rootDir -eq $NULL -or $rootDir -eq "") {
        $rootDir =  (split-path -parent $MyInvocation.MyCommand.Definition)
    }

    $rootDir | Get-ChildItem -r -include AppSettings.config | ForEach-Object {
        [XML]$xml = Get-Content $_.FullName
        Create-Replace-Or-Delete-Node $xml "add" "key" $key "value" $value
        $xml.Save($_.FullName)
    }

    $null
}


#creates an empty AppSettings.config file in the specified directory, if none exists yet
function Create-Empty-AppSettings-If-Not-Exists {
    param([string]$directory)

    Create-File-If-Not-Exists ($directory.Trim("\") + "\AppSettings.config") "<?xml version=`"1.0`"?><appSettings />"
}

#creates an empty ConnectionStrings.config file in the specified directory, if none exists yet
function Create-Empty-ConnectionStrings-If-Not-Exists {
    param([string]$directory)

    Create-File-If-Not-Exists ($directory.Trim("\") + "\ConnectionStrings.config") "<?xml version=`"1.0`"?><connectionStrings />"
}

#creates an empty file in the specified path, if it does not exist yet, and fills it with the specified content
function Create-File-If-Not-Exists {
    param([string]$path, [string]$content)

    if ((Test-Path $path) -eq $false) {
		#only create the file when the directory exists
        if ((Test-Path [System.IO.Path]::GetDirectoryName($path)) -eq $false) {
            return
        }

        $content | out-file ($path)
    }

    $null
}
