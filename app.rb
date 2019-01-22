require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib/app/", __FILE__)
require 'scrapper'

# call the scrapp_data and save_as_JSON
#Scrapper.new.perform

puts hash