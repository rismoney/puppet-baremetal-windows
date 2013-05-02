$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$winbuild = join-path $here "\winbuild"
$config = join-path $here "\config"
$patchfolder = join-path $here "\patches"
$runtimefolder = join-path $here "\runtime"

Resolve-Path $config\config.ps1 | % { . $_.ProviderPath }
Resolve-Path $winbuild\*.ps1 |
    ? { -not ($_.ProviderPath.Contains(".Tests.")) } |
    % { . $_.ProviderPath }

download-winbits
install-adk
build-wim
make-iso
