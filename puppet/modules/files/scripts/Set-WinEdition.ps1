$base="C:\@inf\winbuild"
$logPath= join-path  $base "logs"
$tracefile="$logpath\set-edition-$(get-date -format 'MMddyyyy').log"
start-transcript -path $tracefile

$editionsFile="C:\@inf\winbuild\scratch\enterprise.txt"
$server=hostname

# check if edition flag was created by puppet
if (test-path -path 'C:\@inf\winbuild\scratch\enterprise.txt') {

  C:\windows\system32\DISM.exe /online /Get-TargetEditions
  C:\windows\system32\DISM.exe /online /Set-Edition:ServerEnterprise /ProductKey:#####-######-#####-#####-##### /NoRestart /logpath:"C:\@inf\winbuild\logs\dism.log"
}

# this will require a reboot to take effect, and will leave that up to altiris.
stop-transcript