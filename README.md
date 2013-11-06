keyword\_extractor
=================

Ruby-based utility for extracting keywords from a corpus of documents, based on the 
TF/IDF algorithm ([http://en.wikipedia.org/wiki/Tf-idf](http://en.wikipedia.org/wiki/Tf%E2%80%93idf))


Usage
=================
  
	> documents = [
		'Suppose we have a set of English text documents and wish to determine which document is most relevant to the query "the brown cow".',
		'A simple way to start out is by eliminating documents that do not contain all three words "the", "brown", and "cow", but this still leaves many documents.',
		'To further distinguish them, we might count the number of times each term occurs in each document and sum them all together; the number of times a term occurs in a document is called its term frequency.',
	]

	> KeywordExtractor.extract_keywords(documents)


Configuration
=================

The two options which can be configured are `term_frequency_strategy` and `stopwords_file`:

	KeywordExtractor.configure do |config|
		config.term_frequency_strategy = :count
		config.stopwords_file = '/path/to/my/stopwords.txt'
	end

The supported options for these config paramters are:

  * `term_frequency_strategy` - Can be one of either `:count`, `:boolean`, `:logarithmic` or `:augmented`.  The difference between these various strategies can be found on the [TF-IDF Wikipedia Page](http://en.wikipedia.org/wiki/Tf%E2%80%93idf#Mathematical_details).  The default setting is `:augmented`.

  * `stopwords_file` - The path to a file containing a list of custom [stopwords](http://en.wikipedia.org/wiki/Stopwords).  If set to nil, no stopwords file will be used.  The file provided should be plain text and have one stopword per line.
