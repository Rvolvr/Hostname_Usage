Import-Module ActiveDirectory
Import-Module DnsClient
[array]$export = $null

#Import the list of computers from within a CSV with the label 'name'
$path = "."
$list = Get-Content "$path\computernames.csv" 

foreach ($name in $list) {
    $data = [pscustomobject]@{
        Name = $name
        Enabled = 'False'
        Risk = 'None'
        IPAddress = 'None'
        Active = 'False'
    }
    Try {
        $data.Enabled = Get-ADComputer $name -ErrorAction:Stop | Select-Object -ExpandProperty Enabled
        $data.Risk = 'Recently Active'
        $data.IPAddress = Resolve-DnsName $name -Type A -ErrorAction:Stop | Select-Object -ExpandProperty IPAddress
        $data.Risk = 'Please Verify Name - Currently Active'
        $data.Active = Test-Connection $name -Quiet -Count 2
        
            
    } Catch { 
        
    }
    $export += $data
    
}

$export | Export-Csv "$path\computer_results.csv" -NoTypeInformation
