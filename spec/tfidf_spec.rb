require 'spec_helper'

describe KeywordExtractor::TFIDF do
  let(:text) { "this is a document with some text about things and things" }
  let(:document) { KeywordExtractor::Document.new(text) } 
  let(:term) { "things" }


  describe "analyze" do
    let(:corpus) { [document] }
    let(:term_frequency_strategy) { :count }

    subject { KeywordExtractor::TFIDF.analyze(corpus, term_frequency_strategy) }

    context "with term_frequency_strategy == :count" do
      before { KeywordExtractor::TFIDF.should_receive(:term_frequency).at_least(:once).and_return(1) }
      it { should_not be_nil }
    end

    context "with term_frequency_strategy == :boolean" do
      let(:term_frequency_strategy) { :boolean }
      before { KeywordExtractor::TFIDF.should_receive(:boolean_term_frequency).at_least(:once).and_return(1) }
      it { should_not be_nil }
    end

    context "with term_frequency_strategy == :logarithmic" do
      let(:term_frequency_strategy) { :logarithmic }
      before { KeywordExtractor::TFIDF.should_receive(:logarithmic_term_frequency).at_least(:once).and_return(1) }
      it { should_not be_nil }
    end

    context "with term_frequency_strategy == :augmented" do
      let(:term_frequency_strategy) { :augmented }
      before { KeywordExtractor::TFIDF.should_receive(:augmented_term_frequency).at_least(:once).and_return(1) }
      it { should_not be_nil }
    end

    context "with an unsupported term_frequency_strategy" do
      let(:term_frequency_strategy) { :asdf }
      specify { expect { subject }.to raise_error }
    end
  end


  describe "tf_idf" do
    let(:tf) { {'document_id1' => {'word' => 1, 'another' => 2, 'more' => 3}} }
    let(:idf) { {'word' => 0, 'another' => 1, 'more' => 0} }

    subject { KeywordExtractor::TFIDF.tf_idf(tf, idf) }

    it { should_not be_nil }
    it { should be_instance_of(Hash) }
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
