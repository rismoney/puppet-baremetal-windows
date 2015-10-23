function add-packages {
  # don't know what going to happen at the prom so we will be prepared.
  pushd "$adkfolder\Assessment and Deployment Kit\Windows Preinstallation Environment\$bitversion\WinPE_OCs"
  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-WMI.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-WMI_en-us.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-NetFx.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-NetFx_en-us.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-PowerShell.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-PowerShell_en-us.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-DismCmdlets.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-DismCmdlets_en-us.cab"
  popd
}