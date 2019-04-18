
require 'pry'

class Planet < ActiveRecord::Base

  has_many :aliens
  has_many :mortydexes, through: :aliens

  attr_reader :user, :mortydex, :review_planet_profile

  def self.display_all_planets
    self.all.map do |planets|
      planets["name"]
    end
  end

end
