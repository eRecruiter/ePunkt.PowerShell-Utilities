function Create-Directory-And-Disable-Protection-Rule($directoryPath)
{
    New-Item -Path $directoryPath -ItemType directory

    # Bestehenden Rechte übernehmen
    $ACL = Get-Acl $directoryPath

    # Vererbung ausschalten
    $ACL.SetAccessRuleProtection($True, $True)

    # veränderte Acl zurückschreiben
    Set-Acl $directoryPath $ACL
}