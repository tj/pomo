if RUBY_PLATFORM =~ /darwin/
  MACOS_FULL_VERSION = `/usr/bin/sw_vers -productVersion`.chomp
  MACOS_VERSION = /(10\.\d+)(\.\d+)?/.match(MACOS_FULL_VERSION).captures.first.to_f
  OS_VERSION = "Mac OS X #{MACOS_FULL_VERSION}"
  MACOS = true
else
  MACOS_FULL_VERSION = MACOS_VERSION = 0
  OS_VERSION = RUBY_PLATFORM
  MACOS = false
end

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
      if MACOS
        if (10.8 <= MACOS_VERSION)
          return 'notification_center'
        else
          return 'growl'
        end
      else
        return 'libnotify'
      end
    end

  end
end
