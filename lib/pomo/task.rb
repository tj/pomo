
module Pomo
  class Task
    
    ##
    # Task name.
    
    attr_reader :name
    alias :to_s :name
    
    ##
    # Verbose task description.
    
    attr_reader :description
    
    ##
    # Initialize with _name_ and _options_.
    
    def initialize name = nil, options = {}
      @name = name or raise '<task> required'
      @description = options.delete :description
    end
    
  end
end