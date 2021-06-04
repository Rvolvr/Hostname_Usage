Import-Module ActiveDirectory
[array]$export = $null

#Import the list of computers from within a CSV with the label 'name'
$path = ".\"
$base = Get-Content "$Path\computernames.csv" 

ForEach ($bases in $base){
    #Pull each name for their individual tests, but only enabled machines

    #if the computer is not on the domain, all other tests will fail. Add name to list
    Try {
        $ADcomp = Get-ADcomputer $bases | Where-Object {$_.enabled -eq 'True'} | Select-Object -Property Name, DNSHostName, Enabled
    } Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] { 
        write-host "Computer is not on domain, Least risk of using $bases"
        $base
        $export += $bases
    }
    $ip = Resolve-DnsName $ADcomp | Select-Object -Expandproperty IPAddress
    $Ping = test-connection $bases -Quiet

IF ($null -eq $ADComp){
        #if the computer is not on the domain, all other tests will fail. Add name to list
        write-host "Computer is not on domain, Least risk of using $bases"
        $base = add-Member -MemberType NoteProperty -Name Safe -Value $true
        $export += $bases
        
    }else{
        Write-Output "$($ADComp.DNSHostname) is valid, continuing to test"
        
        #This test will see if the computer has a dissernable IP. No IP means the computer has not been on the network in a few days.
        IF ($null -eq $ip){
            Write-Host "$($ADComp.DNSHostName) has not been active in a few days, proceed with caution"
            
        }else{
            Write-host "$($ADComp.name) has the address of $ip, it's been active recently: continuing to test"
            $ADcomp | Add-Member -InputObject $ip -Name IPAddress -MemberType NoteProperty

            #this establishes if the computer is accessible throught the network. This is the best test to see if the computer is active
            if ($false -eq $ping){
                write-host "Computer is not reachable, use $($ADComp.name) with caution"
                
            }else{
                Write-host "Please verify $($ADComp.name) this machine could be active"
                $ADcomp | Get-Member -InputObject $ping
        }
    }
#Add information gathered to a single object
$export += $ADcomp
}
}
#After all objects are have been read, export the information
$export | Export-Csv "$path\comp_lists.csv" -Formattable -NoTypeInformation 
