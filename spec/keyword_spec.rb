require 'spec_helper'

describe KeywordExtractor::Keyword do
  describe "<=>" do
    let(:keyword1) { KeywordExtractor::Keyword.new('one', 0.1) }
    let(:keyword2) { KeywordExtractor::Keyword.new('two', 0.4) }
    let(:keyword3) { KeywordExtractor::Keyword.new('three', 0.8) }

    subject { [keyword2, keyword3, keyword1].sort } 

    it { should == [keyword3, keyword2, keyword1] }
  end
end
