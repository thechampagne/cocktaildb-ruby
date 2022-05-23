# frozen_string_literal: true

require_relative "lib/cocktaildb/version"

Gem::Specification.new do |spec|
  spec.name          = "cocktaildb"
  spec.version       = CocktailDB::VERSION
  spec.authors       = ["XXIV"]

  spec.summary       = "TheCocktailDB API client"
  spec.description   = "TheCocktailDB API client"
  spec.homepage      = "https://github.com/thechampagne/cocktaildb-ruby"
  spec.license = 'Apache-2.0'
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/thechampagne/cocktaildb-ruby"
  spec.metadata["github_repo"] = "git@github.com:thechampagne/cocktaildb-ruby.git"

  spec.files = Dir["lib/**/*.rb", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]
end