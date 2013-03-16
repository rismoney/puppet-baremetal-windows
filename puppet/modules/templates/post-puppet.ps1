net use V: \\server\w2k8bits /user:test nopasswordhere
X:\tools\imagex.exe /apply V:\dist\sources\install.wim 1 C:\
copy X:\build\unattend-std-puppet.xml c:\windows\system32\sysprep\unattend.xml
bcdboot C:\windows