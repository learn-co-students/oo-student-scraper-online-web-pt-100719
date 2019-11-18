require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_page = Nokogiri::HTML(open(index_url)) # Parsed page
    students = []
    student_page.css("div.student-card").each do |student|
      name = student_page.css(".student-name").text
      binding.pry
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

