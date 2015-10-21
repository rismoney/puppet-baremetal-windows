function add-packages {
  # don't know what going to happen at the prom so we will be prepared.
  pushd "$adkfolder\Assessment and Deployment Kit\Windows Preinstallation Environment\$bitversion\WinPE_OCs"
#  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-Scripting.cab"
#  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-Scripting_en-us.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-WMI.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-WMI_en-us.cab"
#  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-MDAC.cab"
#  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-MDAC_en-us.cab"
#  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-HTA.cab"
#  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-HTA_en-us.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-NetFx4.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-NetFx4_en-us.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-PowerShell3.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-PowerShell3_en-us.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"WinPE-DismCmdlets.cab"
  & $dism /image:$mountfolder /add-package /packagepath:"en-us\WinPE-DismCmdlets_en-us.cab"
  popd
}