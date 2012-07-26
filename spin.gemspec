Gem::Specification.new do |s|
  s.name        = "spin"
  s.version     = '0.5.1'
  s.authors     = ["Jesse Storimer"]
  s.email       = ["jstorimer@gmail.com"]
  s.homepage    = "http://jstorimer.github.com/spin"
  s.summary     = %q{Spin preloads your Rails environment to speed up your autotest(ish) workflow.}
  s.description = %q{Spin preloads your Rails environment to speed up your autotest(ish) workflow.

By preloading your Rails environment for testing you don't load the same code over and over and over... Spin works best for an autotest(ish) workflow.}

  s.executables   = ['spin']
end
