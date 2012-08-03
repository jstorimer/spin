$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "spin/version"

Gem::Specification.new "spin", Spin::VERSION do |s|
  s.authors     = ["Jesse Storimer"]
  s.email       = ["jstorimer@gmail.com"]
  s.homepage    = "http://jstorimer.github.com/spin"
  s.summary     = %q{Spin preloads your Rails environment to speed up your autotest(ish) workflow.}
  s.description = %Q{#{s.summary}

By preloading your Rails environment for testing you don't load the same code over and over and over... Spin works best for an autotest(ish) workflow.}

  s.executables   = ['spin']
end
