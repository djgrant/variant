path = File.expand_path('../lib', __FILE__)
require File.join(path, 'variant-sass')

Gem::Specification.new do |s|
  s.name        = 'variant-sass'
  s.summary     = "Variant"
  s.description = "Build robust user interface split test"
  s.authors     = ["Daniel Grant"]
  s.email       = 'hello@danielgrant.im'
  s.homepage    = 'https://github.com/djgrant/variant'
  s.license     = 'MIT'

  s.version = VariantSass::VERSION
  s.date    = VariantSass::DATE

  s.files = ["README.md"]
  s.files += Dir.glob("lib/**/*.*")
  s.files += Dir.glob("assets/**/*.*")
end
