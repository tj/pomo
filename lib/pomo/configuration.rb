require 'yaml'
require 'commander'
include Commander::UI

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
    # Load configuration file or default_options. Passed options take precedence.

    def self.load(options = {})
      options.reject!{|k,v| ![:notifier, :progress, :tmux].include? k}

      if !(File.exists? config_file)
        File.open(config_file, 'w') { |file| YAML::dump(default_options, file) }
        say "Initialized default config file in #{config_file}. See 'pomo help initconfig' for options."
      end

      config_file_options = YAML.load_file(config_file)
      new(config_file_options.merge(options))
    end

    ##
    # Save configuration. Passed options take precendence over default_options.

    def self.save(options = {})
      force_save = options.delete :force
      options.reject!{|k,v| ![:notifier, :progress, :tmux].include? k}

      options = default_options.merge(options)

      if !(File.exists? config_file) || force_save
        File.open(config_file, 'w') { |file| YAML::dump(options, file) }
        say "Initialized config file in #{config_file}"
      else
        say_error "Not overwriting existing config file #{config_file}, use --force to override. See 'pomo help initconfig'."
      end
    end

    # Helpers

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
