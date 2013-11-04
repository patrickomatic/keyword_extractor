require 'set'

# TODO: this could be be improved by using a bloom filter rather than a Set.  The stopwords
# list is small enough though that I don't think it will really matter
module KeywordExtractor
   class Stopwords 
    attr_accessor :stopwords

    def initialize(filename=nil)
      @stopwords = Set.new(File.read(File.join(File.dirname(File.expand_path(__FILE__)), '../..', filename)).split(/\s+/)) unless filename.nil?
    end

    def include?(word)
      @stopwords.include? word
    end
  end
end
