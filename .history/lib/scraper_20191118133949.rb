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
    student_twitter = []
    student_linkedin = []
    student_github = []
    bio = {}
    students_bio.css("div.profile").each do |student| # Accesses student bio page iterating over each ******* NOT FINISHED!
      student.css(".social-icon-container a").each do |link|
        case
        when link['href'].include?("twitter")
          student_twitter << link['href']
        when link['href'].include?("linkedin")
          student_linkedin << link['href']
        when link['href'].include?("github")
          student_github << link['href']
      end
    binding.pry
      # social = student.css(".social-icon-container a:first").attribute("href").value
      # profile_quote = student.css(".profile-quote").text
      # bio = student.css(".description-holder p").text
      # binding.pry
    end
  end
end

