
module Pomo
  class Notifier
    class QuicksilverNotifier
      def notify(message, opts = {})
        `osascript -e 'tell application "Quicksilver" to show large type "#{message.gsub('"', '\"')}"'`
      end
    end

  end
end

