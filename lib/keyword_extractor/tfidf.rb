module KeywordExtractor
  class TFIDF
    attr_accessible :corpuses, :keywords, :limit

    def initialize(corpus, limit=50)
      @keywords = Keywords.new
      @corpus = corpus
      @limit = limit

      analyze!
    end


    def analyze!
      term_frequencies = {}

      @corpus.each do |document|
        term_frequencies[document.id] = {}

        document.tokenized_words.each do |word|
          term_frequencies[document.id][word] = term_frequency(word, document)
        end
      end
    end

    # TODO make the various term frequency strategies below pluggable/configurable
    def term_frequency(term, document)
      document.frequency(term)
    end

    def boolean_term_frequency(term, document)
      term_frequency(term, document) > 0 ? 1 : 0
    end

    def logarithmic_term_frequency(term, document)
      Math.log(term_frequency(term, document) + 1)
    end

    def augmented_term_frequency(term, document)
      0.5 + (0.5 * term_frequency(term, document) / document.most_common_word)
    end
  end
end
