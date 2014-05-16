# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'spicerack/version'

Gem::Specification.new do |s|
  s.name = "spicerack"
  s.version = Spicerack::VERSION
  s.license = "MIT"

  s.authors = ["Cameron Daigle", "Vic Ramon", "Lucas Galego"]
  s.email = ["cameron@hashrocket.com", "vic@hashrocket.com", "lucas@hashrocket.com"]
  s.description = "Spicerack is a collection of generators for Hashrocket Rails projects."

  s.homepage = ""
  s.require_paths = ["lib"]
  s.summary = "Spicerack is a collection of generators for Hashrocket Rails projects."

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency("http")

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec")
  s.add_development_dependency("pry")

  s.files = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.require_path = "lib"

end
