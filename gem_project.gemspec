# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gem_project/version'

Gem::Specification.new do |spec|
  spec.name          = "gem_project"
  spec.version       = GemProject::VERSION
  spec.authors       = ["Hanna Redleaf"]
  spec.email         = ["<hredleaf@gmail.com>"]

  spec.summary       = %q{This Ruby Gem provides a CLI to view neighborhood community meetings in Manhattan through the New York City Mayor's Community Affair Unit website.}
  spec.description   = %q{I chose to make my first gem using the NYC Mayor's Community Affairs Unit - http://www.nyc.gov/html/cau/html/cb/manhattan.shtml.   The gem, called Community Meetings, scrapes the Mayors Community Affairs page and returns information on community meetings of certain neighborhoods via the command line interface.  Its focus for now  is Manhattan , it gathers the data just from the 12 community boards listed on the given page.  It has an on screen prompt asking for the user input, giving the option to choose among the neighborhoods listed and the type of information they can view.  The options available are the community meetings address, meeting times, phone number, website, and the community's latest agenda.  
}
  spec.homepage      = "https://github.com/hailuhr/new-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  # spec.add_dependency " nokogiri"

end
