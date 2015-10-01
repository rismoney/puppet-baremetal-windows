if ($PSVersionTable.PSVersion.Major -ge 4) {
  if (test-path C:\WinPE_x86\WinPE_x86.iso) {
    (Get-FileHash C:\WinPE_x86\WinPE_x86.iso).Hash | out-file C:\WinPE_x86\WinPE_x86.iso.md5
  }
}