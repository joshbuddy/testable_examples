# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "testable_examples/version"

Gem::Specification.new do |s|
  s.name        = "testable_examples"
  s.version     = TestableExamples::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joshua Hull"]
  s.email       = ["joshbuddy@gmail.com"]
  s.homepage    = "https://github.com/joshbuddy/testable_examples"
  s.summary     = %q{Test your examples!}
  s.description = %q{Test your examples!}

  s.rubyforge_project = "testable_examples"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
