
module Pomo
  class Notifier
    class NotificationCenter
      def notify(message, opts = {})
        title = 'Pomo'

        TerminalNotifier.notify message, :title => title, :subtitle => opts[:header]
      end
    end

  end
end
