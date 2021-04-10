class TownhallsEmailsScrapper
  attr_accessor :url_phonebook

  def initialize(url)
    @url_phonebook = url
  end
  
  def perform
    begin
      puts 'Get townhalls names, please wait !'
      townhalls_names = get_townhalls_names
      puts 'Done.'
    rescue => e
      puts e.message
      puts "Oups! Sorry, that didn't work !"
    end
    begin
      puts 'Get townhalls emails, please wait !'
      townhalls_emails = get_townhalls_emails_of_Val_d_Oise
      puts 'Done.'
    rescue => e
      puts e.message
      puts "Oups ! Sorry, that didn't work !"
    end
    begin
      puts 'Make the townhalls names and emails array, please wait !'
      size = townhalls_names.size
      townhalls_names_emails_array = Array.new(size) {Hash.new}
      size.times do |i|
        townhalls_names_emails_array[i][townhalls_names[i]] = townhalls_emails[i]
      end
      puts 'Done'

      puts 'Saving data ...'
      data_loger = DataLoger.new(townhalls_names_emails_array)
      puts 'Saving townhalls names and emails array as json file, please wait !'
      data_loger.save_as_JSON('townhalls')
      puts 'Done.'

      puts 'Saving townhalls names and emails array as CSV file, please wait !'
      data_loger.save_as_CSV('townhalls')
      puts 'Done.'
    rescue => e
      puts e.message
      puts "Oups! Sorry, that didn't work !"
    end
  end

  private

  def open_page_at_(url)
    Nokogiri::HTML(open(url))
  end

  def get_townhalls_urls
    open_page_at_(@url_phonebook).xpath('//tr/td/p/a')
    .map { |item| item['href'] }
  end
  
  def get_townhalls_names
    open_page_at_(@url_phonebook).xpath('//tr/td/p/a')
    .map { |item| item.text }
  end

  def get_townhall_email(townhall_url)
    open_page_at_(townhall_url).xpath('//tr[4]/td[2]')[0].text
  end
  
  def get_townhalls_emails_of_Val_d_Oise
    url_complement = @url_phonebook[0..@url_phonebook.size-16]
    get_townhalls_urls.map { |townhall_url| get_townhall_email(url_complement + townhall_url[2..townhall_url.size-1]) }
  end
end