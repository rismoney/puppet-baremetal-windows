if ($PSVersionTable.PSVersion.Major -ge 4) {
  if (test-path "C:\WinPE_x86\WinPE_$bitversion.iso") {
    (Get-FileHash "C:\WinPE_x86\WinPE_$bitversion.iso").Hash | out-file "C:\WinPE_$bitversion\WinPE_$bitversion.iso.md5"
  }
}