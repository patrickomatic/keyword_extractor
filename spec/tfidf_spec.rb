require 'spec_helper'

describe KeywordExtractor::TFIDF do
  let(:text) { "this is a document with some text about things and things" }
  let(:document) { KeywordExtractor::Document.new(text) } 
  let(:term) { "things" }


  describe "analyze" do
    # XXX
  end


  describe "tf_idf" do
    # XXX 
  end


  describe "term_frequency" do
    subject { KeywordExtractor::TFIDF.term_frequency(term, document) }
    it { should == 2 }

    context "with a word that appears once" do
      let(:term) { "some" }
      it { should == 1 }
    end

    context "with a word that doesn't exist" do
      let(:term) { "adsf" }
      it { should == 0 }
    end
  end


  describe "boolean_term_frequency" do
    subject { KeywordExtractor::TFIDF.boolean_term_frequency(term, document) } 

    it { should == 1 }

    context "with a word that doesn't exist" do
      let(:term) { "adsf" }
      it { should == 0 }
    end
  end


  describe "logarithmic_term_frequency" do
    subject { KeywordExtractor::TFIDF.logarithmic_term_frequency(term, document) } 

    it { should > 0 } 

    context "with a word that doesn't exist" do
      let(:term) { "adsf" }
      it { should == 0 }
    end
  end


  describe "augmented_term_frequency" do
    subject { KeywordExtractor::TFIDF.augmented_term_frequency(term, document) } 

    it { should == 1.0 } 

    context "with a word that appears once" do
      let(:term) { "document" }
      it { should == 0.75 }
    end

    context "with a word that doesn't exist" do
      let(:term) { "adsf" }
      it { should == 0.5 }
    end
  end


  describe "inverse_document_frequency" do
    subject { KeywordExtractor::TFIDF.inverse_document_frequency(term, 2, 1) }

    it { should == 0.0 }
  end
end
