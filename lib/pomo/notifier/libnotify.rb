
module Pomo
  class Notifier
    class Libnotify
      def notify(message, subtitle = '', type = nil)
        title = 'Pomo'
        full_message = [subtitle, message].join(' ')

        Libnotify.show :body => full_message, :summary => title
      end
    end

  end
end
