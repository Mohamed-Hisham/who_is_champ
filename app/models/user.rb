class User < ActiveRecord::Base

  # Devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Upload
  mount_uploader :avatar, AvatarUploader

  # Validations
  validates :name, :presence => true
  validates :pts, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  # Associations
  belongs_to :game
  has_many :user_rules
  has_many :rules, through: :user_rules

  # Functions
  def update_points(new_points)
    self.update_attribute(:pts, new_points)
  end
end
