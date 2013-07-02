function Disable-Protection-Rule-For-Directory {
    param($directoryPath)

    $objACL = Get-Acl $directoryPath
    $objACL.SetAccessRuleProtection($True, $True)
    Set-Acl $directoryPath $objACL
}

function Create-Directory {
    param($directoryPath)

    New-Item -Path $directoryPath -ItemType directory
}

function Create-Directory-And-Disable-Protection-Rule {
    param($directoryPath)

    Create-Directory $directoryPath
    Disable-Protection-Rule-For-Directory $directoryPath
}

##  Modifying the access rights for one user 

function Remove-All-Access-Rule-For-User {
    param($directoryPath, $user)

    $objACL = Get-Acl $directoryPath

    $colRights = [System.Security.AccessControl.FileSystemRights]"Read"
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None 
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None 
    $objType =[System.Security.AccessControl.AccessControlType]::Allow 
    
    $objUser = New-Object System.Security.Principal.NTAccount($user) 
    $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType) 
    $objACL.RemoveAccessRuleAll($objACE) 

    Set-Acl $directoryPath $objACL
}


function Set-FullControl-For-User {
    param($directoryPath, $user)

    $objACL = Get-Acl $directoryPath

    $colRights = [System.Security.AccessControl.FileSystemRights]"FullControl"
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None 
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None 
    $objType =[System.Security.AccessControl.AccessControlType]::Allow 

    $objUser = New-Object System.Security.Principal.NTAccount($user) 
    $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType) 
    $objACL.AddAccessRule($objACE) 

    Set-Acl $directoryPath $objACL
}

function Set-Read-Rights-For-User {
    param($directoryPath, $user)

    $objACL = Get-Acl $directoryPath

    $colRights = [System.Security.AccessControl.FileSystemRights]"Read"
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None 
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None 
    $objType =[System.Security.AccessControl.AccessControlType]::Allow 
    
    $objUser = New-Object System.Security.Principal.NTAccount($user) 
    $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType) 
    $objACL.AddAccessRule($objACE) 

    Set-Acl $directoryPath $objACL
}


function Set-Write-Rights-For-User {
    param($directoryPath, $user)

    $objACL = Get-Acl $directoryPath

    $colRights = [System.Security.AccessControl.FileSystemRights]"Write"
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None 
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None 
    $objType =[System.Security.AccessControl.AccessControlType]::Allow 
    
    $objUser = New-Object System.Security.Principal.NTAccount($user) 
    $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType) 
    $objACL.AddAccessRule($objACE) 

    Set-Acl $directoryPath $objACL
}


function Set-Read-Modify-Rights-For-User {
    param($directoryPath, $user)

    $objACL = Get-Acl $directoryPath

    $colRights = [System.Security.AccessControl.FileSystemRights]"Modify"
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None 
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None 
    $objType =[System.Security.AccessControl.AccessControlType]::Allow 

    $objUser = New-Object System.Security.Principal.NTAccount($user) 
    $objACE = New-Object System.Security.AccessControl.FileSystemAccessRule($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType) 
    $objACL.AddAccessRule($objACE) 

    Set-Acl $directoryPath $objACL
}

## Functions for multiple users

function Remove-All-Access-Rule-For-Users {
    param($directoryPath, $users)

    foreach ($user in $users) {
        Remove-All-Access-Rule-For-User $directoryPath $user
    }
}


function Set-FullControl-For-Users {
    param($directoryPath, $users)

    foreach ($user in $users) {
        Set-FullControl-For-User $directoryPath $user
    }
}

function Set-Read-Rights-For-Users {
    param($directoryPath, $users)

    foreach ($user in $users) {
        Set-Read-Rights-For-User $directoryPath $user
    }
}


function Set-Write-Rights-For-Users {
    param($directoryPath, $users)

    foreach ($user in $users) {
        Set-Write-Rights-For-User $directoryPath $user
    }
}

function Set-Modify-Rights-For-Users {
    param($directoryPath, $users)

    foreach ($user in $users) {
        Set-Read-Modify-Rights-For-User $directoryPath $user
    }
}