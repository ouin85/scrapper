require 'nokogiri'
require 'open-uri'
require_relative '../lib/crypto_scrapper'

describe "The open_uri method" do
  it "should return un HTML Document" do
    expect(open_page_at_('https://coinmarketcap.com/all/views/all/')).to be_an_instance_of(Nokogiri::HTML::Document)
  end
end

describe "The extract_crypto_names method" do
  it "should return un Array" do
    expect(extract_crypto_names(open_page_at_('https://coinmarketcap.com/all/views/all/'))).to be_an_instance_of(Array)
  end
end

describe "The extract_crypto_values method" do
  it "should return un Array" do
    expect(extract_crypto_values(open_page_at_('https://coinmarketcap.com/all/views/all/'))).to be_an_instance_of(Array)
  end
end

describe "The upload_cryptocurrencies_from_ method" do
  it "should return un Array" do
    expect(upload_cryptocurrencies_from_('https://coinmarketcap.com/all/views/all/').count).to be >= (200)
  end
end