class Alien < ActiveRecord::Base

belongs_to :planet
has_many :users, through: :mortydexes
has_many :mortydexes

end
