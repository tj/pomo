# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pomo}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["TJ Holowaychuk"]
  s.date = %q{2010-01-19}
  s.default_executable = %q{pomo}
  s.description = %q{Pomodoro time management for the command-line}
  s.email = %q{tj@vision-media.ca}
  s.executables = ["pomo"]
  s.extra_rdoc_files = ["bin/pomo", "lib/pomo.rb", "lib/pomo/github_task.rb", "lib/pomo/list.rb", "lib/pomo/task.rb", "lib/pomo/version.rb", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake"]
  s.files = ["History.md", "Manifest", "Rakefile", "Readme.md", "bin/pomo", "lib/pomo.rb", "lib/pomo/github_task.rb", "lib/pomo/list.rb", "lib/pomo/task.rb", "lib/pomo/version.rb", "pomo.gemspec", "spec/pomo_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake"]
  s.homepage = %q{http://github.com/visionmedia/pomo}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Pomo", "--main", "Readme.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pomo}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Pomodoro time management for the command-line}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<commander>, [">= 4.0.2"])
      s.add_runtime_dependency(%q<growl>, [">= 1.0.3"])
    else
      s.add_dependency(%q<commander>, [">= 4.0.2"])
      s.add_dependency(%q<growl>, [">= 1.0.3"])
    end
  else
    s.add_dependency(%q<commander>, [">= 4.0.2"])
    s.add_dependency(%q<growl>, [">= 1.0.3"])
  end
end
