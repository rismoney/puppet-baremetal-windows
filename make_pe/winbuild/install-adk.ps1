function install-adk {
  $regval = Get-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{fc46d1b2-9557-4c1f-baac-04af4d2db7e4}" -Name "Installed"
  if($regval.Installed -ne 1) {
    try {
      write-output "installing adksetup.exe - this can take several minutes"
      $adksetupargs="/quiet /promptrestart /ceip off /installpath ""$adkfolder"" /features OptionId.DeploymentTools OptionId.WindowsPreinstallationEnvironment"
      Start-Process "C:\download\adksetup.exe" -ArgumentList $adksetupargs -NoNewWindow -Wait -ea stop
      write-output "done installing adksetup.exe"
    }
    catch {
      write-output "no adksetup.exe in download"
      exit 1
    }
  }
  else { write-output 'adk has already been installed'}
}