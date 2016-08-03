# our cli controller  - user interactions welcoming/dealing with input
class GemProject::CLI

  def call
    puts "Todays GemProject"
    list_
    menu
    goodbye
  end

  def list_
    #here docs? blog jay fields.com
    # puts "List of things  1 and 2 "
    @meetings = GemProject::CommunityMeetings.boards
    #^^changing it from being hardcoded
    @meetings.each.with_index(1) do |meetings, i|
      puts "#{i}. #{meetings.name} - #{meetings.address} - #{meetings.url}"
    end
  end

  def menu
    input = nil
      while input != "exit"
      puts "Enter the number of the information you would like to view. Type list to see all options again. To quit the program type exit."
      input = gets.strip.downcase

      if input.to_i > 0
        the_meeting = @meetings[input.to_i - 1]
        puts "#{the_meeting.name} - #{the_meeting.address} - #{the_meeting.url}"
        puts @meetings[input.to_i - 1]
      elsif input == "list"
        list_
      else
        puts "Please type list, exit, or an option number."
      end

        # case input
        # when "1"
        #   puts "More info on option 1..."
        # when "2"
        #   puts "More info on option 2..."
        # when "3"
        #   puts "More info on option 3..."
        # when "list"
        #   list_
        # else
        #   puts "Please type list, exit, or an option number."
        # end

      end
    end

    def goodbye
      puts "Until the next time!"
    end

end
