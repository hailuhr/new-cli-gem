# our cli controller  - user interactions welcoming/dealing with input
class GemProject::CLI

  def call
    puts "Welcome to Community Meetings! Learn more about what's happening in your neighborhood. Select your neighborhood of choice to know what's being discussed for the neighborhood and the details for its community meetings.\n"
    menu
    goodbye
  end

  def list_
    @meetings = GemProject::CommunityMeeting.scrape_all
    count = 0
    @meetings.each do |meeting|
        puts "#{count += 1}. #{meeting.neighborhoods.join(",")}"
      end
  end

    def menu
      puts "\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit.\n"
      list_
      puts
      # binding.pry
      input = nil

      while input != "exit"
      input = gets.strip.downcase
          if input.to_i > 0
            print_meeting_info(input)
            menu
          elsif input == "list"
            list_
            puts "\n\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit."
          else
            puts "Please type list, exit, or an option number.\n\n"
          end
      end

    end


    def print_meeting_info(input)
      # binding.pry
      i = input.to_i
      meeting = @meetings[i.to_i - 1]
      puts "\nYou selected #{meeting.neighborhoods.join(",")} - #{meeting.name}\n"
      puts "\nWhat information would you like about the community's meeting?\n"
      puts "\nEnter 'time' for the meeting dates and times, 'address' for the meeting's address, 'phone' for the board's phone number, 'agenda' for the latest agenda, 'website' for the webpage, or 'menu' for the main page \n"

      while i != "menu"
      i = gets.strip.downcase
          if i == "address"
            puts meeting.address
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          elsif i == "website"
            puts meeting.url
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          elsif i == "time"
            puts meeting.hours
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          elsif i == "phone"
            puts meeting.phone
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
            #last agenda
            #open the website
          elsif i == "agenda"
            puts meeting.agenda
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          else
            #why does the below repeat when main is typed
            puts "\nType 'menu' for the main page, 'website' for the webpage, 'time' for the meeting dates and hours, 'address' for the meeting's address, 'phone' for the board's phone number, or 'agenda' for the latest agenda. \n"
          end
      end
    end


    def goodbye
      puts "Until next time!"
    end

end
