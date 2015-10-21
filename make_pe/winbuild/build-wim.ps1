function build-wim {

  write-output "Create the WinPE working folder"

  if (-not(test-path -path $winpefolder)) {
    mkdir $winpefolder
  }
  else {
    rename-item $winpefolder "$winpefolder-$(Get-Date -Format 'yyyy-MM-dd-HHmmss')"
    mkdir $winpefolder
  }

  write-output "copy winpe wim to our working folder"
  $winpewim = "$adkfolder\Assessment and Deployment Kit\Windows Preinstallation Environment\$bitversion\en-us\winpe.wim"
  copy $winpewim $winpefolder

  write-output "mount the wim"
  try {
    $winpewim_file="$winpefolder\winpe.wim"
    & $dism /mount-image /imagefile:$winpewim_file /index:1 /MountDir:$mountfolder /optimize
  }
  catch {
    write-output "error mounting wim"
    exit 1
  }

    write-output "set the scratch space"
  try {
    $winpewim_file="$winpefolder\winpe.wim"
    & $dism /image:$mountfolder /set-scratchspace:128
	sleep 3
  }
  catch {
    write-output "error setting scratchspace"
    exit 1
  }
  
  write-output "perform all the extractions to the mount folder"
  unzip-winbits

  mkdir "$mountfolder\tools" -ea silentlycontinue

  echo d | xcopy /S /Y "$downloadfolder\ruby-2.0.0-p645-x64-mingw32\*.*" "$mountfolder\Ruby200"

  write-output "copy gems file to the mount"
  echo d | xcopy /S /Y "$downloadfolder\gems" "$mountfolder\gems\"

  write-output "#copy zip executable and dll"
  echo d | xcopy /S /Y "$downloadfolder\7z.exe" "$mountfolder\tools"
  echo d | xcopy /S /Y "$downloadfolder\7z.dll" "$mountfolder\tools"

  write-output "drop in the devkit config file with x:\ruby200"
  echo d | xcopy /Y "$config\config.yml" "$mountfolder\devkit"

  write-output "patch puppet source to not use eventlog (n/a in WinPE)"
  cmd /c "$mountfolder\patch\bin\patch.exe --force -d $mountfolder\puppet-3.8.3\lib\puppet\util\log -p 0 < $patchfolder\destinations.rb.patch"

  write-output "patch puppet source to not do volume inspection for ntfs (X:\ is not a traditional volume) so we just say it is"
  #cmd /c "$mountfolder\patch\bin\patch.exe --force -d $mountfolder\puppet-3.6.2\lib\puppet\util\windows -p 0 < $patchfolder\security.rb.patch"

  #write-output "patch puppet source to not mess with mode on windows"
  #cmd /c "$mountfolder\patch\bin\patch.exe --force -d $mountfolder\puppet-3.6.2\lib\puppet\type\file -p 0 < $patchfolder\source.rb.patch"

  
  mkdir "$mountfolder\ProgramData\PuppetLabs\facter\facts.d"
  echo d | xcopy /Y "$config\puppet_installer.txt" "$mountfolder\ProgramData\PuppetLabs\facter\facts.d"
  add-content "$mountfolder\ProgramData\PuppetLabs\facter\facts.d\puppet_installer.txt" "`nfact_stomp_server=$puppetmaster"

  write-output "win pe startup scripts"
  echo d |xcopy /Y "$runtimefolder\startnet.cmd" "$mountfolder\Windows\System32"
  echo d |xcopy /Y "$runtimefolder\custom.ps1" "$mountfolder"
  echo d |xcopy /Y "$runtimefolder\host-enforce.ps1" "$mountfolder"
  #echo d |xcopy /Y "$runtimefolder\get-DHCPHostname.ps1" "$mountfolder"
  echo d | xcopy /S /Y "$downloadfolder\dhcptest-0.5-win64.exe" "$mountfolder"
  
  write-output "#copy zip executable"
  
  
  
  write-output "add get-webfile to winpe"
  echo d |xcopy /Y "$winbuild\Get-WebFile.ps1" "$mountfolder\tools"
  # echo d |xcopy /Y "$config\GemFile" "$mountfolder"

  #deprecate imagex
  #write-output "add imagex"
  #echo d |xcopy /Y "$adkfolder\Assessment and Deployment Kit\Deployment Tools\x86\DISM\imagex.exe" "$mountfolder\tools"

  write-output "add 3rd party drivers"
  if (test-path -path $driverfolder) {
    & $dism /image:$mountfolder /Add-Driver /Driver:"$driverfolder" /Recurse /ForceUnsigned
  }
  write-output "add packages"
  add-packages

  try {
    & $dism /unmount-image /mountdir:$mountfolder /commit
  }
  catch {
    write-output "error unmounting"
    exit 1
  }
}
