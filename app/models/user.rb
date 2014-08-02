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

  # Associations
  belongs_to :game
end
