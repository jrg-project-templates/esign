require_relative "lib/esign/version"

Gem::Specification.new do |spec|
  spec.name = "esign"
  spec.version = Esign::VERSION
  spec.authors = ["Big7lion"]
  spec.email = ["biglion77@outlook.com"]

  spec.summary = "Api for esign in rails"
  spec.homepage = "https://github.com/jrg-project-templates/esign"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/jrg-project-templates/esign/issues",
    "changelog_uri" => "https://github.com/jrg-project-templates/esign/releases",
    "source_code_uri" => "https://github.com/jrg-project-templates/esign",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
