function make-iso {

# this needs cleanup
#  lets prep the iso
  $isofolder=join-path $winpefolder "\ISO"

  mkdir "$winpefolder\ISO"

  xcopy /s "$adkfolder\Assessment and Deployment Kit\Windows Preinstallation Environment\$bitversion\Media" $isofolder

  # source bits into the iso
  mkdir "$isofolder\sources"
  copy "$winpefolder\winpe.wim" "$isofolder\Sources\boot.wim"
  copy "$adkfolder\Assessment and Deployment Kit\Deployment Tools\$bitversion\Oscdimg\oscdimg.exe" $winpefolder
  copy "$adkfolder\Assessment and Deployment Kit\Deployment Tools\$bitversion\Oscdimg\etfsboot.com" $winpefolder

  # we don't want a press any key to continue since we can't find ours :)
  rm "$winpefolder\ISO\Boot\bootfix.bin"

  #lets make the iso (its about time)
   $biosbootpath = join-path -path "C:\WinPE_$bitversion" -childpath "etfsboot.com"
   $isopath = "C:\WinPE_$bitversion\ISO"
   $iso = join-path -path "C:\WinPE_$bitversion" -childpath "WinPE_$bitversion.iso"
   & "$oscdimg" -n $isopath $iso -b"$biosbootpath"
}