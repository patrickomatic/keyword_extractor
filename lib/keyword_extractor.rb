require 'keyword_extractor/keyword'
require 'keyword_extractor/document'
require 'keyword_extractor/tfidf'
require 'keyword_extractor/stopwords'
require 'keyword_extractor/configuration'

module KeywordExtractor
  def self.configuration
    @@configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.extract_keywords(text)
    if text.instance_of? String
      text = [text]
    elsif !text.instance_of? Array
      raise "The text argument should either be a String or an Array"
    end

    stopwords = Stopwords.new(configuration.stopwords_file) unless configuration.stopwords_file.nil?
    documents = text.map {|t| Document.new(t, stopwords)}

    Hash[TFIDF.analyze(documents, configuration.term_frequency_strategy).map {|doc_id, keywords| [documents.detect {|d| d.id == doc_id}, keywords]}]
  end
end
