require "aruba/cucumber"

Before do
  set_env('POMO_ENV', 'test')
  set_env('HOME', '/tmp/home')
  FileUtils.rm_rf '/tmp/home'
  FileUtils.mkdir '/tmp/home'
end

After do
  restore_env
end
