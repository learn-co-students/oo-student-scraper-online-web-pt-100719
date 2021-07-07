require 'nokogiri'
require 'open-uri'
require 'pry'



class Scraper
  
  # attr_accessor :student_hash
  
 
  def self.scrape_index_page(index_url)
    index_url = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    index_url.css(".student-card").map do |student_card|
      student_hash = {}
      #binding.pry
      student_hash[:name] = student_card.css('.student-name').text
      student_hash[:location] = student_card.css('.student-location').text
      profile_url = student_card.css('a[href]').map {|element| element["href"]}
      student_hash[:profile_url] =  profile_url[0]
      student_hash
    end
  end

  def self.scrape_profile_page(profile_url)
      profile_html = Nokogiri::HTML(open(profile_url))
      profile_hash = {}
        profile_html.css(".social-icon-container").map do |social_icon_html|
          social_links = social_icon_html.css('a[href]').map {|element| element["href"]}
          social_links.each do |social_link|
            if social_link.include?('twitter')
              profile_hash[:twitter] = social_link 
            elsif social_link.include?('linkedin')
              profile_hash[:linkedin] = social_link
            elsif social_link.include?('github')
              profile_hash[:github] = social_link
            else
              profile_hash[:blog] = social_link
            end
          end
        end
      profile_hash[:profile_quote] = profile_html.css('.profile-quote').text
      profile_hash[:bio] = profile_html.css('.bio-content p').text
      profile_hash
  end
end

