require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_page = Nokogiri::HTML(open(index_url)) # Parsed page
    students = []
    students_page.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_information = {:name => name, :location => location, :profile_url => profile_url}

      students << student_information
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students_bio = Nokogiri::HTML(open(profile_url)) # Parsed page
    bio = {}
    students_bio.css("div.profile").each do |student|
      twitter = student.css(".social-icon-container a").attribute("href").value
      # location = student.css(".student-location").text
      # profile_url = student.css("a").attribute("href").value
      binding.pry
    end
  end

end

