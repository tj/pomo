# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pomo/version'

Gem::Specification.new do |gem|
  gem.name              = "pomo"
  gem.version           = Pomo::VERSION
  gem.authors           = ["TJ Holowaychuk"]
  gem.email             = ["tj@vision-media.ca"]
  gem.summary           = "pomo-#{Pomo::VERSION}"
  gem.description       = "Pomodoro time management for the command-line"
  gem.homepage          = "http://github.com/visionmedia/pomo"

  gem.rubyforge_project = "pomo"

  gem.files             = `git ls-files`.split($/)
  gem.executables       = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files        = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths     = ["lib"]
  gem.rdoc_options      = ["--line-numbers", "--inline-source", "--title", "Pomo", "--main", "Readme.md"]

  gem.add_dependency("commander", [">= 4.1.2"])
  gem.add_dependency("terminal-notifier", [">= 1.4.2"]) if /darwin/ =~ RUBY_PLATFORM
  gem.add_dependency("growl", [">= 1.0.3"])             if /darwin/ =~ RUBY_PLATFORM
  gem.add_dependency("libnotify", [">= 0.8.0"])         if /linux/ =~ RUBY_PLATFORM

  gem.add_development_dependency("rspec", "~> 2.12")
end
