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


  describe 'extract_top_keywords' do
    subject { KeywordExtractor.extract_top_keywords(documents, 3) }

    its(:length) { should == 3 }
  end


  describe 'extract_keywords' do
    subject { KeywordExtractor.extract_keywords(documents) }

    def each_rank
      subject.each do |document, keywords|
        keywords.each do |k|
          yield k.rank
        end
      end
    end


    it { should_not be_nil } 

    its(:length) { should == 6 } 

    it "has all positive ranks" do
      each_rank {|r| r.should >= 0}
    end

    context "with a single document" do
      let(:documents) { ['this is a document'] }

      it "should not contain stopwords" do
        subject.values.length.should == 1
        subject.values.first.first.word.should == 'document'
      end

      it "has all positive ranks" do
        each_rank {|r| r.should >= 0}
      end
    end

    context "with a single document with two sentences" do
      let(:documents) { ['this is the first sentence. this is the second sentence'] }
      its(:length) { should == 2 }
    end

    context "with mutually exclusive documents" do
      let(:documents) { ['mutually exclusive document', 'not in this one'] }

      it "has all positive ranks" do
        each_rank {|r| r.should >= 0}
      end
    end
  end
end
