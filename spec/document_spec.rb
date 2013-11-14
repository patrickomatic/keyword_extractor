require 'spec_helper'

describe KeywordExtractor::Document do
  let(:text) { "this is a document" }
  let(:minimum_word_size) { nil } 
  let(:document) { KeywordExtractor::Document.new(text, nil, minimum_word_size) }


  describe "id" do
    subject { document.id }
    it { should_not be_nil }
  end


  describe "tokenized_words" do
    subject { document.tokenized_words }
    it { should == %w{this is a document} }

    context "with various punctuation" do
      let(:text) { 'The; query, is "the brown cow".' }
      it { should == %w{the query is the brown cow} }
    end

    context "with words smaller than minimum_word_size" do
      let(:minimum_word_size) { 4 } 
      let(:text) { 'a b c wor' }

      it { should == [] }
    end
  end


  describe "most_common_word_frequency" do
    subject { document.most_common_word_frequency }

    it { should == 1 }

    context "with a repeating word" do
      let(:text) { "this is is is a document" }
      it { should == 3 }
    end
  end


  describe "frequency" do
    subject { document.frequency('document') }

    it { should == 1 }

    context "with a repeating term" do
      let(:text) { "this is a document document" }
      it { should == 2 }
    end
  end
end
