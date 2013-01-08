require 'pomo'

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
    Pomo::RSpecHelper.set_env('HOME', '/tmp/home')
  end

  config.before(:each) do
    FileUtils.rm_rf '/tmp/home'
    FileUtils.mkdir '/tmp/home'
  end

  config.after(:suite) do
    Pomo::RSpecHelper.restore_env
  end
end
