require 'pry'
require 'nokogiri'
require 'open-uri'
require 'json'

class Scrapper
  attr_accessor :root_url, :deputies_emails
  
  def initialize(root_url)
    @root_url = root_url
    @deputies_emails = []
  end
  
  def perform
    begin
      # --- Getting deputies first names ---
      puts 'Getting deputies first names ...'
      first_names = get_deputies_first_names
      puts 'Done.'

      # --- Getting deputies last names ---
      puts 'Getting deputies last names ...'
      last_names = get_deputies_last_names
      puts 'Done.'
      
      # --- Getting deputies emails ---
      puts 'Getting deputies emails. Please wait, it may takes a few minutes ...'
      emails = get_deputies_emails
      puts 'Done.'

      # --- Make a deputies array ---
      puts "Make a deputies array ..."
      deputies_array = []
      first_names.count.times { |index|
        deputies_array << {
          "first_name" => "#{first_names[index]}",
          "last_name" => "#{last_names[index]}",
          "email" => "#{emails[index]}"
        }
      }
      puts "Done."
      
      # --- Save deputies informations as json file ---
      puts "Saving deputies informations as json file ..."
      File.open('db/deputies.json', 'w') { |f| f << JSON.pretty_generate(deputies_array) }
      puts "Done."
    rescue RuntimeError => e
      puts e.message
      puts "Oups! Sorry, that didn't work!"
    end
  end
  
  private
  def open_page_at_(url)
    Nokogiri::HTML(open(url))
  end
  
  def get_deputies_plugs_urls
    deputies_list_url = @root_url + '/deputes/liste/regions'
    open_page_at_(deputies_list_url).xpath('//div[@id="deputes-list"]/div/ul/li/a')
    .map{ |item| item['href']}
  end
  
  def get_deputies_first_names
    deputies_table_url = @root_url + '/deputes/liste/regions/(vue)/tableau'
    open_page_at_(deputies_table_url).xpath('//tr/td[2]')
    .map { |item| item.text }
  end
  
  def get_deputies_last_names
    deputies_table_url = @root_url + '/deputes/liste/regions/(vue)/tableau'
    open_page_at_(deputies_table_url).xpath('//tr/td[3]')
    .map { |item| item.text }
  end
  
  def get_deputy_email_at(plug_relative_url)
    plug_absolute_url = @root_url + plug_relative_url
    email_tag = open_page_at_(plug_absolute_url).xpath('//dl[@class="deputes-liste-attributs"]/dd[4]/ul/li[2]/a')[0]
    if email_tag
      return email_tag.text
    else
      return ''
    end
  end

  def get_deputies_emails
    get_deputies_plugs_urls.map { |url| get_deputy_email_at(url) }
  end
end

scrapper = Scrapper.new('http://www2.assemblee-nationale.fr').perform