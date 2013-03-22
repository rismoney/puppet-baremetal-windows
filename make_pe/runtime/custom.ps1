$env:ise_mock_fqdn="pc-thin01.prod.ise.com"
$env:FACTER_env_windows_installdir="X:\puppet-2.7.x"
$env:ise_kickstarting="yes"
X:\host-enforce.ps1 -b rismoney_winbuild_baremetal -tags "winbuild choco ringo" -disableeventlog true
X:\post-puppet.ps1