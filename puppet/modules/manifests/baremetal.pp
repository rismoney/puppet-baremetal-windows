class winbuild::baremetal {

  # WinPE has no facility for it's own name.  Windows clients do not
  # support dhcp scope option 12 (hostname)

  # We work around this with a script that retrieves dhcp scope option 12 and
  # populate the environment variables accordingly

  $compname = $::ise_mock_hostname
  $joindomain = $::ise_mock_host_realm

  # lets build the machine objects OU based on the hostname
  $function_rdn = hiera('function_rdn','need default')
  $site_rdn = hiera('site_rdn','need default')
  $env_rdn = hiera('env_rdn','need default')

  # pending realm change $domain_naming_context = hiera('domain_naming_context')
  $domain_naming_context='DC=foo,dc=bar,DC=com'

  # domain controllers do not go into OU.  They go into CN=Domain Controllers
  # so we put this in as an exception.
  if $::ise_mock_function == 'ad' {
    $machineobjectou = "${function_rdn},${domain_naming_context}"
  }
  else {
    $machineobjectou = "${function_rdn},${site_rdn},${env_rdn},${domain_naming_context}"
  }

  # we need to provide unattend.xml template with a path to oem drivers
  $driverpath = 'C:\$oem$\drivers'

  # to join a domain we need an account with the rights.  This account can join a computer
  # to office, prod, test, inf

  $domain = hiera('join_domain_domain')
  $password = hiera ('join_domain_password')
  $username = hiera ('join_domain_user')

  # we need to make sure we diskpart, before we do any activities on the disk
  Exec['diskpart'] -> File['C:\@inf']

  # drop the script that diskpart will run through
  file {'diskpart0.txt':
    ensure   => present,
    path     => 'X:\build\diskpart0.txt',
    source   => "puppet:///modules/${module_name}/DiskPart/diskpart0.txt",
    require  => File['x:\build']
  }

  # make the CD-ROM drive E: this prevents interference with dynamic drive letter associations.
  exec { 'cd-to-e':
    command   => '(gwmi Win32_cdromdrive).drive | %{$a = mountvol $_ /l;mountvol $_ /d;$a = $a.Trim();mountvol e: $a}',
    require   => File['diskpart0.txt'],
    provider  => powershell
  }

  # execute the diskpart0 script after we fix the cdrom drive
  # added the mkdir due to disk availability peculiarity.
  # puppet doesn't like empty disk perhaps due to some check?
  exec { 'diskpart':
    command   => 'cmd /c "X:\windows\system32\diskpart.exe /s X:\build\diskpart0.txt && mkdir C:\@inf"',
    require   => Exec['cd-to-e'],
  }

  # create all the folders we use for the builds after diskpart did its thing
  file { ['C:\@inf',
          'C:\@inf/winbuild',
          'C:\@inf/winbuild/scratch',
          'C:\@inf/winbuild/packages',
          'C:\@inf/winbuild/scripts',
          'C:\@inf/winbuild/logs',
          ]:
          ensure  => 'directory',
          require => Exec['diskpart'],
  }

  # download the OEM drivers.  This should be reviewed for EMC storage devices.
  exec { 'WinPE-oem':
    command   => '. X:\tools\Get-WebFile.ps1 ; get-webfile http://chocopackages.example.com/HPSPP/WinPE-oem.zip c:\@inf\winbuild\packages\WinPE-oem.zip',
    require   => [Exec['diskpart'],File['C:\@inf/winbuild/packages'] ],
    provider  => powershell
  }

  # unzip the oem drivers using 7zip.  we have 7zip cli from puppet-baremetal project
  exec { 'Extract-WinPE-oem':
    command   => 'X:\tools\7za.exe x -y "-oC:\" c:\@inf\winbuild\packages\WinPE-oem.zip "-aos"',
    require   => Exec['WinPE-oem'],
  }

  # drop the script used to the the pagefile size.  currently based on
  # total mem +1 MB

  file {'set-pagefile':
    ensure   => present,
    path     => 'C:\@inf/winbuild/scripts/set-pagefilesize.ps1',
    require  => File['C:\@inf/winbuild/scripts'],
    source   => "puppet:///modules/${module_name}/scripts/set-pagefilesize.ps1",
  }

  # drop the script used to deploy chocolatey!  Woot to the choco gods!
  file {'inst-chocolatey.ps1':
    ensure   => present,
    path     => 'C:\@inf/winbuild/scripts/inst-chocolatey.ps1',
    require  => File['C:\@inf/winbuild/scripts'],
    source   => "puppet:///modules/${module_name}/scripts/inst-chocolatey.ps1",
  }

  @file {'post-puppet.ps1':
    ensure   => present,
    path     => 'X:/post-puppet.ps1',
    content  => template('winbuild/post-puppet.ps1.erb'),
  }
}
