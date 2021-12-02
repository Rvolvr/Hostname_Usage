<#
.SYNOPSIS
This script was created for the purpose of risk assessment when reusing a computer name. 

.DESCRIPTION
This script is designed to establish if a user could be using a hostname while accounting for the amount of time it would take to ship a computer.

.NOTES
These are imperfect tests. The only perfect way to reuse a name is to check the physical computer and use that same name.
Computer login attribute within Active Directory objects are as many as 14 days old, and are meant to show computers that have aged out of a domain.
#>

Import-Module ActiveDirectory
Import-Module DnsClient
[array]$export = $null

# Import the list of computers from within a text file with no label
$path = "."
$list = Get-Content "$path\computernames.txt"
$list = $list.trim()

foreach ($name in $list) {

## Creating an exportable object with the informational fields we will use. Fields are pre-filled with default information for skipping when in error.
    $data = [pscustomobject]@{
        Name = $name
        Risk = $null
        Enabled = $False
        IPAddress = $null
        Active = $False
        Error = $null
    }
    Try {
### If a computer is not on the domain, this will fail and move to the next name on the list.
        $data.Enabled = Get-ADComputer $name -ErrorAction:Stop | Select-Object -ExpandProperty Enabled

        
### IPs are generally in DNS for only a few hours after disconnecting from the network. 
        $data.IPAddress = Resolve-DnsName $name -Type A -ErrorAction:Stop | Select-Object -ExpandProperty IPAddress
        
### Pings show that the associated IP to the host is active.
        $data.Active = Test-Connection $name -Quiet -Count 2
    
    } Catch {
        $data.Error = [string]$_
    }
    
## Risk levels elevate as tests are passed 
    $data.Risk = switch ($true) {
        $data.Active {'Please Verify Name - Currently Active'; break }
        ($null -ne $data.IPAddress) {'Has an IP - Could have been active in last 24 hours'; break }
        $data.Enabled {'On Domain - Could cause issue if in shipping'}

}
    $export += $data
    Write-Host $data
}
$export | Export-Csv "$path\computer_results.csv" -NoTypeInformation
