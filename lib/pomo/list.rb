
module Pomo
  class List
    
    ##
    # List path.
    
    attr_reader :path
    
    ##
    # Task array.
    
    attr_accessor :tasks
    
    ##
    # Initialize with _path_.
    
    def initialize path
      @path = File.expand_path path
      @tasks = []
      load rescue save
    end
    
    ##
    # Add _task_ to the list in memory (requires saving).
    
    def add task
      @tasks << task
    end
    alias :<< :add
    
    ##
    # Save the list.
    
    def save
      File.open(path, 'w') do |file|
        file.write YAML.dump(tasks)
      end
      self
    end
    
    ##
    # Load the list.
    
    def load
      @tasks = YAML.load_file path
      self
    end
    
  end
end