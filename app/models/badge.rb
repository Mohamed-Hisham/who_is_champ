class Badge < ActiveRecord::Base
  # Validations
  validates :name, presence: true
  # validates :achieved, inclusion: { in: [true, false], message: "%{value} is not a valid achievement flag." }

  # Upload
  mount_uploader :badge, AvatarUploader

  # Associations
  has_many :user_badges
  has_many :users, through: :user_badges
end