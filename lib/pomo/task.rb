
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
    # Task completion bool.

    attr_accessor :complete

    ##
    # Initialize with _name_ and _options_.

    def initialize name = nil, options = {}
      @name = name or raise '<task> required'
      @description = options.delete :description
      @length = options.fetch :length, 25
      @complete = false
    end

    ##
    # Quoted task name.

    def to_s
      name.inspect
    end

    ##
    # Check if the task has been completed.

    def complete?
      complete
    end

    ##
    # Start timing the task.

    def start
      complete_message = "time is up! hope you are finished #{self}"
      format_message = "(:progress_bar) :remaining minutes remaining"
      progress(
        (0..length).to_a.reverse,
        :format => format_message,
        :tokens => { :remaining => length },
        :complete_message => complete_message
      ) do |remaining|
        if remaining == length / 2
          Pomo::Notifier.notify "#{remaining} minutes remaining, half way there!"
        elsif remaining == 5
          Pomo::Notifier.notify "5 minutes remaining"
        end
        sleep 60
        { :remaining => remaining }
      end
      @complete = true
      Pomo::Notifier.notify complete_message, :warning
    end

  end
end
