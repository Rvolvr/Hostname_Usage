#Pull list of names from a docuemnt
$collection = Get-Content '.\office_list.csv'
#Option to use an admin account
$sesh = Get-Credential 
foreach ($item in $collection) {
    #test to see if computer in list is online
    $online = Test-Connection $item -Verbose
    if ($true -eq $online) {
        #open a remote session on the named computer and run the update.
        enter-PSSession -ComputerName $item -Credential $sesh
        Set-Location 'C:\Program Files\Common Files\microsoft shared\ClickToRun\'
        & .\OfficeC2RClient.exe /changesetting Channel=Current
        & .\OfficeC2RClient.exe /update user
        Exit-PSSession
    }
}
