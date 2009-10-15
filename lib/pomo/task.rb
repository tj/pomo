
module Pomo
  class Task
    
    #--
    # Mixins
    #++
    
    include Growl
    
    ##
    # Task name.
    
    attr_reader :name
    alias :to_s :name
    
    ##
    # Length in minutes.
    
    attr_reader :length
    
    ##
    # Verbose task description.
    
    attr_reader :description
    
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
    # Check if the task has been completed.
    
    def complete?
      complete
    end
    
    ##
    # Start timing the task.
    
    def start
      complete_message = "time is up, complete #{self} yet?"
      progress (0..length).to_a.reverse, :format => "(:progress_bar) :remaining minutes remaining", :complete_message => complete_message do |remaining|
        if remaining == length / 2
          notify_info "#{remaining} minutes remaining, half way there!"
        elsif remaining == 5
          notify_info "5 minutes remaining"
        end
        sleep 60
        { :remaining => remaining }
      end
      @complete = true
      notify_warning complete_message
    end
    
  end
end