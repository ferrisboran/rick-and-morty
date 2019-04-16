class User < ActiveRecord::Base
  def initialize
    Mortydex.create(user_id: self.id)
  end
end
