require 'pomo'
require 'fakefs/safe'

# Taken from Aruba::Api
class Pomo::RSpecHelper
  def self.set_env(key, value)
    $original_env ||= {}
    $original_env[key] = ENV.delete(key)
    ENV[key] = value
  end

  def self.restore_env
    $original_env ||= {}
    $original_env.each do |key, value|
      ENV[key] = value
    end
  end
end

RSpec.configure do |config|
  config.color = true
  config.order = 'random'

  config.before(:suite) do
    Pomo::RSpecHelper.set_env('POMO_ENV', 'test')
  end

  config.before(:each) do
    FakeFS.activate!
    FileUtils.mkdir_p ENV['HOME']
  end

  config.after(:each) do
    FakeFS.deactivate!
    FakeFS::FileSystem.clear
  end

  config.after(:suite) do
    Pomo::RSpecHelper.restore_env
  end
end
