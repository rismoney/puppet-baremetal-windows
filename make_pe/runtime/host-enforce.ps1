<#
.SYNOPSIS
    .
.DESCRIPTION
    host enforcer for puppet
.PARAMETER b
    The branch to the .
.PARAMETER n
    noop
.EXAMPLE
    host-enforce.ps1
.NOTE
    Author: Rich Siegel, Alan Moy
#>

Param(
    [parameter(Mandatory=$false,HelpMessage="branch please")]
    [alias("b")]
    $branch="",
    [parameter(Mandatory=$false)]
    [alias("n")]
    [switch]$noop=$False,
    [parameter(Mandatory=$false,HelpMessage="tag please")]
    [alias("t")]
    $tags="",
    [parameter(Mandatory=$false)]
    [alias("h")]
    [switch]$help,
    [parameter(Mandatory=$false)]
    [alias("l")]
    $disableeventlog=$false,
    [parameter(Mandatory=$false,HelpMessage="email addr please")]
    [alias("e")]
    $emailaddr="",
    [parameter(Mandatory=$false)]
    [alias("c")]
    [switch]$clean
    [parameter(Mandatory=$false,HelpMessage="branch please")]
    $certname=""

)

if ($help) {
get-help .\host-enforce.ps1
break;
}

# grab current directory
$current_dir = Get-Location

# determine if module is available
$module = "ServerManager"
$moduleAvailable = Get-Module -ListAvailable | Where-Object { $_.Name -eq $module }

# if module is available determine if remote desktop server (citrix, terminal services, etc):
if ($moduleAvailable.Name -eq $module) {
import-module $module
$rdsState=(Get-WindowsFeature | Where-Object {$_.Name -eq "RDS-RD-Server"}).Installed
}

#config file not gonna work yet so ensure its not present

if (Test-Path 'C:\Program Files\Puppet Labs\Puppet') {
  $puppetpath = 'C:\Program Files\Puppet Labs\Puppet\bin\'
}
elseif (Test-Path 'C:\Program Files (x86)\Puppet Labs\Puppet') {
$puppetpath = 'C:\Program Files (x86)\Puppet Labs\Puppet\bin\'
}
else {
  $puppetpath = 'C:\Program Files (x86)\Puppet Labs\Puppet Enterprise\bin'
}
$smtpserver = "ix-smtp01.inf.ise.com"
$ringologfolder = 'C:\@inf\winbuild\logs\ringo'
$config='C:\@inf\winbuild\scripts\ringo.conf'
$logfile="$ringologfolder\$(Get-Date -Format 'yyyy-MM-dd-HHmmss').txt"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

  if (-not(test-path -path $ringologfolder)) {
    mkdir $ringologfolder -ErrorAction SilentlyContinue
  }

if ($clean) {
  # remove local SSL directory (assuming local certs don't match the puppet master)
  # on the puppet master you will need to perform a 'puppet cert clean <host>'
  Write-Host '[INFO] Cleaning out local SSL certificates'
  Remove-Item 'C:\ProgramData\PuppetLabs\puppet\etc\ssl' -Force -Recurse
}

if (Test-Path $config) {
  [xml]$ConfigFile=Get-Content $config
  $server = $ConfigFile.Settings.PuppetMaster
}
else {
  $server=get-content "X:\puppetmaster.conf"
}

$options="agent --pluginsync --no-daemonize --onetime --ignorecache --no-usecacheonfailure --show_diff --verbose --debug --logdest $logfile --waitforcert 120"
if ($branch) {$options+=" --environment $branch"}
if ($noop) {$options+=" --noop"}
if ($tags) {$options+=" --tags ""$tags"""}
if ($certname) {$options+=" --certname ""$certname"""}

$options+=" --server $server"
$options
# apply one branch
$rc=0

if (!$disableeventlog) {
  New-EventLog -Source Puppet -LogName Application -ErrorAction SilentlyContinue
  write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Information -message "info: running branch $branch" -category 1 -rawdata 10,20
}

if ($rdsState) {
  write-output "Changing Remote Desktop Server to installation mode..."
  change user /install
}

add-content $logfile $branch`n
add-content $logfile $options`n
add-content $logfile "=========================="

$agent_catalog_run_lockfile = puppet agent --configprint agent_catalog_run_lockfile
$agent_disabled_lockfile = puppet agent --configprint agent_disabled_lockfile

# check if puppet is already running, if so task kill it
if (Test-Path $agent_catalog_run_lockfile) {
  Write-Host '[INFO] Puppet is already running, attempting to stop'
  taskkill.exe /IM:ruby.exe /F /T
  Remove-Item $agent_catalog_run_lockfile -Force
}

# rarely a puppet run does not end cleanly and it will leave a deadlock file, we remove it if found
if (Test-Path C:\ProgramData\PuppetLabs\puppet\var\state\puppetdlock) {
  Write-Host '[INFO] Puppet deadlock file found. Removing puppetdlock file'
  Remove-Item 'C:\ProgramData\PuppetLabs\puppet\var\state\puppetdlock' -Force
}

if (Test-Path $agent_disabled_lockfile) {
  Write-Host '[INFO] Agent disabled lock file found.  Removing..'
  Remove-Item $agent_disabled_lockfile -Force
}

# invoked directly because path problems with spaces...
Set-Location $puppetpath
invoke-expression ".\puppet.bat $options"
set-location $here

$rc=$LASTEXITCODE

if ($rdsState) {
  write-output "Changing Remote Desktop Server to execution mode..."
  change user /execute
}

$errors=Get-Content $logfile | Select-String -pattern "^err"
$warnings=Get-Content $logfile | Select-String -pattern "^skipping"

if (!$disableeventlog) {
  if ($warnings) {write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Warning -message "warning: running branch $branch. $warnings" -category 1 -rawdata 10,20}
  if ($errors) {write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Error -message "error: running branch $branch. $errors" -category 1 -rawdata 10,20}
}

if ($emailaddr) {
$fromaddress = "donotreply@ise.com"
$body = get-content $logfile
$subject ="host-enforce log for:" + $server + " branch:" + $branch
$message = new-object System.Net.Mail.MailMessage
$message.From = $fromaddress
$message.To.Add($emailaddr)
$message.IsBodyHtml = $False
$message.Subject = $Subject
$message.body = $body
$smtp = new-object Net.Mail.SmtpClient($smtpserver)
$smtp.Send($message)
}

# Change back to original directory user ran script from
Set-Location $current_dir.path

exit $rc
