require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url) # Unparsed page
    student_page = Nokogiri::HTML(open(index_url)) # Parsed page
    students = []
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

