require 'pry'
require 'open-uri'
# require_relative './gem_project.rb'

class GemProject::CommunityMeeting
# class CommunityMeeting
  attr_accessor :name, :neighborhoods, :address, :url, :phone, :hours, :agenda

  # binding.pry
  def initialize
  end

    #
  def self.scrape_all
      doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
      meetings = []

      array_of_board_neighborhoods = doc.css('td.cb_text#top').map do |el|
        meeting = GemProject::CommunityMeeting.new
        meeting.neighborhoods = el.text.split(',')
        meetings << meeting
      end


      array_of_board_title = doc.css('td.cb_title').map do |title| title.text end
          meetings.each_with_index do |meeting, i|
              # meeting.name = array_of_board_title[i]
          end

    def set_names(array)
      array.each_with_index do |arr, i|


    end

      array_of_urls = doc.css('td.cb_text a/@href').map do |el| el.text end
          meetings.each_with_index do |meeting, i|
            meeting.url = array_of_urls[i]
          end

      binding.pry
      array = doc.css('tbody').map do |el| el.text end
      new_array = []

      array.each_with_index do |el, i|
        new_array << el if i.even?
        # binding.pry
      end

        new_array.each_with_index do |el, i|
            meetings.each_with_index do |meeting, i|
              meeting.address = new_array[i].split("\n").detect do |el| el if el.include?("Address: ") end.gsub(/Ph.*/, "").gsub("Address: ", "")
                  meeting.phone = new_array[i].scan(/Phone: (\d*-\d*-\d*)/).flatten.join
            end
        end
              # binding.pry

          # meetings.each_with_index do |meeting, i|
            # binding.pry
            # if i == 0
            # meeting.address = array[i].split("\n").detect do |el| el if el.include?("Address: ") end.gsub(/Ph.*/, "").gsub("Address: ", "")
            # else
            #
            #   meeting.address = array[i+2].split("\n").detect do |el| el if el.include?("Address: ") end.gsub(/Ph.*/, "").gsub("Address: ", "")
            # end
            # binding.pry

            # end
            # binding.pry
      array = doc.css('tbody').map do |el| el.text end
        meetings.each_with_index do |meeting, i|
          k = array[i].index("Meeting")

          j = array[i].index("Precinct")
          words = ""
          words << array[i][k..j-1]
          hours = words.split("Cabinet")
          meeting1 = "Board " + hours[0]
          # binding.pry
          meeting2 = " Cabinet" + hours[1].gsub("\n", "")
          # binding.pry
          meeting.hours = meeting1 + meeting2

        end
        # binding.pry

        meetings.each do |n|
          if n.name == "Community Board 10"
            n.agenda = "PDF files of Community Board 10's agenda can be found here: http://www.nyc.gov/html/mancb10/html/board/minutes.shtml"
          elsif n.name == "Community Board 1"
            n.agenda = n.one_agenda
          end
        end

        # meetings.each do |mtg|
        #   if mtg.name == "Community Board 1"
        #     mtg.agenda ==
        #           binding.pry
        #   end
        # end
        # binding.pry
      meetings
    end



    def one_agenda
      doc = Nokogiri::HTML(open("http://www.nyc.gov/html/mancb1/html/community/community.shtml"))
      page = doc.css("span.bodytext").text.split("Location")
      sentence = page[1].split("Conference Room")[1].split("Centre")
      s = sentence[1].gsub("\"", "").gsub("\n"," ").split("1)")
      # binding.pry
      sentence_output = "1) #{s[1]}"

    end


end
