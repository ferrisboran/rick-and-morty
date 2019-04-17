class User < ActiveRecord::Base

  attr_reader :planets, :mortydex

  has_many :mortydexes
  has_many :aliens, through: :mortydexes

  def planets
    self.aliens.map do |alien|
      alien.planet
    end
  end

  def mortydex
    self.aliens.map do |alien|
      puts "#{alien.name} (#{alien.planet.name})"
    end.uniq
  end

end
