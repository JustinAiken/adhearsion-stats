# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adhearsion-stats/version"

Gem::Specification.new do |s|
  s.name        = "adhearsion-stats"
  s.version     = AdhearsionStats::VERSION
  s.authors     = ["JustinAiken"]
  s.email       = ["jaiken@mojolingo.com"]
  s.homepage    = "https://github.com/polysics/adhearsion-stats"
  s.summary     = %q{Adhearsion plugin for stats}
  s.description = %q{Adhearsion plugin for stats. Reports via statsd.}
  s.license     = 'MIT'

  s.rubyforge_project = "adhearsion-stats"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency %q<adhearsion>, ["~> 2.1"]
  s.add_runtime_dependency %q<statsd-ruby>

  s.add_development_dependency %q<bundler>, ["~> 1.0"]
  s.add_development_dependency %q<rspec>, ["~> 2.5"]
  s.add_development_dependency %q<rake>, [">= 0"]
  s.add_development_dependency %q<guard-rspec>
 end
