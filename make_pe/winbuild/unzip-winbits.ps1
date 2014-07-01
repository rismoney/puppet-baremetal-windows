function unzip-winbits {
  # first install 7zip silently to program files
  & "$downloadfolder\7z920.exe" "/S"

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
