require 'facter'
Facter.add(:ise_mock_hostname) do
  # DO NOT CONFINE: this is cross-platform
  setcode do
    Facter.value(:ise_mock_fqdn).split('.').first
  end
end
