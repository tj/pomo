
$:.unshift 'lib'
require 'pomo'
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new "pomo", Pomo::VERSION do |p|
  p.author = "TJ Holowaychuk"
  p.email = "tj@vision-media.ca"
  p.summary = "Pomodoro time management for the command-line"
  p.url = "http://github.com/visionmedia/pomo"
  p.runtime_dependencies << 'commander >=4.0.0'
  p.runtime_dependencies << 'growl >=1.0.3'
end

Dir['tasks/**/*.rake'].sort.each { |f| load f }