
module Pomo
  class Notifier
    class Growl
      def notify(message, opts = {})
        full_message = [opts[:header], opts[:message]].join(' ').lstrip

        if opts[:type].equal? :warning
          Growl.notify_warning full_message
        else
          Growl.notify_info full_message
        end
      end
    end

  end
end
