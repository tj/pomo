
module Pomo
  class Notifier
    class NotificationCenter
      def notify(message, subtitle = '', type = nil)
        title = 'Pomo'

        TerminalNotifier.notify message, :title => title, :subtitle => subtitle
      end
    end

  end
end
