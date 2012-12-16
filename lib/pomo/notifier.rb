
module Pomo
  class Notifier

    ##
    # Initialize notifier library from configuration.
    def initialize(config)
      if config.notifier == 'notification_center'
        @notifier = Pomo::Notifier::NotificationCenter.new
      elsif config.notifier == 'libnotify'
        @notifier = Pomo::Notifier::Growl.new
      elsif config.notifier == 'growl'
        @notifier = Pomo::Notifier::Libnotify.new
      elsif config.notifier == 'quicksilver'
        @notifier = Pomo::Notifier::Quicksilver.new
      end
    end

    ##
    # Send message to notification library.
    def notify(message, opts = {})
      @notifier.notify(message, opts)
    end

  end
end
