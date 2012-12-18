module Pomo
  module OS
    module_function

    def linux?
      (/linux/ =~ RbConfig::CONFIG['host_os']) !=nil
    end

    def mac?
      (/mac|darwin/ =~ RbConfig::CONFIG['host_os']) != nil
    end

    def windows?
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RbConfig::CONFIG['host_os']) != nil
    end

    def has_notification_center?
      return false unless OS.mac?

      full_version = `/usr/bin/sw_vers -productVersion`.to_s.chomp
      version = /(10\.\d+)(\.\d+)?/.match(full_version).captures.first.to_f
      return (version >= 10.8)
    end

  end
end
