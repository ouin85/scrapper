class CryptoCurrenciesScrapper
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def perform
    puts 'Get cryptocurrencies page, please wait !'
    page = open_page
    puts 'Done'
    begin
      puts 'Get cropto names, please wait !'
      cropto_names = extract_crypto_names(page)
      puts 'Done.'
    rescue => e
      puts e.message
      puts "Oups! Sorry, that didn't work !"
    end
    
    begin
      puts 'Get crypto values, please wait !'
      crypto_values = extract_crypto_values(page)
      puts 'Done.'
    rescue => e
      puts e.message
      puts "Oups! Sorry, that didn't work !"
    end
  
    begin
      puts 'Make cryptocurrencies array, please wait !'
      size = crypto_values.size
      cryptocurrencies_array = Array.new(size) {Hash.new}
      size.times do |i|
        cryptocurrencies_array[i][cropto_names[i]] = crypto_values[i]
        puts i
      end
      puts 'Done.'

      puts 'Saving data ...'
      data_loger = DataLoger.new(cryptocurrencies_array)
      puts 'Saving cryptocurrencies as json file, please wait !'
      data_loger.save_as_JSON('cryptocurrencies')
      puts 'Done.'

      puts 'Saving cryptocurrencies as CSV file, please wait !'
      data_loger.save_as_CSV('cryptocurrencies')
      puts 'Done.'
    rescue => e
      puts e.message
      puts "Oups! Sorry, that didn't work!"
    end
  end


  private

  def open_page
    Nokogiri::HTML(open(url))
  end
  
  def extract_crypto_names(page) 
    page.xpath('//tr/td[3]/div').map { |item| item.text }
  end
  
  def extract_crypto_values(page)
    page.xpath('//tr/td[5]').map { |item| item.text }
  end
  
end