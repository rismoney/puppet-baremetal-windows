class winbuild::baremetal {

  file { 'x:\build':
    ensure => 'directory',
  }

  #this is purely a test of unattended substitution - it is fictional.
  $compname = 'pc-thin02'
  $driverpath = 'C:\$oem$\drivers'

  file {'diskpart.txt':
    ensure   => present,
    path     => 'X:\build\diskpart.txt',
    source   => "puppet:///modules/${module_name}/DiskPart/diskpart.txt",
    require  => File['x:\build']
  }

  exec { 'diskpart':
    command   => 'cmd /c "X:\\windows\\system32\\diskpart.exe /s X:\\build\\diskpart.txt"',
    require   => File['diskpart.txt'],
  }

  exec { 'WinPE-oem':
    command   => '. X:\tools\Get-WebFile.ps1 ; get-webfile http://chocopackages.ise.com/HPSPP/WinPE-oem.zip c:\WinPE-oem.zip',
    require   => Exec['diskpart'],
    provider  => powershell
  }

  exec { 'Extract-WinPE-oem':
    command   => 'X:\tools\7za.exe x -y "-oC:\" c:\WinPE-oem.zip "-aos"',
    require   => Exec['WinPE-oem'],
  }

  file {'unattend-std.xml':
    ensure   => present,
    path     => 'X:\build\unattend-std-puppet.xml',
    content  => template('winbuild/sysprep/unattend-std-puppet.xml.erb'),
    require  => Exec['diskpart'],
    #source   => "puppet:///modules/${module_name}/sysprep/unattend-std-puppet.xml",
  }
  
  file {'post-puppet.ps1':
    ensure   => present,
    path     => 'X:\post-puppet.ps1',
    content => template('winbuild/post-puppet.ps1'),
    #source   => "puppet:///modules/${module_name}/sysprep/unattend-std-puppet.xml",
  }
}
