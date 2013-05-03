. X:\get-DHCPHostname.ps1
#disable all nics except "Ethernet"  windows 2012 is deterministic...
gwmi -class win32_networkadapter |where-object {$_.netconnectionid -ne "Ethernet" -and $_.netenabled -eq $true} |foreach {$_.disable()}
$hostname = (get-DHCPHostname)
# $dnsname = (gwmi win32_networkadapterconfiguration | where {$_.ipenabled -eq "true" -and $_.dhcpenabled -eq "true"}).dnsdomain
# $env:ise_mock_fqdn=$hostname + "." + $dnsname
$env:ise_mock_fqdn = get-DHCPHostname
$env:FACTER_env_windows_installdir="X:\puppet-2.7.x"
$env:ise_kickstarting="yes"
X:\host-enforce.ps1 -b production -tags "winbuild, choco, ringo" -disableeventlog true
X:\post-puppet.ps1