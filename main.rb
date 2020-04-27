require 'pry'
require 'nokogiri'
require 'open-uri'
require_relative 'lib/crypto_scrapper'
require_relative 'lib/townhalls_emails'

begin
  puts '---------------------'
  puts "1. Cryptocurrencies"
  puts "2. Townhalls emails"
  puts "3. Quit"
  print 'Enter you choise > '
  choise = gets.to_i
  puts '----------------------'
  if choise == 1
    cryptocurrencies_uri = 'https://coinmarketcap.com/all/views/all/'
    p upload_cryptocurrencies_from_(cryptocurrencies_uri)
  elsif choise == 2
    uri = 'https://www.annuaire-des-mairies.com/val-d-oise.html'
    p upload_townhalls_emails_of_Val_d_Oise(uri)
  end
end while (choise != 3)