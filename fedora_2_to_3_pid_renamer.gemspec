# -*- encoding: utf-8 -*-
require File.expand_path('../lib/fedora_2_to_3_pid_renamer/version', __FILE__)

Gem::Specification.new do |gem|  
  gem.authors       = ["Rob Nichols"]
  gem.email         = ["rob@undervale.com"]
  gem.description   = %q{Interates through a series of xml files and modifies their content based on the setting defined in a configuration file}
  gem.summary       = %q{A small Ruby app used to apply alternative pid names to configuration files created during the migration of fedora 2 data to fedora 3}
  gem.homepage      = "https://github.com/reggieb/fedora_2_to_3_pid_renamer"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = ["fedora_2_to_3_pid_renamer"]
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.name          = "fedora_2_to_3_pid_renamer"
  gem.require_paths = ["lib"]
  gem.version       = Fedora2To3PidRenamer::VERSION
end