require 'spec_helper'

describe KeywordExtractor::Configuration do
  let(:configuration) { KeywordExtractor::Configuration.new }


  describe "default values" do
    subject { configuration }

    its(:term_frequency_strategy) { should == :count }
    its(:stopwords_file) { should == 'stopwords/english.txt' }
  end


  describe "stopwords_file=" do
    let(:file) { "stopwords/english.txt" }
    subject { configuration.stopwords_file = file }

    it { should_not be_nil }

    context "with a file that doesn't exist" do
      let(:file) { "foo.txt" }
      specify { expect { subject }.to raise_error }
    end

    context "with nil" do
      let(:file) { nil }
      it { should be_nil }
    end
  end


  describe "term_frequency_strategy=" do
    let(:strategy) { :count }
    subject { configuration.term_frequency_strategy = strategy }

    it { should_not be_nil }

    context "with an invalid term frequency" do
      let(:strategy) { :invalid_strategy }
      specify { expect { subject }.to raise_error }
    end
  end
end
