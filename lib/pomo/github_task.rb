
module Pomo
  class Task
    def github?
      false
    end  
  end
  
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
    # Initialize with _name_ and _options_.
    
    def initialize name = nil, options = {}
      super
      options.each { |k,v| send :"#{k}=", v }
    end
    
    ##
    # Check if the task is a github issue.
    
    def github?
      true
    end
    
    ##
    # Absolute URI to github issue.
    
    def uri
      "http://github.com/#{username}/#{project}/issues#issue/#{number}"
    end
    
  end
end