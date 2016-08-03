require 'pry'
require 'open-uri'

class GemProject::CommunityMeeting

  attr_accessor :name, :neighborhoods, :address, :url

  # binding.pry

  def scrape_index_page

    # html = open('http://www.nyc.gov/html/cau/html/cb/manhattan.shtml')

    # doc = Nokogiri::HTML(html)
      # binding.pry

    # doc.css('tbody').each do |el|
    #   puts el.text
    # end

    # all community boards (title - community board 1/2/ doc.css('td.cb_title').each do |el| puts el.text end)
    # websites doc.css('td.cb_text a/@href').map do |el| el.text end
  end


  def self.boards
    #new name
    # GemProject::MeetingScraper.new("https:/")
    self.scrape_meetings
  end

  def self.scrape_meetings
    meetings = []

    meetings << self.scrape_all

    # board_1 = self.new
    # board_1.name = "Community board 1"
    # board_1.neighborhood = "neighborhood 1"
    # board_1.address = "Address"
    # board_1.url = "www.gov.com"
    #
    # board_2 = self.new
    # board_2.name = "Community board 1"
    # board_2.neighborhood = "neighborhood 1"
    # board_2.address = "Address"
    # board_2.url = "www.gov.com"


  #  [board_1, board_2]
    meetings
  end

  def self.scrape_all
    doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
    binding.pry

    doc.css('td.cb_text#top').map do |el|
      meeting = GemProject::CommunityMeeting.new
      meeting.neighborhoods = el.text.split(',')
      #array of neighborhoods -> can use include method in the future

      #community_meeting.all.first
      #community_meeting.find_by_name <- make method, class methods to assign in the data


    end


    # community_meeting = self.new *done
    # community_meeting.name =
    # community_meeting.address =
    # community_meeting.neighborhood =
    #
    # community_meeting
  end


end

hanna = GemProject::CommunityMeeting.new
hanna.scrape_index_page


#neighborhoods doc.css('td.cb_text#top').map do |el| el.text end
# doc.css('td.cb_text#top').map{|el| el.text}[1]
