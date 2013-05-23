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

#sets the value of all eRecruiter connectionstrings in all ConnectionStrings.config files in all subdirectories
function Set-ConnectionString-Recursive {
    param($connectionString, $rootDir)

    Set-Setting-Recursive "ePunkt.Properties.Settings.ConnectionString" $connectionString "name" "connectionString" "ConnectionStrings.config" $rootDir
}

#sets the value of a eRecruiter setting in all AppSettings.config files in all subdirectories
function Set-AppSetting-Recursive {
    param($key, $value, $rootDir) 

    Set-Setting-Recursive $key $value "key" "value" "AppSettings.config" $rootDir
}

function Set-Setting-Recursive {
    param($key, $value, $keyAttribute, $valueAttribute, $fileName, $rootDir) 

    if ($rootDir -eq $NULL -or $rootDir -eq "") {
        $rootDir =  (split-path -parent $MyInvocation.MyCommand.Definition)
    }

	if ($rootDir -eq "" -or (Test-Path $rootDir) -eq $true) {
		$rootDir | Get-ChildItem -r -include $fileName | ForEach-Object {
			[XML]$xml = Get-Content $_.FullName
			Create-Replace-Or-Delete-Node $xml "add" $keyAttribute $key $valueAttribute $value
			$xml.Save($_.FullName)
		}
	}
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

    if ((Test-Path ([System.IO.Path]::GetDirectoryName($path))) -eq $true) {
        if ((Test-Path $path) -eq $false) {
            $content | out-file ($path)
        }
    }

    $null
}
