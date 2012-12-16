
module Pomo
  class Notifier
    class Libnotify
      def notify(message, opts = {})
        title = 'Pomo'
        full_message = [opts[:header], opts[:message]].join(' ').lstrip

        Libnotify.show :body => full_message, :summary => title
      end
    end

  end
end
