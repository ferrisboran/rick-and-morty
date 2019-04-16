class User < ActiveRecord::Base
  # belongs_to :mortydexes
  # has_many :planets, through: :aliens
  has_many :aliens, through: :mortydexes
  has_many :mortydexes

  #
  # def mortydex
  #   self.aliens
  # end



end
