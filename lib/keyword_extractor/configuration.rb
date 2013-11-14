module KeywordExtractor
  class Configuration
    attr_reader :term_frequency_strategy, :stopwords_file, :minimum_word_size

    def initialize
      @term_frequency_strategy = :count
      @stopwords_file = 'stopwords/english.txt'
      @minimum_word_size = 4
    end

    def stopwords_file=(file)
      raise "No such file: #{file}" if !file.nil? && !File.exists?(file)

      @stopwords_file = file
    end

    def term_frequency_strategy=(strategy)
      unless [:count, :boolean, :logarithmic, :augmented].include?(strategy)
        raise "Unsupported term frequency strategy: #{strategy}.  Supported options are :count, :boolean, :logarithmic, :augmented"
      end

      @term_frequency_strategy = strategy
    end

    def minimum_word_size=(size)
      raise "minimum_word_size must be an Integer" unless size.is_a? Integer
      @minimum_word_size = size
    end
  end
end
