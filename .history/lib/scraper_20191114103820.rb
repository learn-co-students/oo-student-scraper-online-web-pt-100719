require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_page = Nokogiri::HTML(open(index_url)) # Parsed page
    students = []
    students_page.css("div.student-card").each do |student| # Accesses student main page iterating over each student thumbnail info
      name = student.css(".student-name").text # Assigns name variable = each student name
      location = student.css(".student-location").text # Assigns location variable = each student location
      profile_url = student.css("a").attribute("href").value # Assigns profile_url = the link attribute href of each student
      student_information = {:name => name, :location => location, :profile_url => profile_url} # Creates hash symbol key and value for each student attribute 

      students << student_information # Pushes student_information to the students array to be returned
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students_bio = Nokogiri::HTML(open(profile_url)) # Parsed page
    bio = {}
    students_bio.css("div.profile").each do |student| # Accesses student bio page iterating over each ******* NOT FINISHED!
      social = student.css(".social-icon-container a").attribute("href").value
      # location = student.css(".student-location").text
      # profile_url = student.css("a").attribute("href").value
    end
    binding.pry
  end

end

