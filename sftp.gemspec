# frozen_string_literal: true

require_relative "lib/sftp/version"

Gem::Specification.new do |spec|
  spec.name = "sftp"
  spec.version = SFTP::VERSION
  spec.authors = ["Monique Rio"]
  spec.email = ["mrio@umich.edu"]

  spec.summary = "minimal SFTP client that shells out to bash sftp"
  spec.homepage = "https://github.com/mlibrary/sftp"
  spec.required_ruby_version = ">= 2.6.0"
  spec.license = "BSD-3-Clause"

  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/mlibrary"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(/^(bin|spec|Docker|docker|server|.env|.ssh|.git|.irb|.rspec|Gemfile|sftp.gemspec)/)
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
