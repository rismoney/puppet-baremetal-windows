function install-adk {
  $regval = Get-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{c09c49ab-d6a5-4543-bb31-639821977b42}" -Name "Installed" -erroraction silentlycontinue
  if($regval.Installed -ne 1) {
    try {
      write-output "installing adksetup.exe - this can take several minutes"
      pushd C:\download\adk
      
      Start-Process C:\download\adk\adksetup.exe -ArgumentList "/features OptionId.DeploymentTools OptionId.WindowsPreinstallationEnvironment /ceip off /norestart /log c:\@inf\adklog.txt" -Wait
      write-output "completed installation of adksetup.exe"
    }
    catch {
      write-output "no adksetup.exe in download"
      exit 1
    }
  }
  else { write-output 'adk has already been installed'}
}
