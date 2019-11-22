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
    doc_page = Nokogiri::HTML(open(profile_url)) # Parsed page
    bio_hash = {}
    bio_hash[:profile_quote] = doc_page.css(".profile-quote").text
      bio_hash[:bio] = doc_page.css(".description-holder p").text
    
    doc_page.css(".social-icon-container a").each do |value| # Iterates through each social icon and checks if attribute href includes certain string
      case # Case statement creates key/value pair and pushs to bio_hash
      when value.attr('href').include?("twitter")
        bio_hash[:twitter] = value.attr('href')
      when value.attr('href').include?("linkedin")
        bio_hash[:linkedin] = value.attr('href')
      when value.attr('href').include?("github")
        bio_hash[:github] = value.attr('href')
      when value.attr('href').include?(".com")
        bio_hash[:blog] = value.attr('href')
      end
    end
    bio_hash
  end
end

