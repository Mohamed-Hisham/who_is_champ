class UserBadge < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :badge
  belongs_to :game

end
