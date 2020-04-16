require 'pry'
require 'nokogiri'
require 'open-uri'
require_relative 'lib/crypto_scrapper'

uri = 'https://coinmarketcap.com/all/views/all/'

begin
  p upload_cryptocurrencies_from_(uri)
rescue => e
  puts e.message
end