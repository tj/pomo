Given /^the following tasks:$/ do |table|
  data = table.raw
  table.raw.each do |task|
    steps %Q{
      When I run `pomo add '#{task.first}'`
    }
  end
end
