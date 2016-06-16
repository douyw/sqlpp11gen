# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sqlpp11gen/version'

Gem::Specification.new do |spec|
  spec.name          = "sqlpp11gen"
  spec.version       = Sqlpp11gen::VERSION
  spec.authors       = ["Yongwang Dou"]
  spec.email         = ["douyongwang@gmail.com"]

  spec.summary       = %q{A c++ table class wrapper generator for sqlpp11 (c++11).}
  spec.description   = %q{A c++ table class wrapper generator for sqlpp11 (c++11). See more about sqlpp11 }
  spec.homepage      = "https://github.com/douyw/sqlpp11gen"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

#  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files         = Dir["lib/**/*"] + Dir["app/**/*"] + ["Rakefile", "README.md"]

  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 0'
end
