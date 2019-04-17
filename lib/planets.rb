class Planet < ActiveRecord::Base

  has_many :aliens
  has_many :mortydexes, through: :aliens

  attr_reader :user, :mortydex

  def self.display_all_planets
    self.all.map do |planets|
      planets["name"]
    end
  end

  def self.display_five_planets
    i = 0
    display_all_planets.sample(5).each do |planet|
      puts "#{i+1}. #{planet}"
      i += 1
    end
  end

end
