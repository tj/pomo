require 'pomo'

RSpec.configure do |config|
  config.color = true
  config.order = 'random'

  config.before(:suite) do
    @original_home = ENV['HOME']
    ENV['HOME'] = "/tmp/home"
  end

  config.before(:each) do
    FileUtils.rm_rf "/tmp/home"
    FileUtils.mkdir "/tmp/home"
  end

  config.after(:suite) do
    ENV['HOME'] = @original_home
  end
end
