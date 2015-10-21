function unzip-winbits {

  $rubyfolder = join-path $mountfolder "\ruby200"
  $devkitfolder = join-path $mountfolder "\devkit"
  $patchfolder = join-path $mountfolder "\patch"

  unzip7-file $rubyfile $downloadfolder
  unzip7-file $devkitfile $devkitfolder
  unzip7-file $patchfile $patchfolder

  unzip7-file $puppetfile $mountfolder
  unzip7-file $facterfile $mountfolder
}
