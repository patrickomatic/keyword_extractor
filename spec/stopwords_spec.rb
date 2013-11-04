require 'spec_helper'

describe KeywordExtractor::Stopwords do
  let(:stopwords) { KeywordExtractor::Stopwords.new }

  describe "include?" do
    let(:stopword) { 'a' }
    before { stopwords.stopwords = ['a', 'and', 'the'] }
    subject { stopwords.include?(stopword) }
    
    it { should be_true }

    context "with a word that isn't a stop word" do
      let(:stopword) { "asdf" }
      it { should_not be_true }
    end
  end
end
