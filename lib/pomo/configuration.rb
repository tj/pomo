module Pomo
  class Configuration
    ##
    # Notification library.
    #
    # values: notification_center | libnotify | growl | quicksilver

    attr_reader :notifier

    ##
    # Refresh tmux status bar.
    #
    # values: true | false

    attr_accessor :tmux

    ##
    # Initialize configuration.
    def initialize
      options = {
        :notifier  => default_notifier,
        :tmux      => false
      }

      config_file = File.join(ENV['HOME'],'.pomorc')

      if File.exists? config_file
        config_options = YAML.load_file(config_file)
        options.merge!(config_options)
      else
        File.open(config_file, 'w') { |file| YAML::dump(options, file) }
        STDERR.puts "Initialized configuration file in #{config_file}"
      end

      @notifier  = options[:notifier]
      @tmux      = options[:tmux]
    end

    private

    def default_notifier
      if Pomo::OS.has_notification_center?
        return 'notification_center'
      elsif Pomo::OS.linux?
        return 'libnotify'
      else
        return 'growl'
      end
    end

  end
end
