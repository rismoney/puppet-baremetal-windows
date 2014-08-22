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
    blah
.NOTES
    Author: Rich Siegel
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
    [alias("e")]
    $disableeventlog=$false
)
$disableeventlog
if ($help) {
get-help .\host-enforce.ps1
break;
}

#config file not gonna work yet so ensure its not present
#$puppetpath='x:\Program Files (x86)\Puppet Labs\Puppet Enterprise\bin'
$ringologfolder = 'x:\'
$config='X:\config\ringo.conf'
$logfile="$ringologfolder\$(Get-Date -Format 'yyyy-MM-dd-HHmmss').txt"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

  if (-not(test-path -path $ringologfolder)) {
    mkdir -p $ringologfolder -ErrorAction SilentlyContinue
  }

if (Test-Path $config) {
  $options=Get-Content $config
}
else {
#this should always be the case
$server="puppet.inf.ise.com"
$options="agent --pluginsync --no-daemonize --onetime --ignorecache --no-usecacheonfailure --show_diff --verbose --debug --logdest $logfile"
}

if ($branch) {$options+=" --environment $branch"}
if ($noop) {$options+=" --noop"}
if ($tags) {$options+=" --tags ""$tags"""}

$options+=" --server $server"
$options
# apply one branch
$rc=0

if (!$disableeventlog) {
  New-EventLog -Source Puppet -LogName Application -ErrorAction SilentlyContinue
  write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Information -message "info: running branch $branch" -category 1 -rawdata 10,20
}

add-content $logfile $branch`n
add-content $logfile $options`n
add-content $logfile "=========================="

# invoked directly because path problems with spaces... 
#Set-Location $puppetpath
invoke-expression "puppet $options"
set-location $here

$rc=$LASTEXITCODE

$errors=Get-Content $logfile | Select-String -pattern "^err" 
$warnings=Get-Content $logfile | Select-String -pattern "^skipping" 

if (!$disableeventlog) {
  if ($warnings) {write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Warning -message "warning: running branch $branch. $warnings" -category 1 -rawdata 10,20}
  if ($errors) {write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Error -message "error: running branch $branch. $errors" -category 1 -rawdata 10,20}
}
exit $rc