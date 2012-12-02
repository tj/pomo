if RUBY_PLATFORM =~ /darwin/
  MACOS_FULL_VERSION = `/usr/bin/sw_vers -productVersion`.chomp
  MACOS_VERSION = /(10\.\d+)(\.\d+)?/.match(MACOS_FULL_VERSION).captures.first.to_f
  OS_VERSION = "Mac OS X #{MACOS_FULL_VERSION}"
  MACOS = true
else
  MACOS_FULL_VERSION = MACOS_VERSION = 0
  OS_VERSION = RUBY_PLATFORM
  MACOS = false
end


module Pomo
  class Notifier

    def initialize
      if MACOS
        if (10.8 <= MACOS_VERSION)
          @notifier = Pomo::Notifier::NotificationCenter.new
        else
          @notifier = Pomo::Notifier::Growl.new
        end
      else
        @notifier = Pomo::Notifier::Libnotify.new
      end
    end

    ##
    # Send message to notification library.
    def notify(message, subtitle = '', type = nil)
      @notifier.notify(message, subtitle, type)
    end

  end
end
