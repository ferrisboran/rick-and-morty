class User < ActiveRecord::Base

  attr_reader :planets

  has_many :mortydexes
  has_many :aliens, through: :mortydexes

  def planets
    self.aliens.map do |alien|
      alien.planet
    end
  end

end
