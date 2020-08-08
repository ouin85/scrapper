require 'pry'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'csv'

$:.unshift File.expand_path("./../lib", __FILE__)
require 'crypto_currencies_scrapper'
require 'townhalls_emails_scrapper'
require 'deputies_scrapper'
require 'data_loger'

begin
  puts '---------------------'
  puts "1. Cryptocurrencies"
  puts "2. Townhalls emails"
  puts "3. Contact details of deputies of France"
  puts "4. Quit"
  print 'Enter you choise > '
  choise = gets.to_i
  puts '----------------------'
  if choise == 1
    url = 'https://coinmarketcap.com/all/views/all/'
    CryptoCurrenciesScrapper.new(url).perform
  elsif choise == 2
    url = 'https://www.annuaire-des-mairies.com/val-d-oise.html'
    TownhallsEmailsScrapper.new(url).perform
  elsif choise == 3
    url = 'http://www2.assemblee-nationale.fr'
    DeputiesScrapper.new(url).perform
  end
end while (choise != 4)