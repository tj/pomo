
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
    # Find tasks by _args_, iterating with _block_.
    
    def find *args, &block
      if args.empty?
        yield tasks.first, 0
      else
        tasks.each_with_index do |task, i|
          yield task, i if args.any? { |a| a.to_i == i }
        end
      end
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