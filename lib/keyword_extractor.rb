require 'keyword_extractor/keyword'
require 'keyword_extractor/document'
require 'keyword_extractor/tfidf'

# TODO
# * support for a list of stop words
# * should be able to extract keywords from on a corpus level and also across all of the corpuses
# * make the various term frequency strategies pluggable/configurable
module KeywordExtractor
  VERSION = '0.0.1'

  def self.extract_keywords(text)
    if text.is_a? String
      text = [text]
    elsif !text.is? Array
      raise "The text argument should either be a String or an Array"
    end

    TFIDF.analyze(text.map {|t| Document.new(t)})
  end
end
