require 'pry'
require 'nokogiri'
require 'open-uri'
require_relative 'lib/crypto_scrapper'
require_relative 'lib/townhalls_emails'

cryptocurrencies_uri = 'https://coinmarketcap.com/all/views/all/'

p upload_cryptocurrencies_from_(cryptocurrencies_uri)

uri = 'https://www.annuaire-des-mairies.com/val-d-oise.html'

p upload_townhalls_emails_of_Val_d_Oise(uri)