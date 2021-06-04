Import-Module ActiveDirectory
Import-Module DnsClient
[array]$export = $null

#Import the list of computers from within a CSV with the label 'name'
$path = "."
$list = Get-Content "$path\computernames.csv" 

foreach ($name in $list) {
    Try {
        $data = [pscustomobject]{
            Name = $name
            Risk = 'None'
            IP = 'None'
            Active = 'False'
            Reason = ''
         }
        $data.Name = Get-ADComputer $name -ErrorAction:Stop | Select-Object hostname
        $data.Risk = 'Moderate'
        $data.IP = Resolve-DnsName $name -Type A -ErrorAction:Stop | Select-Object IPAddress
        $data.Risk = 'Check name'
        $data.Active = Test-Connection $name -Quiet -Count 2
        
            
    } Catch { 
        $data.Reason = $_
    }
    $export += $data
    
}

$export | Export-Csv "$path\computer_results.csv" -NoTypeInformation
