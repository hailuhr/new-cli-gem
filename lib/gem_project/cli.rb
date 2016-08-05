# our cli controller  - user interactions welcoming/dealing with input
class GemProject::CLI

  def call
    puts "Welcome to Community Meetings! Learn more about what's happening in your neighborhood. Enter the number for one of your neighborhoods below to find out about the community meetings and what's being discussed for it!\n"
    # puts "\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. Type exit to quit the program.\n"
    puts
    menu
    goodbye
  end

  def list_
    @meetings = GemProject::CommunityMeeting.scrape_all
    count = 0
    puts
    @meetings.each do |meeting|

        puts "#{count += 1}. #{meeting.neighborhoods.join(",")}"
      end
  end

    def menu
      # puts "\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit.\n"
      list_
      puts
      # binding.pry
      input = nil

      # while input != "exit"
      while input != "exit"
      # binding.pry
      # puts "\n\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit."
      input = gets.strip.downcase
          if input.to_i > 0
            print_meeting_info(input)
            # menu
            puts "\n\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To exit to quit the program."
          elsif input == "list"
            list_
            puts "\n\nEnter the number of the neighborhood you would like to get more information on. Type list to see all options again. To quit the program type exit."
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

      until i == "menu"
      # puts "\nType 'menu' for the main page, 'website' for the webpage, 'time' for the meeting dates and hours, 'address' for the meeting's address, 'phone' for the board's phone number, or 'agenda' for the latest agenda. \n"
      i = gets.strip.downcase

          if i == "address"
            puts
            puts meeting.address
            puts "\nEnter time, address, phone, agenda, website, or menu.\n"
          elsif i == "website"
            puts
            puts meeting.url
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
          end
      end
    end


    def goodbye
      puts "Until next time!"
    end

end
