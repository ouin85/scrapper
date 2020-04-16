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
  page = open_page_at_(uri)
  cropto_names = extract_crypto_names(page)
  crypto_values = extract_crypto_values(page)
  size = crypto_values.size
  cryptocurrencies_array = Array.new(size) {Hash.new}
  i = 0
  size.times do |i|
    cryptocurrencies_array[i][cropto_names[i]] = crypto_values[i]
    i+=1
  end
  cryptocurrencies_array
end