require "aruba/cucumber"

Before do
  @original_home = ENV['HOME']
  ENV['HOME'] = "/tmp/home"
  FileUtils.rm_rf "/tmp/home"
  FileUtils.mkdir "/tmp/home"
end

After do
  ENV['HOME'] = @original_home
end
