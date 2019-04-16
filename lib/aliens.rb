class Alien < ActiveRecord::Base
#
#
# belongs_to :planets
has_many :users, through: :mortydexes
has_many :mortydexes


end
