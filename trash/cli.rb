puts "hanna"

# require_relative "./scaper.rb"
# require_relative "gem_project/community_meeting1.rb"
require 'nokogiri'
require 'pry'


# require 'pry'
require 'open-uri'
# require 'nokogiri'
# require_relative './gem_project.rb'

class Scraper


  def self.scrape_names(nyc_url)
    # doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
    doc = Nokogiri::HTML(open(nyc_url))
    names = doc.css('td.cb_title').map do |title| title.text end
      # binding.pry
      names
  end

  def self.scrape_neighborhoods(nyc_url)
    doc = Nokogiri::HTML(open(nyc_url))
    array_of_board_neighborhoods = doc.css('td.cb_text#top').map do |el|
      el.text.split(',')
    end
  end


  def self.scrape_websites(nyc_url)
    # binding.pry
    # doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
    doc = Nokogiri::HTML(open(nyc_url))
    array_of_urls = doc.css('td.cb_text a/@href').map do |el| el.text end
      # binding.pry

  end

  def self.scrape_phone_address(nyc_url)
    # doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
    doc = Nokogiri::HTML(open(nyc_url))
    array = doc.css('tbody').map do |el| el.text end
      new_array = []

      array.each_with_index do |el, i|
        new_array << el if i.even?
      end

      numbers = []
      addresses = []
      new_array.each_with_index do |el, i|
          addresses << new_array[i].split("\n").detect do |el| el if el.include?("Address: ") end.gsub(/Ph.*/, "").gsub("Address: ", "")
              numbers << new_array[i].scan(/Phone: (\d*-\d*-\d*)/).flatten.join
            end

        [numbers, addresses]
      end



    def self.scraped_phones(nyc_url)
      scrape_phone_address(nyc_url)[0]
      # binding.pry
    end

    def self.scraped_addresses(nyc_url)
        scrape_phone_address(nyc_url)[1]
        # binding.pry
    end


    def self.scrape_hours(nyc_url)
      # doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
      doc = Nokogiri::HTML(open(nyc_url))
      hours = []
      array = doc.css('tbody').map do |el| el.text end
          array.each_with_index.map do |meeting, i|

          mtg_hours = []
          k = array[i].index("Meeting")

          j = array[i].index("Precinct")
          words = ""
          words << array[i][k..j-1]
          hours = words.split("Cabinet")
          part1 = "Board #{hours[0]}. "
          part2 = "Cabinet" + hours[1].gsub("\n", "")
          mtg_hours = [part2 + part2]
        #why is this different than hours
          hours +=  mtg_hours
        end
         hours
        # binding.pry
      end


      def self.meeting_hash(url)

        hashes = []

        scrape_names(url).each_with_index do |name, i|
          meeting = {}
          meeting[:name] = name

          meeting[:phone] = scraped_phones(url)[i.to_i]

            # meeting[:addresses] = scraped_addresses(url)[i.to_i]
          meeting[:website] = scrape_websites(url)[i.to_i]
          meeting[:hours] = scrape_hours(url)[i.to_i]
          meeting[:neighborhoods] = scrape_neighborhoods(url)[i.to_i].to_s
          # binding.pry
          #
          meeting[:address] = scraped_addresses(url)[i.to_i]

          if meeting[:name] == "Community Board 10"
            meeting[:agenda] = "PDF files of Community Board 10's agenda can be found here: http://www.nyc.gov/html/mancb10/html/board/minutes.shtml"
          elsif meeting[:name] == "Community Board 1"
            meeting[:agenda] = one_agenda("http://www.nyc.gov/html/mancb1/html/community/community.shtml")
          end
          # binding.pry

          hashes << meeting
          # binding.pry
        end

        hashes 
        # hashes
        binding.pry

      end


    def self.one_agenda(url)
      doc = Nokogiri::HTML(open(url))
      page = doc.css("span.bodytext").text.split("Location")
      sentence = page[1].split("Conference Room")[1].split("Centre")
      s = sentence[1].gsub("\"", "").gsub("\n"," ").split("1)")
      # binding.pry
      sentence_output = "1) #{s[1]}"
    end




