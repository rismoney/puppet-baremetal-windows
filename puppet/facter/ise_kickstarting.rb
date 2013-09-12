# vim: set ts=2 sw=2 ai et:
require 'facter'

module Ise
  class Ks
    def self.ise_kickstarting
      if ENV.key?('ISE_KICKSTARTING')
        mock_kickstarting ? 'yes' : 'no'
      else
        real_kickstarting ? 'yes' : 'no'
      end
    end

    def self.proc_cmdline
      File.read '/proc/cmdline' rescue nil
    end

    def self.real_kickstarting
      /\sks=/.match(proc_cmdline) ? true : false
    end

    def self.mock_kickstarting
      /^(y(es)*|t(rue)*)$/i.match(ENV['ISE_KICKSTARTING']) ? true : false
    end
  end
end
Facter.add(:ise_kickstarting) do
  # DO NOT CONFINE
  setcode {Ise::Ks.ise_kickstarting}
end
