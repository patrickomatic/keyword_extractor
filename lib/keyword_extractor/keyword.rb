module KeywordExtractor
  class Keyword
    attr_accessor :word, :rank

    include Comparable

    def initialize(word, rank)
      @word, @rank = word, rank
    end

    def <=>(k)
      (@rank <=> k.rank) * -1
    end

    def to_s
      @word
    end
  end
end
