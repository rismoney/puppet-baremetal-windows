class winbuild::win2012 {
  # create the unattend.xml based on template
  file {'unattend-std-win2012.xml':
    ensure   => present,
    path     => 'X:/build/unattend-std-win2012.xml',
    content  => template("${module_name}/unattend-std-win2012.xml.erb"),
  }

  File <| title == 'post-puppet.ps1' |>
}
