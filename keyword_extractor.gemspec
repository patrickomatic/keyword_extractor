Gem::Specification.new do |s|
  s.name        = 'keyword_extractor'
  s.version     = '0.0.1' 
  s.summary     = 'Extracts keywords from a corpus of documents'
  s.description = 'Uses TF-IDF to return a list of keywords extracted from the given documents'
  s.authors     = ['Patrick Carroll']
  s.email       = 'patrick@patrickomatic.com'
  s.files       = Dir['lib/**/**.rb'] + Dir['spec/*.rb'] + Dir['stopwords/*.txt']

  s.add_development_dependency 'rspec'
end
