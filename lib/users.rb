class User < ActiveRecord::Base

  attr_reader :planets, :mortydex

  has_many :mortydexes
  has_many :aliens, through: :mortydexes

  def planets
    self.aliens.map do |alien|
      alien.planet
    end.uniq
  end

  def view_mortydex
    self.aliens.map do |alien|
      "#{alien.id}: #{alien.name} (#{alien.planet.name})"
    end.uniq
  end

  def mortydex
    puts "You've collected #{self.aliens.length} aliens"
    puts "You've been to #{self.planets.length} planets"
    puts "------------------------"
    puts self.view_mortydex
    puts "------------------------"
    puts "Learn more by pressing 1-5"
    gets.chomp
  end

  def view_highscore
    self.aliens.sum(:points)
  end

end
