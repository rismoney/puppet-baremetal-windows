. X:\get-DHCPHostname.ps1
$hostname = (get-DHCPHostname)
# $dnsname = (gwmi win32_networkadapterconfiguration | where {$_.ipenabled -eq "true" -and $_.dhcpenabled -eq "true"}).dnsdomain
# $env:ise_mock_fqdn=$hostname + "." + $dnsname
$env:ise_mock_fqdn = get-DHCPHostname
$env:FACTER_env_windows_installdir="X:\puppet-2.7.x"
$env:ise_kickstarting="yes"
X:\host-enforce.ps1 -b rismoney_winbuild_baremetal -tags "winbuild, choco, ringo" -disableeventlog true
X:\post-puppet.ps1