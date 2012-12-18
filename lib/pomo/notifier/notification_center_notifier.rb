
module Pomo
  class Notifier
    class NotificationCenterNotifier
      def notify(message, opts = {})
        title = 'Pomo'

        TerminalNotifier.notify message, :title => title, :subtitle => opts[:header]
      end
    end

  end
end
