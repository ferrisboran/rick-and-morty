class Planet < ActiveRecord::Base

  has_many :aliens
  has_many :mortydexes, through: :aliens

  attr_reader :user, :mortydex

  def self.display_all_planets
    self.all.map do |planets|
      planets["name"]
    end
  end

  def self.display_five_planet
    display_all_planets.sample(5).join(" <-> ")
  end

  def self.visit_planet
    puts "type out:"
    self.display_all_planets.where(["name = ?", planet.id])
  end

  end



end
