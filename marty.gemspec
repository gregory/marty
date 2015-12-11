# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "marty/version"

Gem::Specification.new do |s|

  s.name          = "marty"
  s.version       = Marty::VERSION.dup
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Gregory Horion"]
  s.email         = "public+marty@gregory.io"
  s.homepage      = "http://github.com/gregory/marty"

  s.license       = 'MIT'

  s.summary       = %q{a minimal command-line to manage your docker cluster}
  s.description   = <<EOF
EOF

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

end
