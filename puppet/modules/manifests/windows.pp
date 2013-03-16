class winbuild::windows {
  if $::ise_mock_function == 'thin' {
    include winbuild::baremetal
  }
}
