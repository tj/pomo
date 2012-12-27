require 'pomo/notifier/growl_notifier'
require 'pomo/notifier/libnotify_notifier'
require 'pomo/notifier/notification_center_notifier'

module Pomo
  class Notifier

    ##
    # Initialize notifier library from configuration.

    def initialize(config)
      if config.notifier == 'notification_center'
        @notifier = Pomo::Notifier::NotificationCenterNotifier.new
      elsif config.notifier == 'growl'
        @notifier = Pomo::Notifier::GrowlNotifier.new
      elsif config.notifier == 'libnotify'
        @notifier = Pomo::Notifier::LibnotifyNotifier.new
      elsif config.notifier == 'quicksilver'
        @notifier = Pomo::Notifier::QuicksilverNotifier.new
      end
    end

    ##
    # Send message to notification library.

    def notify(message, opts = {})
      @notifier.notify(message, opts)
    end

  end
end
