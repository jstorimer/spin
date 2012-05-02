# -*- encoding: utf-8 -*-
require File.expand_path('../lib/spin/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jesse Storimer"]
  gem.email         = ["jstorimer@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "spin"
  gem.require_paths = ["lib"]
  gem.version       = Spin::VERSION
  gem.add_development_dependency('rocco')
  gem.add_development_dependency('minitest')
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('rake','~> 0.9.2')
  gem.add_dependency('methadone', '~>1.0.0.rc4')
end
