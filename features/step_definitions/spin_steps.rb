require 'ostruct'
require 'tempfile'

When /^I run `(.*)`$/ do |cmd|
  @processes ||= {}

  tracked_stdout = Tempfile.new('tracked_stdout')
  pid = Process.spawn cmd, :out => tracked_stdout.path
  sleep 2

  @processes[cmd] = OpenStruct.new(:pid => pid, :stdout => tracked_stdout)
end

When /^I send the "(.*)" signal to `(.*)`$/ do |sig, cmd|
  Process.kill sig, @processes[cmd].pid
end

Then /^the `(.*)` exit status should be (\d+)$/ do |cmd, status|
  _, status = Process.wait2(@processes[cmd].pid)
  status.must_equal status
end
