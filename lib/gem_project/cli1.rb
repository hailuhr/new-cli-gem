require_relative 'scraper'
require_relative 'community_meeting1'
require 'nokogiri'
require 'pry'


class GemProject::CLI1
    BASE_URL = "http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"

    def run
      make_meetings
      # display_meetings
      puts "Welcome to Community Meetings. Learn more about what's happening in your neighborhood.\n"
      puts "Enter the number for one of the neighborhoods listed below to find out about its community meetings, what's being discussed for it and more details."
      puts
      menu
      goodbye
          # binding.pry
    end

    def make_meetings
      meeting_array = []
      meeting_array = Scraper.meeting_hash(BASE_URL)
      GemProject::CommunityMeeting1.create_from_collection(meeting_array)

    end


    def display_meetings
      count = 0
      GemProject::CommunityMeeting1.all.map do |meeting|
        puts "#{count += 1}. #{meeting.neighborhoods}"

      end

    end



    def menu
      # puts "\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit.\n"
      display_meetings
      puts
      # binding.pry
      input = nil

      # while input != "exit"
      while input != "exit"
      input = gets.strip.downcase
          if input.to_i > 0 && input.to_i <= GemProject::CommunityMeeting1.all.size
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
      meeting = GemProject::CommunityMeeting1.all[i.to_i - 1]
      puts "\nYou selected #{meeting.neighborhoods} - #{meeting.name}\n"
      puts "\nWhat information would you like about the community's meeting?\n"
      puts "\nEnter 'time' for the meeting dates and times, 'address' for the meeting's address, 'phone' for the board's phone number, 'agenda' for the latest agenda, 'website' for the webpage, or 'menu' for the main page \n"

      until i == "menu"
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
            #option for last agenda
            #ability to open the website
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


# CLI.new.run
