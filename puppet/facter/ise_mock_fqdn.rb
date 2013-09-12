# vim: set ts=2 sw=2 ai et:
require 'facter'

module Ise
  # Host impersonation helper
  #
  # {Ise::Helper.ise_mock_fqdn} is the primary interface
  class Helper
    # Find ISE_MOCK_FQDN
    #
    # 1st answer wins in order of:
    #
    # 1. kernel
    # 2. environment
    # 3. real fqdn
    #
    # @return [String] in all cases
    def self.ise_mock_fqdn
      (
        kernel_value('ISE_MOCK_FQDN') ||
        env_value('ISE_MOCK_FQDN')    ||
        Facter.value(:fqdn)
      ).to_s.downcase
    end

    # Read the linux kernel command-line
    #
    # @return [String] on Linux
    # @return [nil] on other platforms
    def self.proc_cmdline
      File.read('/proc/cmdline').chomp
    rescue
      nil
    end

    # Find value of an environment variable
    #   or nil if environment is undefined/empty
    #
    # @param key [String] name of an environment variable
    #
    # @return [String] if `key` is defined
    # @return [nil] if `key` is undefined or empty
    def self.env_value(key)
      val = ENV[key].to_s
      val.length > 0 ? val : nil
    end

    # Find value of a key-value pair from Linux kernel command-line
    #
    # @param key [String] name of variable
    #
    # @return [String] if `key=value` exists in Linux kernel command-line
    # @return [nil] otherwise
    def self.kernel_value(key)
      m = /\b(#{key}=\S+)/.match(proc_cmdline)
      m ? m[1].split('=').last : nil
    end
  end
end

Facter.add(:ise_mock_fqdn) do
  # DO NOT CONFINE
  setcode {Ise::Helper.ise_mock_fqdn}
end
