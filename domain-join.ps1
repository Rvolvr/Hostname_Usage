$serial = Get-WmiObject -class win32_bios | Select-Object -ExpandProperty SerialNumber
[INT]$lselection = Read-Host {    "1 for site1",
    "2 for Site2",
    "3 for Site3"
}
switch ($lselection) {
    1 {
        $local = 'Site1'
        $OU = 'Site1'
    }
    2 {
        $local = 'Site2'
        $OU = 'Site2'
    }
    3 {
        $local = 'Site3'
        $OU = 'Site3'
    }
    Default {
        Write-Host "Incorrect number entered"
        Exit
    }
}
[INT]$Tselect = Read-Host "1 for Laptop or 2 for Desktop"
switch ($Tselect) {
    1 { $type = "L"}
    2 { $type = "D"}
    Default {
        Write-Host "Incorrect number entered"
        Exit
    }
}
$fill = Read-Host "Short domain name"
Add-Computer -DomainName $fill+".com" -newname "$local-$type-$serial" -OUPATH "OU=$OU,OU=Computers,DC=+$Fill+,DC=COM"