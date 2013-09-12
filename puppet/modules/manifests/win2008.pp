class winbuild::win2008 {

  # download dotnet 4. we need this to bootstrap chocolatey
  exec { 'DotNet4':
    command   => '. X:\tools\Get-WebFile.ps1 ; get-webfile http://chocopackages.example.com/dotNet/dotNetFx40_Full_x86_x64.exe c:\@inf\winbuild\packages\dotNetFx40_Full_x86_x64.exe',
    provider  => powershell
  }

  # drop a flag used later to determine if node should be upgraded to enterprise edition
  #$edition = hiera ('edition')
  $edition = 'enterprise'
  if $edition == 'enterprise' {
    exec { 'enteprise-touch':
      command   => 'cmd /c "type nul >>C:\@inf\winbuild\scratch\enterprise.txt & copy C:\@inf\winbuild\scratch\enterprise.txt +,,"',
      cwd       => 'C:/@inf/winbuild/scratch',
    }
  }

    # drop the script used to set a node to enterprise edition
  file {'Set-WinEdition.ps1':
    ensure   => present,
    path     => 'C:\@inf/winbuild/scripts/Set-WinEdition.ps1',
    source   => "puppet:///modules/${module_name}/scripts/Set-WinEdition.ps1",
  }

  # create the unattend.xml based on template
  file {'unattend-std-win2008.xml':
    ensure   => present,
    path     => 'X:/build/unattend-std-win2008.xml',
    content  => template("${module_name}/unattend-std-win2008.xml.erb"),
  }

  File <| title == 'post-puppet.ps1' |>
}
