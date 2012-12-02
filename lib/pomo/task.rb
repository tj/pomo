
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
      notifier = Pomo::Notifier.new
      complete_message = "Time is up! Hope you are finished #{self}"
      format_message = "(:progress_bar) :remaining minutes remaining"
      progress(
        (0..length).to_a.reverse,
        :format => format_message,
        :tokens => { :remaining => length },
        :complete_message => complete_message
      ) do |remaining|
        if remaining == length / 2
          notifier.notify "Half way there!", :header => "#{remaining} minutes remaining"
        elsif remaining == 5
          notifier.notify "Almost there!", :header => "5 minutes remaining"
        end
        sleep 60
        { :remaining => remaining }
      end
      @complete = true
      notifier.notify "Hope you are finished #{self}", :header => "Time is up!", :type => :warning
    end

  end
end