end


class CommunityMeeting1

  attr_accessor :name, :neighborhoods, :address, :website, :phone, :hours, :agenda

  @@all = []

  def initialize(meeting_hash)

    @name = meeting_hash[:name]

    @neighborhoods = meeting_hash[:neighborhoods]
    @address = meeting_hash[:address]
    @website = meeting_hash[:website]
    @agenda = meeting_hash[:agenda]
    @hours = meeting_hash[:hours]

    @@all << self
    # binding.pry
  end

  def self.create_from_collection(meetings_array)
    meetings_array.each do |el|
      self.new(el)
    end

  end

  # def add_meeting_attributes(attributes_hash)
  #   attributes_hash.each{ |k, v| send("#{k}=", v) }
  #
  # end


    def self.all
      @@all
    end


end



# class GemProject::CLI

class CLI
    BASE_URL = "http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"

    def run
      make_meetings
      # display_meetings
      puts "Welcome to Community Meetings! Learn more about what's happening in your neighborhood. Enter the number for one of your neighborhoods below to find out about the community meetings and what's being discussed for it!\n"
      puts
      menu
      goodbye
          # binding.pry
    end

    def make_meetings
      meeting_array = []
      meeting_array = Scraper.meeting_hash(BASE_URL)
      # array_of_meetings = meetings_array.flatten
      # binding.pry
      # CommunityMeeting1.create_from_collection(array_of_meetings)
      CommunityMeeting1.create_from_collection(meeting_array)

      # binding.pry

    end


    def display_meetings
      count = 0
      CommunityMeeting1.all.map do |meeting|
        puts "#{count += 1}. #{meeting.neighborhoods}"
        # binding.pry
        # puts "#{count += 1}. #{meeting.neighborhoods.join(",")}"
      end

    end



    def menu
      puts "\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit.\n"
      display_meetings
      puts
      # binding.pry
      input = nil

      # while input != "exit"
      while input != "exit"
      # binding.pry
      # puts "\n\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit."
      input = gets.strip.downcase
          if input.to_i > 0 && input.to_i <= CommunityMeeting1.all.size
            print_meeting_info(input)
            # menu
            puts "\n\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To exit to quit the program."
          elsif input == "list"
            display_meetings
            puts "\n\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit."
          else
            puts "\n\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit."
          end
        end

    end


    def print_meeting_info(input)
      # binding.pry
      i = input.to_i
      meeting = CommunityMeeting1.all[i.to_i - 1]
      # puts "\nYou selected #{meeting.neighborhoods.join(",")} - #{meeting.name}\n"
      puts "\nYou selected #{meeting.neighborhoods} - #{meeting.name}\n"
      puts "\nWhat information would you like about the community's meeting?\n"
      puts "\nEnter 'time' for the meeting dates and times, 'address' for the meeting's address, 'phone' for the board's phone number, 'agenda' for the latest agenda, 'website' for the webpage, or 'menu' for the main page \n"

      until i == "menu"
      # puts "\nType 'menu' for the main page, 'website' for the webpage, 'time' for the meeting dates and hours, 'address' for the meeting's address, 'phone' for the board's phone number, or 'agenda' for the latest agenda. \n"
      i = gets.strip.downcase

          if i == "address"
            puts
            puts meeting.address
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          elsif i == "website"
            puts
            puts meeting.website
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          elsif i == "time"
            puts
            puts meeting.hours
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          elsif i == "phone"
            puts
            puts meeting.phone
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
            #last agenda
            #open the website
          elsif i == "agenda"
            puts
            puts meeting.agenda
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          else
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          end
      end
    end


    def goodbye
      puts "Until next time!"
    end

end

CLI.new.run
