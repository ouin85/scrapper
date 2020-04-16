require 'nokogiri'
require 'open-uri'
require_relative '../lib/townhalls_emails'
require_relative '../lib/crypto_scrapper'

describe "The get_townhall_email method" do
  it "should return a String" do
    expect(get_townhall_email('https://www.annuaire-des-mairies.com/95/avernes.html')).to be_an_instance_of(String)
  end
end

describe "The get_townhalls_urls method" do
  it "should return a Array" do
    expect(get_townhalls_urls('https://www.annuaire-des-mairies.com/val-d-oise.html')).to be_an_instance_of(Array)
  end

  it "should return a Array not nit" do
    expect(get_townhalls_urls('https://www.annuaire-des-mairies.com/val-d-oise.html')).to_not be_nil
  end
end