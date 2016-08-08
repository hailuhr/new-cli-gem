require 'pry'
require 'open-uri'
require 'nokogiri'


class Scraper


  def self.scrape_names(nyc_url)
    # doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
    doc = Nokogiri::HTML(open(nyc_url))
    names = doc.css('td.cb_title').map{ |title| title.text }
      names
  end

  def self.scrape_neighborhoods(nyc_url)
    doc = Nokogiri::HTML(open(nyc_url))
    array_of_board_neighborhoods = doc.css('td.cb_text#top').map do |el|
      el.text.split(',')
    end
  end


  def self.scrape_websites(nyc_url)
    # doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
    doc = Nokogiri::HTML(open(nyc_url))
    array_of_urls = doc.css('td.cb_text a/@href').map{ |el| el.text }

  end


  def self.scrape_phone_address(nyc_url)
    doc = Nokogiri::HTML(open(nyc_url))
    array = doc.css('tbody').map { |el| el.text }
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
    end

    def self.scraped_addresses(nyc_url)
        scrape_phone_address(nyc_url)[1]
    end


    def self.scrape_hours(nyc_url)
      # doc = Nokogiri::HTML(open("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml"))
      doc = Nokogiri::HTML(open(nyc_url))
      time = []
      array = doc.css('tbody').map{ |el| el.text }

      array.each_with_index.map do |meeting, i|

          mtg_hours = []
          k = array[i].index("Meeting")

          j = array[i].index("Precinct")
          words = ""
          words << array[i][k..j-1]
          hours = words.split("Cabinet")
          part1 = "Board #{hours[0]}. "
          part2 = "Cabinet #{hours[1].gsub("\n", "")}."
          mtg_hours = [part1 + part2]

          time << mtg_hours

        end
        no_repeated_times = []

        time.each_with_index do |el, i|
          no_repeated_times << el if i.even?
        end

        no_repeated_times
        # binding.pry
      end


      def self.meeting_hash(url)

        hashes = []

        scrape_names(url).each_with_index do |name, i|
          meeting = {}
          meeting[:name] = name

          meeting[:phone] = scraped_phones(url)[i.to_i]
          meeting[:website] = scrape_websites(url)[i.to_i]
          meeting[:hours] = scrape_hours(url)[i.to_i]
          meeting[:neighborhoods] = scrape_neighborhoods(url)[i.to_i].join(",")
          meeting[:address] = scraped_addresses(url)[i.to_i]

            if meeting[:name] == "Community Board 10"
              meeting[:agenda] = "PDF files of Community Board 10's agenda can be found here: http://www.nyc.gov/html/mancb10/html/board/minutes.shtml"
            elsif meeting[:name] == "Community Board 1"
              meeting[:agenda] = one_agenda("http://www.nyc.gov/html/mancb1/html/community/community.shtml")
            elsif
              meeting[:agenda] = "Agenda currently unavailable - can be found on home website"
            end

          hashes << meeting
        end

        hashes

      end




    def self.one_agenda(url)
      doc = Nokogiri::HTML(open(url))
      page = doc.css("span.bodytext").text.split("Location")
      sentence = page[1].split("Conference Room")[1].split("Centre")
      s = sentence[1].gsub("\"", "").gsub("\n"," ").split("1)")
      sentence_output = "1) #{s[1]}"
    end




end



# Scraper.meeting_hash("http://www.nyc.gov/html/cau/html/cb/manhattan.shtml")
