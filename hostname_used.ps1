Import-Module ActiveDirectory
Import-Module DnsClient
[array]$export = $null

#Import the list of computers from within a CSV with the label 'name'
$path = ".\"
$Export = Get-Content "$Path\computernames.csv" | ForEach-Object {
    Try {
        Get-ADComputer $_
    } Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
            Return "$_ Not Found in Domain"
            Continue
    } 
    Try {
        Resolve-DnsName $_ -Type A
    } Catch {
        Return "$_"
        Continue
    }
    Test-Connection $_ -Quiet
    
}

