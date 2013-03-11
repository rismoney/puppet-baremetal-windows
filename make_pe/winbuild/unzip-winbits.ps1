function unzip-winbits {

  shellunzip-file $zipfile $downloadfolder 
  remove-item "$downloadfolder\*.txt"
  remove-item "$downloadfolder\*.chm"

  $rubyfolder = join-path $mountfolder "\ruby187"
  $devkitfolder = join-path $mountfolder "\devkit"
  $patchfolder = join-path $mountfolder "\patch"

  unzip7-file $rubyfile $downloadfolder
  unzip7-file $devkitfile $devkitfolder
  unzip7-file $patchfile $patchfolder

  unzip7-file $puppetfile $mountfolder
  unzip7-file $facterfile $mountfolder
}
