$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/state_machine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_admin-state_machine"
  s.version     = ActiveAdmin::StateMachine::VERSION
  s.authors     = ["Matt Brewer"]
  s.email       = ["matt.brewer@me.com"]
  s.homepage    = "https://github.com/macfanatic/active_admin-state_machine"
  s.summary     = "Provides easy DSL integration between ActiveAdmin & state_machine"
  s.description = "Provides easy DSL integration between ActiveAdmin & state_machine"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.14"
  s.add_dependency "activeadmin"
  s.add_dependency "state_machine"

  s.add_development_dependency "rake", "> 10.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
end
