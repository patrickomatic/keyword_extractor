require 'securerandom'

module KeywordExtractor
  class Document
    attr_accessor :text, :id

    def initialize(text=nil, stopwords=nil)
      @id = SecureRandom.uuid
      @text = text
      @stopwords = stopwords
    end


    def tokenized_words(pattern=/\s+/)
      @tokenized_words ||= @text.downcase.gsub(/[^a-z\s]+/, '').split(pattern).reject {|word| !@stopwords.nil? && @stopwords.include?(word)}
    end

    def most_common_word_frequency
      return @most_common_word_frequency unless @most_common_word_frequency.nil?

      word_counts = {}
      tokenized_words.each do |word|
        word_counts[word] = 0 unless word_counts.has_key?(word)
        word_counts[word] += 1
      end

      @most_common_word_frequency = word_counts.values.max
    end

    def frequency(term)
      tokenized_words.count(term)
    end

    def to_s
      @text
    end
  end
end
