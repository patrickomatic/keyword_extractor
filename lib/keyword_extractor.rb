require 'keyword_extractor/keyword'
require 'keyword_extractor/document'
require 'keyword_extractor/tfidf'
require 'keyword_extractor/stopwords'

# TODO
# * should be able to extract keywords from on a corpus level and also across all of the corpuses
# * make the various term frequency strategies pluggable/configurable
module KeywordExtractor
  VERSION = '0.0.1'

  def self.extract_keywords(text)
    if text.instance_of? String
      text = [text]
    elsif !text.instance_of? Array
      raise "The text argument should either be a String or an Array"
    end

    stopwords = Stopwords.new('stopwords/english.txt')

    TFIDF.analyze(text.map {|t| Document.new(t, stopwords)})
  end
end
