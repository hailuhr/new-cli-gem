require 'pry'
require 'open-uri'

class GemProject::CommunityMeeting1

  attr_accessor :name, :neighborhoods, :address, :website, :phone, :hours, :agenda

  @@all = []

  def initialize(meeting_hash)

    @name = meeting_hash[:name]
    @neighborhoods = meeting_hash[:neighborhoods]
    @address = meeting_hash[:address]
    @website = meeting_hash[:website]
    @agenda = meeting_hash[:agenda]
    @hours = meeting_hash[:hours]
    @phone = meeting_hash[:phone]

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


# harlem = GemProject::CommunityMeeting1.new
