
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

    def initialize opts = {}
      if opts[:init]
        path = '.pomo'
      else
        path = File.exists?('.pomo') ? '.pomo' : File.join(ENV['HOME'],'.pomo')
      end
      @path = File.expand_path path
      @tasks = []
      load rescue save
    end

    ##
    # Find tasks by _args_, iterating with _block_.
    #
    # Supports the following:
    #
    #  * n
    #  * n n n
    #  * n..n
    #  * n..-n
    #  * first
    #  * last
    #  * incomplete
    #  * complete[d]
    #  * all
    #

    def find *args, &block
      found = []
      found << tasks.first if args.empty?
      if args.include? 'all'
        found = tasks
      elsif args.include? 'first'
        found << tasks.first
      elsif args.include? 'last'
        found << tasks.last
      elsif args.include?('complete') || args.include?('completed')
        found = tasks.select { |task| task.complete? }
      elsif args.include? 'incomplete'
        found = tasks.select { |task| not task.complete? }
      elsif args.any? { |arg| arg =~ /(\d+)\.\.(-?\d+)/ }
        found = tasks[$1.to_i..$2.to_i]
      else
        found = tasks.values_at(*args.select{|arg| arg =~ /\d+/}.map(&:to_i))
      end

      if block.arity == 2
        found.each_with_index do |task, i|
          yield task, i
        end
      else
        found.each do |task|
          yield task
        end
      end
    end

    ##
    # Find currently running _task_ or nil.

    def running
      tasks.detect {|task| task.running? }
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
