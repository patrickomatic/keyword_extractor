require 'spec_helper'

describe KeywordExtractor do
  let(:documents) do 
    [ 'this is a sentence about cats and dogs',
      'this is a sentence about social media',
      'i like to post things about the social media',
      'sometimes i post pictures of the cats',
      'this is a post',
      'this is the last post' ] 
  end

  describe 'extract_keywords' do
    subject { KeywordExtractor.extract_keywords(documents) }
    it { should_not be_nil } 
    its(:length) { should == 6 } 
  end
end
