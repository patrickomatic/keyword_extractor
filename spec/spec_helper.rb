require 'rubygems'
require 'bundler/setup'

require 'keyword_extractor'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :documentation
end
