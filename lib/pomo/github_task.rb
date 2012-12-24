
module Pomo
  class GithubTask < Task

    ##
    # Username.

    attr_accessor :username

    ##
    # Project name.

    attr_accessor :project

    ##
    # Labels array.

    attr_accessor :labels

    ##
    # Issue number.

    attr_accessor :number

    ##
    # Absolute URI.

    attr_accessor :url

    ##
    # Initialize with _name_ and _options_.

    def initialize name = nil, options = {}
      super
      options.each { |k,v| send :"#{k}=", v }
    end

    ##
    # Quoted github issue name and number.

    def to_s
      "#%-3s %s" % [ number, name]
    end

    ##
    # Check if the task is a github issue.

    def github?
      true
    end

  end
end
