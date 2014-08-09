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

  def set_starter_rank
    self.update_attribute(:rank, self.game.starter_rank)
  end

  def check_rank
    if pts >= self.game.pts_per_rule * 4
      self.set_rank(self.game.expert_rank)
    elsif pts >= self.game.pts_per_rule * 2
      self.set_rank(self.game.normal_rank)
    elsif
      self.set_rank(self.game.starter_rank)
    end
  end

  def set_rank(rank)
    self.update_attribute(:rank, rank)
  end
end
