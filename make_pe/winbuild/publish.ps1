if ($PSVersionTable.PSVersion.Major -ge 4) {
  (Get-FileHash C:\WinPE_x86\WinPE_x86.iso).Hash | out-file C:\WinPE_x86\WinPE_x86.iso.md5
  copy C:\WinPE_x86\WinPE_x86.iso.md5 C:\inetpub\wwwroot
  copy C:\WinPE_x86\WinPE_x86.iso C:\inetpub\wwwroot
}