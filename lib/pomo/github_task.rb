
module Pomo
  class GithubTask < Task
    
    ##
    # Username.
    
    attr_reader :username
    
    ##
    # Project name.
    
    attr_reader :project
    
    ##
    # Initialize with _name_ and _options_.
    
    def initialize name = nil, options = {}
      super
      @username = options.delete :username
      @project = options.delete :project
    end
    
  end
end