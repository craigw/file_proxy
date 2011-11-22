# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "file_proxy/version"

Gem::Specification.new do |s|
  s.name        = "file_proxy"
  s.version     = FileProxy::VERSION
  s.authors     = ["Craig R Webster"]
  s.email       = ["craig@barkingiguana.com"]
  s.homepage    = ""
  s.summary     = %q{Proxy the File class to places that aren't on the local filesystem}
  s.description = %q{A toy project to see if I can make a library with no knowledge of an external storage service read files from and write files to that service.}

  s.rubyforge_project = "file_proxy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
