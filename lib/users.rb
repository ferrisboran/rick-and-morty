class User < ActiveRecord::Base

  has_many :aliens, through: :mortydexes
  has_many :mortydexes

end
