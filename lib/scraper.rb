require 'open-uri'
require 'pry'

class Scraper

# The scrape_index_page method is a class method that takes in an argument of the url of the index page.  
# this method is responsible for scraping the index page that lists all of the students. 
# Nokogiri was used to access the given url, the return value is an array of hashes in which each hash represents
# a single student. the keys of the individual student hashes are :name, :location and :profile_url
# students was set to an empty array and the individual student hashes are shoveled into that array. 

  def self.scrape_index_page(index_url)
    html = open(index_url)
    students = []
    Nokogiri::HTML(html).css("div.roster-cards-container div.student-card").each { |student|
      students << {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    }
    students
  end


# The scrape_profile_page is a class method that takes in a argument of profile_url. this method is responsible
# for scraping an individual student's profile page to get further information about that student.
# Nokogiri was used to acess that page. the return value of this method is a hash in which the key/value pairs describe 
# an individual student based of the profile_url. 
# the .each was use to iterate over the info and conditionals we set using the if, elsif and else. 


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    nok = Nokogiri::HTML(html)
    profile_info = {}
    profile_bio = nok.css("div.details-container div.bio-block.details-block div.bio-content.content-holder div.description-holder p").text

    nok.css("div.vitals-container").each { |info|
      info.css("div.social-icon-container a").each { |social|
        if(social.attribute("href").value.include?("twitter"))
          profile_info[:twitter] = social.attribute("href").value
        elsif(social.attribute("href").value.include?("linkedin"))
          profile_info[:linkedin] = social.attribute("href").value
        elsif(social.attribute("href").value.include?("github"))
          profile_info[:github] = social.attribute("href").value
        else
          profile_info[:blog] = social.attribute("href").value
        end
      }
      profile_info[:profile_quote] = info.css("div.vitals-text-container div.profile-quote").text.chomp
    }
    profile_info[:bio] = profile_bio
    profile_info
  end
end