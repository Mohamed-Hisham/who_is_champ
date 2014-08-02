class Creator < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Validations
  validates :name, :presence => true
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  include DeviseInvitable::Inviter

  # Upload
  mount_uploader :avatar, AvatarUploader

  # Relations
  has_many :games, dependent: :destroy
end
