class winbuild::windows {


  # if not in hiera fallback to Windows 2008
  $targetos = hiera('targetos','win2008')

  $imageno = $targetos ? {
    'win2008' => '1',# standard edition image on 2008
    'win2012' => '2',# standard edition image on 2012
    default     => '1',
  }

  if $::ise_kickstarting == 'yes' {
    class {'winbuild::baremetal':}
    -> class {"winbuild::${targetos}":}
  }

  case $::productname {
    'VMware Virtual Platform': {
      include winbuild::vmware
    }
    'ProLiant BL460c G6',
    'ProLiant BL460c Gen8': {
      include winbuild::hpserver
    }
    default: { include winbuild::generic } # apply the generic class
  }
}