function install-dep {

  $regval = Get-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{BFC9778E-9765-C94C-C082-C2514F8DEB9B}" -Name "Installed" -ea Silentlycontinue
  $regval
  if($regval.Installed -ne 1) {
    try {
      write-output "installing Windows Deployment Tools - this can take several minutes"
      $msifile = 'C:\download\adk\Windows Deployment Tools-x86_en-us.msi'
      $args = "/qn"
      start-process -filepath $msifile -ArgumentList "/qn" -Wait
      write-output "done installing"
    }
    catch {
      write-output "no Windows Deployment Tools-x86_en-us.msi in download"
      exit 1
    }
  }
  else { write-output 'Windows Deployment Tools has already been installed'}
}
