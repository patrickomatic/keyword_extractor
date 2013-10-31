module KeywordExtractor
  class Keyword
    attr_accessible :word, :rank

    def initialize(word, rank)
      @word = word
      @rank = rank
    end

    def <=>(k)
      @rank <=> k.rank 
    end

    def to_s
      @word
    end
  end
end
