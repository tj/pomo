
module Pomo
  class Task

    ##
    # Task name.

    attr_accessor :name

    ##
    # Length in minutes.

    attr_accessor :length

    ##
    # Verbose task description.

    attr_accessor :description

    ##
    # Task currently running bool.

    attr_accessor :running

    ##
    # Task completion bool.

    attr_accessor :complete

    ##
    # Initialize with _name_ and _options_.

    def initialize name = nil, options = {}
      @name = name or raise '<task> required'
      @description = options.delete :description
      @length = options.fetch :length, 25
      @running = false
      @complete = false
    end

    ##
    # Quoted task name.

    def to_s
      name
    end

    ##
    # Check if the task currently running.

    def running?
      running
    end

    ##
    # Check if the task has been completed.

    def complete?
      complete
    end

    ##
    # Output verbose task information

    def verbose_output(format)
      say format % ['name', self]
      say format % ['length', "#{length} minutes"]
      say format % ['description', description] if description and not description.empty?
    end

    ##
    # Start timing the task.

    def start(config, options = {})
      list = options[:list]
      progress = options[:progress]

      @running = true
      list.save unless list.nil?

      if progress
        foreground_progress(config)
      else
        background_progress(config)
      end
    end

    private

    def foreground_progress(config)
      notifier = Pomo::Notifier.new(config)

      say "Started #{self}, you have #{length} minutes :)"

      complete_message = "Time is up! Hope you are finished #{self}"
      format_message = '(:progress_bar) :remaining minutes remaining'
      progress(
        (0..length).to_a.reverse,
        :format => format_message,
        :tokens => { :remaining => length },
        :complete_message => complete_message
      ) do |remaining|
        if remaining == length / 2
          notifier.notify 'Half way there!', :header => "#{remaining} minutes remaining"
        elsif remaining == 5
          notifier.notify 'Almost there!', :header => '5 minutes remaining'
        end
        sleep 60
        { :remaining => remaining }
      end

      notifier.notify "Hope you are finished #{self}", :header => 'Time is up!', :type => :warning

      list = Pomo::List.new
      if task = list.running
        task.running = false
        task.complete = true
        list.save
      end
    end

    def background_progress(config)
      notifier = Pomo::Notifier.new(config)

      notifier.notify "Started #{self}", :header => "You have #{length} minutes"

      pid = Process.fork do
        length.downto(1) do |remaining|
          write_tmux_time(remaining) if config.tmux
          refresh_tmux_status_bar    if config.tmux
          if remaining == length / 2
            notifier.notify 'Half way there!', :header => "#{remaining} minutes remaining"
          elsif remaining == 5
            notifier.notify 'Almost there!', :header => '5 minutes remaining'
          end
          sleep 60
        end

        write_tmux_time(0) if config.tmux
        refresh_tmux_status_bar if config.tmux
        notifier.notify "Hope you are finished #{self}", :header => 'Time is up!', :type => :warning

        list = Pomo::List.new
        if task = list.running
          task.running = false
          task.complete = true
          list.save
        end
      end

      Process.detach(pid)
    end

    def tmux_time(time)
      case time
      when 0
        "#{time}:00"
      when 1..5
        "#[default]#[fg=red]#{time}:00#[default]"
      when 6..100
        "#[default]#[fg=green]#{time}:00#[default]"
      end
    end

    def write_tmux_time(time)
      path = File.join(ENV['HOME'],'.pomo_stat')
      File.open(path, 'w') do |file|
        file.write tmux_time(time)
      end
    end

    def refresh_tmux_status_bar
      pid = Process.fork do
        exec "tmux refresh-client -S -t $(tmux list-clients -F '\#{client_tty}')"
      end
      Process.detach(pid)
    end

  end
end
