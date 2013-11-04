require 'keyword_extractor'

Gem::Specification.new do |s|
  s.name        = 'keyword_extractor'
  s.version     = KeywordExtractor::VERSION
  s.summary     = 'Extracts keywords from a corpus of documents'
  s.description = 'Uses TF-IDF to return a list of keywords extracted from the given documents'
  s.authors     = ['Patrick Carroll']
  s.email       = 'patrick@patrickomatic.com'
  s.files       = ['lib/**'] # XXX do i require spec files in here?

  s.add_development_dependency 'rspec'
end
