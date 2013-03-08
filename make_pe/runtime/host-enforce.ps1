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
    $branch="production",
    [parameter(Mandatory=$false)]
    [alias("n")]
    [switch]$noop=$False,
    [parameter(Mandatory=$false,HelpMessage="tag please")]
    [alias("t")]
    $tags="",
    [parameter(Mandatory=$false)]
    [alias("h")]
    [switch]$help
)

if ($help) {
get-help .\host-enforce.ps1
break;
}

#config file not gonna work yet so ensure its not present
$config="C:\@inf\winbuild\scripts\ringo.conf"

$logfile="C:\@inf\winbuild\logs\ringo\$(Get-Date -Format 'yyyy-MM-dd-HHmmss').txt"

if (Test-Path $config) {
  $options=Get-Content $config
}
else {
#this should always be the case
$server="puppet.inf.ise.com"
$options="agent --pluginsync --no-daemonize --onetime --ignorecache --no-usecacheonfailure --show_diff --verbose --debug --environment $branch --logdest $logfile"
}

if ($noop) {$options+=" --noop"}
$options+=" $server"

if ($tags) {$options+=" --tags ""$tags"""}
$options+=" $server"
$options
# apply one branch
$rc=0

#New-EventLog -Source Puppet -LogName Application -ErrorAction SilentlyContinue
#write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Information -message "info: running branch $branch" -category 1 -rawdata 10,20

mkdir "C:\@inf\winbuild\logs\ringo" -ErrorAction SilentlyContinue

add-content $logfile $branch`n
add-content $logfile "=========================="

# invoked directly because path problems with spaces... 
Set-Location 'C:\Program Files (x86)\Puppet Labs\Puppet Enterprise\bin'
invoke-expression ".\puppet.bat $options"
set-location 'C:\@inf\winbuild\scripts'

$rc=$LASTEXITCODE

#need clarification on egrep action.  i need a working puppet agent on win to validate.
#guessing searching log files for err and skipping...

$errors=Get-Content $logfile | Select-String "err" 
$warnings=Get-Content $logfile | Select-String "skipping" 

#if ($warnings) {write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Warning -message "warning: running branch $branch. $warnings" -category 1 -rawdata 10,20}
#if ($errors) {write-eventlog -logname Application -source Puppet -eventID 9999 -entrytype Error -message "error: running branch $branch. $errors" -category 1 -rawdata 10,20}

exit $rc