Import-Module ActiveDirectory
[array]$export = $null
#$ErrorActionPreference= 'silentlycontinue'
#Iport the list of computers from within a CSV
$path = "C:\Users\20648755\Documents\Scripts"
$base = import-Csv "$Path\computernames.csv" | Select-Object -ExpandProperty Name

ForEach ($bases in $base){
#Pull each name for their individual tests
    $ADcomp = Get-ADcomputer $bases
    $ip = Resolve-DnsName $bases | Select-Object -IPAddress
    $Ping = test-connection $bases -Quiet

IF ($null -eq $ADComp){
        #if the computer is not on the domain, all other tests will fail.
        write-host "Computer is not on domain, Least risk of using $bases" 
        $export += $bases

    }else{
        Write-Output "Computer $($ADComp.name) is in the domain, continuing to test"
        $export = $ADcomp.Name

        #This test will see if the computer has a dissernable IP. No IP means the computer has not been on the network in a few days.
        IF ($null -eq $ip){
            Write-Host "$($ADComp.name) has not been active in a few days, proceed with caution"

        }else{
            Write-host "$($ADComp.name) has the address of $ip, it's been active recently: continuing to test"
            

            #this establishes if the computer is accessible throught the network. This is the best test to see if the computer is active
            if ($false -eq $ping){
                write-host "Computer is not reachable, use $($ADComp.name) with caution"
                
            }else{
                Write-host "Please verify $($ADComp.name) this machine could be active"
        }
    }
}
}
$export | Export-Csv "$path\comp_lists.csv"
