require 'yaml'
require 'terminal-notifier' if /darwin/ =~ RUBY_PLATFORM
require 'growl'             if /darwin/ =~ RUBY_PLATFORM
require 'libnotify'         if /linux/ =~ RUBY_PLATFORM
require 'pomo/notifier'
require 'pomo/list'
require 'pomo/task'
require 'pomo/github_task'
require 'pomo/version'
