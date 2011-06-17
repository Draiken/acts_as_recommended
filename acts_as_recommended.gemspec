Gem::Specification.new do |s|
  s.name        = "acts_as_recommended"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY

  s.authors     = [ "Luiz Felipe Garcia Pereira" ]
  s.email       = [ "luiz.felipe.gp@gmail.com" ]

  s.summary = "Insert ActsAsRecommended summary."
  s.description = "Insert ActsAsRecommended description."

  s.add_dependency( 'rails', '~> 3.0' )

  s.files       = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
end
