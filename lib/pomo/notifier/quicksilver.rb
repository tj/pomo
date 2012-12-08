
module Pomo
  class Notifier
    class Quicksilver
      def notify(message, opts = {})
        `osascript -e 'tell application "Quicksilver" to show large type "#{message.gsub('"', '\"')}"'`
      end
    end

  end
end

