module Pomo
  class Configuration
    ##
    # Notification library.
    #
    # values: notification_center | libnotify | growl | quicksilver

    attr_reader :notifier

    ##
    # Run with progress bar.
    #
    # values: true | false

    attr_accessor :progress

    ##
    # Refresh tmux status bar.
    #
    # values: true | false

    attr_accessor :tmux

    ##
    # Initialize configuration.
    def initialize(options = {})
      @notifier = options[:notifier]
      @progress = options[:progress]
      @tmux     = options[:tmux]
    end

    ##
    # Load configuration or default_options.
    def self.load
      if !(File.exists? config_file)
        File.open(config_file, 'w') { |file| YAML::dump(default_options, file) }
        say "Initialized default config file in #{config_file}. See 'pomo help initconfig' for options."
      end

      options = YAML.load_file(config_file)
      new(options)
    end

    ##
    # Save configuration.
    def self.save(options = {})
      options = default_options.merge(options)

      if !(File.exists? config_file) || options[:force]
        File.open(config_file, 'w') { |file| YAML::dump(options.reject{|k,v| k==:force}, file) }
        say "Initialized config file in #{config_file}"
      else
        say_error "Not overwriting existing config file #{config_file}, use --force to override. See 'pomo help initconfig'."
      end
    end

    private

    def self.config_file
      File.join(ENV['HOME'],'.pomorc')
    end

    def self.default_options
      {
        :notifier => default_notifier,
        :progress => false,
        :tmux     => false
      }
    end

    def self.default_notifier
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
