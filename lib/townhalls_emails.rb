def get_townhall_email(townhall_url)
  open_page_at_(townhall_url).xpath('//tr[4]/td[2]')[0].text
end

def get_townhalls_urls(url_phonebook)
  open_page_at_(url_phonebook).xpath('//tr/td/p/a')
  .map { |item| item['href'] }
end

def get_townhalls_names(url_phonebook)
  open_page_at_(url_phonebook).xpath('//tr/td/p/a')
    .map { |item| item.text }
end

def get_townhalls_emails_of_Val_d_Oise(url_phonebook)
  url_complement = url_phonebook[0..url_phonebook.size-16]
  emails = get_townhalls_urls(url_phonebook).map { |townhall_url| get_townhall_email(url_complement + townhall_url[2..townhall_url.size-1]) }
end

def upload_townhalls_emails_of_Val_d_Oise(url_phonebook)
  begin
    puts 'Get townhalls names, please wait !'
    townhalls_names = get_townhalls_names(url_phonebook)
    puts 'Done.'
  rescue => e
    puts e.message
    puts "Oups! Sorry, that didn't work!"
  end
  begin
    puts 'Get townhalls emails, please wait!'
    townhalls_emails = get_townhalls_emails_of_Val_d_Oise(url_phonebook)
    puts 'Done.'
  rescue => e
    puts e.message
    puts "Oups! Sorry, that didn't work!"
  end
  begin
    puts 'Preparing to display the result'
    size = townhalls_names.size
    townhalls_names_emails_array = Array.new(size) {Hash.new}
    i = 0
    size.times do |i|
      townhalls_names_emails_array[i][townhalls_names[i]] = townhalls_emails[i]
      i+=1
    end
    puts 'Done'
    townhalls_names_emails_array
  rescue => e
    puts e.message
    puts "Oups! Sorry, that didn't work!"
  end
end