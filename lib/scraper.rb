require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css(".student-card").each do |student_card|
      student = {
        :name => student_card.css(".card-text-container .student-name").text,  
        :location => student_card.css(".card-text-container p").text,
        :profile_url =>student_card.css("a").attribute("href").value
      }
      scraped_students << student
      #binding.pry
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_container = doc.css(".vitals-container .social-icon-container a")
    student_hash = {}
    social_container.each do |link|
      if link.attribute("href").value.include?("twitter")
        student_hash[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        student_hash[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        student_hash[:github] = link.attribute("href").value
      else 
        student_hash[:blog] = link.attribute("href").value
      end
    end
    student_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    student_hash[:bio] = doc.css(".details-container .bio-block .bio-content .description-holder p").text    
    student_hash
  end
  

end

