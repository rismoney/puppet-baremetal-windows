puppet agent --pluginsync --no-daemonize --onetime --ignorecache --no-usecacheonfailure --show_diff --verbose --debug --environment production --tags winbuild
Set $env:ise_mock_fqdn=pc-thin01.prod.ise.com
X:\host-enforce.ps1 -b production -tags winbuild -disableeventlog true