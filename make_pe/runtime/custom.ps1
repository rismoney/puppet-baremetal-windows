. X:\get-DHCPHostname.ps1
#disable all nics except "Ethernet"  windows 2012 is deterministic...
# this is done to ensure the primary adapter ties back to the DHCP reservatoin
gwmi -class win32_networkadapter |where-object {$_.netconnectionid -ne "Ethernet" -and ($_.netenabled -eq $true -or $_.netconnectionstatus -eq '7')} |foreach {$_.disable()}

# we get the dhcp scope option 12 via get-dhcphostname script since windows dhcp cannot get it on its own.
# reference : http://support.microsoft.com/kb/121005/en-us

$hostname = (get-DHCPHostname)
# $dnsname = (gwmi win32_networkadapterconfiguration | where {$_.ipenabled -eq "true" -and $_.dhcpenabled -eq "true"}).dnsdomain
# $env:ise_mock_fqdn=$hostname + "." + $dnsname

# set an environment variables.  The ise_mock_fqdn and ise_kickstarting tie back to facter facts
# ise_mock_fqdn overcomes the issue where Windows PE typically boots with a name like MINI-NT######
$env:ise_mock_fqdn = get-DHCPHostname
$env:FACTER_env_windows_installdir="X:\puppet-2.7.x"
$env:ise_kickstarting="yes"


# we will pause for 5 seconds waiting for user input.  If a key is pressed we will allow the user
# to manually type a branch name.  If no branch is provided, we will be using production.

#start of branch selection routine
$timer = 600
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

# this might need to be changed to "master" instead of production depending upon git branching workflow you use
if (!$branch) {$branch = "production"}
# end of branch selection routine

# call host-enforce against our 3 relevant modules.  host-enforce is a puppet agent run
X:\host-enforce.ps1 -b $branch -tags "winbuild, choco, ringo" -disableeventlog true

# call out post puppet script (this is empty in this repo- but we deploy a replacement file to do more needful ops)
X:\post-puppet.ps1
