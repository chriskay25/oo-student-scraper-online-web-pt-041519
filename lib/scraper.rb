require 'open-uri'
require 'pry'

class Scraper

  #Scrape page and collect name, location, and profile_url. Scrape_index_page should return an array of hashes: [{name: "CK", location: "GA", url: "url"}, {name: "KC", location: "CA"...}]

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      name = student.css("a h4").text
      location = student.css("a p").text
      profile_url = student.css("a").attribute("href").value
      student_info = {name: name, location: location, profile_url: profile_url}
      students << student_info 
    end 
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))               
    student = Hash.new
    doc.css("div.social-icon-container a").each do |si| 
      if si.attribute("href").value.include?("twitter")
        student[:twitter] = si.attribute("href").value 
      elsif si.attribute("href").value.include?("linkedin")
        student[:linkedin] = si.attribute("href").value
      elsif si.attribute("href").value.include?("github")
        student[:github] = si.attribute("href").value
      else 
        student[:blog] = si.attribute("href").value
      end 
      student[:profile_quote] = doc.css("div.profile-quote").text
      student[:bio] = doc.css("div.bio-content.content-holder p").text
    end
    student
  end

end

