class Alien < ActiveRecord::Base

has_many :users, through: :mortydexes
has_many :mortydexes

end
