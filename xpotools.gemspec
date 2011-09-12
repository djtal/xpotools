# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "xpotools/version"

Gem::Specification.new do |s|
  s.name        = "xpotools"
  s.version     = Xpotools::VERSION
  s.authors     = ["djtal"]
  s.email       = ["guillaume.garcera@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "xpotools"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
