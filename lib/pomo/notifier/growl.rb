
module Pomo
  class Notifier
    class Growl
      def notify(message, subtitle = '', type = nil)
        title = 'Pomo'
        full_message = [subtitle, message].join(' ')

        if type.equal? :warning
          Growl.notify_warning full_message
        else
          Growl.notify_info full_message
        end
      end
    end

  end
end
