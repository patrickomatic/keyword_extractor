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


  def self.extract_top_keywords(text, top_n=20)
    results, top = extract_keywords(text), {}

    results.each do |document, keywords|
      keywords.each {|k| top[k] = k.rank}
    end

    top.sort_by {|k, v| v}.reverse.collect(&:first)[0...top_n]
  end

  def self.extract_keywords(text)
    if text.instance_of? String
      text = [text]
    elsif !text.instance_of? Array
      raise "The text argument should either be a String or an Array"
    end

    stopwords = Stopwords.new(configuration.stopwords_file) unless configuration.stopwords_file.nil?

    # TF-IDF requires multiple documents to compare to each other.  If the caller only
    # supplied a single document, we need to try to break it up by sentences where each
    # sentence is a document.  If they don't even supply multiple sentences, there's not
    # much that we can do but remove stopwords and set rank = 0
    if text.size == 1
      if text.first.include? '.'
        text = text.first.split(/\.\s+/)
      else
        document = Document.new(text.first, stopwords, configuration.minimum_word_size, configuration.reject)
        return {document => document.tokenized_words.collect {|word| Keyword.new(word, 0.0)}}
      end
    end

    documents = text.map {|t| Document.new(t, stopwords, configuration.minimum_word_size, configuration.reject)}

    Hash[TFIDF.analyze(documents, configuration.term_frequency_strategy).map {|doc_id, keywords| [documents.detect {|d| d.id == doc_id}, keywords]}]
  end
end
