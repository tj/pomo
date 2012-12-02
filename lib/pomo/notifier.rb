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

    ##
    # Send message to notification library.
    def self.notify(message, subtitle = '', type = nil)
      title = 'Pomo'
      full_message = [subtitle, message].join(' ')

      if MACOS
        if (10.8 <= MACOS_VERSION)
          TerminalNotifier.notify message, :title => title, :subtitle => subtitle
        else
          if type.equal? :warning
            Growl.notify_warning full_message
          else
            Growl.notify_info full_message
          end
        end
      else
        Libnotify.show :body => full_message, :summary => title
      end
    end

  end
end
