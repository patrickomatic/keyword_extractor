require 'securerandom'

module KeywordExtractor
  class Document
    attr_accessor :text, :id

    def initialize(text=nil, stopwords=nil, minimum_word_size=nil, reject=nil)
      @id = SecureRandom.uuid
      @text = text
      @minimum_word_size = minimum_word_size
      @stopwords = stopwords

      @reject = case reject
                when String
                  lambda {|w| w == reject}
                when Array
                  lambda {|w| reject.include? w}
                when Proc
                  reject
                else
                  lambda {|w| false}
                end
    end


    def tokenized_words(pattern=/\s+/)
      @tokenized_words ||= @text.downcase.split(pattern)
                            .reject(&@reject)
                            .map {|word| word.gsub(/[^a-z\s]+/, '').strip}
                            .reject {|word| word == ''}
                            .reject {|word| !@minimum_word_size.nil? && word.size < @minimum_word_size }
                            .reject {|word| !@stopwords.nil? && @stopwords.include?(word)}
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
