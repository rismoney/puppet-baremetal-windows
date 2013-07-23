. X:\get-DHCPHostname.ps1
#disable all nics except "Ethernet"  windows 2012 is deterministic...
gwmi -class win32_networkadapter |where-object {$_.netconnectionid -ne "Ethernet" -and $_.netenabled -eq $true} |foreach {$_.disable()}
$hostname = (get-DHCPHostname)
# $dnsname = (gwmi win32_networkadapterconfiguration | where {$_.ipenabled -eq "true" -and $_.dhcpenabled -eq "true"}).dnsdomain
# $env:ise_mock_fqdn=$hostname + "." + $dnsname
$env:ise_mock_fqdn = get-DHCPHostname
$env:FACTER_env_windows_installdir="X:\puppet-2.7.x"
$env:ise_kickstarting="yes"

#start of branch selection routine
$timer = 5
$i = 1

Do {
  Write-host -ForeGroundColor green -noNewLine "Press any key in $($timer-$i) seconds to enter a branch name"
  $pos = $host.UI.RawUI.get_cursorPosition()
  $pos.X = 0
  $host.UI.RawUI.set_cursorPosition($Pos)
  if($host.UI.RawUI.KeyAvailable) {
    $Host.UI.RawUI.FlushInputBuffer()
    write-output ""
    $branch= Read-Host "Please enter the branch you would like to run the puppet agent against"
    $timer=-1
  }
start-Sleep -Seconds 1

$i++
}While ($i -le $timer)
if (!$branch) {$branch = "production"}
# end of branch selection routine

X:\host-enforce.ps1 -b $branch -tags "winbuild, choco, ringo" -disableeventlog true
X:\post-puppet.ps1