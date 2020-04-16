def open_page_at_(uri)
  Nokogiri::HTML(open(uri))
end

def extract_crypto_names(page) 
  page.xpath('//tr/td[3]/div').map { |item| item.text }
end

def extract_crypto_values(page)
  page.xpath('//tr/td[5]').map { |item| item.text }
end

def upload_cryptocurrencies_from_(uri)
  puts 'Get cryptocurrencies page, please wait!'
  page = open_page_at_(uri)
  puts 'Done'
  begin
    puts 'Get cropto names, please wait!'
    cropto_names = extract_crypto_names(page)
    puts 'Done.'
  rescue => e
    puts e.message
    puts "Oups! Sorry, that didn't work!"
  end
  
  begin
    puts 'Get crypto values, please wait!'
    crypto_values = extract_crypto_values(page)
    puts 'Done.'
  rescue => e
    puts e.message
    puts "Oups! Sorry, that didn't work!"
  end

  begin
    puts 'Preparing to display the result'
    size = crypto_values.size
    cryptocurrencies_array = Array.new(size) {Hash.new}
    i = 0
    size.times do |i|
      cryptocurrencies_array[i][cropto_names[i]] = crypto_values[i]
      i+=1
    end
    puts 'Done.'
    cryptocurrencies_array
  rescue => e
    puts e.message
    puts "Oups! Sorry, that didn't work!"
  end
end