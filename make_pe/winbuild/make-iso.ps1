function make-iso {

# this needs cleanup
#  lets prep the iso
  $isofolder=join-path $winpefolder "\ISO"

  mkdir "$winpefolder\ISO"

  xcopy /s "$adkfolder\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\Media" $isofolder

  # source bits into the iso
  mkdir "$isofolder\sources"
  copy "$winpefolder\winpe.wim" "$isofolder\Sources\boot.wim"
  copy "$adkfolder\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg\oscdimg.exe" $winpefolder
  copy "$adkfolder\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg\etfsboot.com" $winpefolder

  # we don't want a press any key to continue since we can't find ours :)
  rm "$winpefolder\ISO\Boot\bootfix.bin"

  #lets make the iso (its about time)

   & "$oscdimg" -bC:\WinPE_x86\etfsboot.com -n C:\WinPE_x86\ISO C:\WinPE_x86\WinPE_x86.iso
}