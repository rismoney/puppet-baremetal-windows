function ShellUnZip-File($zipfilename,$destination) { 

  $shellApplication = new-object -com shell.application 
  $zipPackage = $shellApplication.NameSpace($zipfilename) 
  $destinationFolder = $shellApplication.NameSpace($destination) 

  foreach ($item in $zipPackage.Items()) { 
    if (!(Test-Path "$destinationFolder\$item")) # If the file doesn't exist in the desination directory... 
      { $destinationFolder.CopyHere($item,0x16)  } 
    else {write-output "Skipping download $item"} 
  }
}