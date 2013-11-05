module KeywordExtractor
  module TFIDF
    class << self
      def analyze(corpus, term_frequency_strategy)
        tf, idf, word_document_counts = {}, {}, {}

        # calculate the term frequencies for each word and keep a count of how many documents
        # each word appears in
        corpus.each do |document|
          tf[document.id] = {}

          document.tokenized_words.each do |word|
            unless tf[document.id].has_key?(word)
              tf[document.id][word] = case term_frequency_strategy
                                        when :count
                                          term_frequency(word, document) 
                                        when :boolean
                                          boolean_term_frequency(word, document) 
                                        when :logarithmic
                                          logarithmic_term_frequency(word, document) 
                                        when :augmented
                                          augmented_term_frequency(word, document) 
                                        else
                                          raise "Uknown term frequency strategy: #{term_frequency_strategy}"
                                        end

              word_document_counts[word] ||= 0
              word_document_counts[word] += 1
            end
          end
        end

        # now finish by calculating all of the inverse term frequencies and assign ranks
        word_document_counts.each do |word, document_count|
          idf[word] = inverse_document_frequency(word, corpus.size, document_count)
        end

        tf_idf(tf, idf)
      end


      def tf_idf(tf, idf)
        Hash[tf.map {|doc_id, keywords| [doc_id, keywords.map {|k, tf| Keyword.new(k, tf * idf[k])}.sort]}]
      end


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
        0.5 + (0.5 * term_frequency(term, document) / document.most_common_word_frequency)
      end


      def inverse_document_frequency(term, corpus_size, document_count)
        Math.log(corpus_size.to_f / (1 + document_count))
      end
    end
  end
end
