require 'yaml'

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

    def initialize(opts = {})
      if opts[:init]
        path = '.pomo'
      else
        path = (File.exists?('.pomo') && ENV['POMO_ENV']!='test') ? '.pomo' : File.join(ENV['HOME'],'.pomo')
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
    #  * n..n n..n n..n
    #  * first
    #  * last
    #  * first last
    #  * incomplete
    #  * complete[d]
    #  * all
    #

    def find(*args, &block)
      found = []
      found << tasks.first if args.empty?

      args.each do |arg|
        case arg
        when 'all'
          found = tasks
          break
        when 'first'
          found << tasks.first
        when 'last'
          found << tasks.last
        when 'complete'
          found.concat tasks.select { |task| task.complete? }
        when 'completed'
          found.concat tasks.select { |task| task.complete? }
        when 'incomplete'
          found.concat tasks.select { |task| not task.complete? }
        when /^(\d+)$/
          found << tasks[$1.to_i]
        when /^(\d+)\.\.(-?\d+)$/
          found.concat tasks[$1.to_i..$2.to_i]
        end
      end

      found.compact!

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

    def add(task)
      @tasks << task
    end
    alias :<< :add

    ##
    # Move task at _from_ index to _to_ index (requres saving).

    def move(from, to)
      @tasks.insert(index(to), @tasks.delete_at(index(from)))
    end

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

    private

    def index(arg)
      case arg
      when 'first'
        0
      when 'last'
        @tasks.size - 1
      when /^(\d+)$/
        $1.to_i
      else
        abort "Invalid argument: #{arg}. See 'pomo help move'"
      end
    end
  end
end
