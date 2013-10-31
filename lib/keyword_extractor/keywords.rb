module KeywordExtractor
  class Keywords
    include Enumerable

    attr_accessible :keywords

    def each 
      @keywords.each do {|k| yield k}
    end
  end
end
