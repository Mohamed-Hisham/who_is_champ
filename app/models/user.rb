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

  has_many :user_badges
  has_many :badges, through: :user_badges
  # Functions
  def update_points(new_points)
    self.update_attribute(:pts, new_points)
  end

  def reset_points
    self.update_attribute(:pts, 0)
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

  def award_badge
    self.first_sign_in
    self.early
    # self.lastmonth
    self.number_sign_ins
    # self.high_rules
    # self.normal_rules
    # self.low_rules
  end

  def first_sign_in
    user_badge_entry = UserBadge.find_or_create_by!(user_id: self.id, game_id: self.game.id, badge_id: Badge.find_by(badge_type: "firstsignin").id)
    user_badge_entry.update(achieved: true) if self.sign_in_count >= 1
  end

  def early
    user_badge_entry = UserBadge.find_or_create_by!(user_id: self.id, game_id: self.game.id, badge_id: Badge.find_by(badge_type: "early").id)
    if self.current_sign_in_at.strftime("%H").to_i >= 3 && self.current_sign_in_at.strftime("%H").to_i <= 7
      user_badge_entry.update(achieved: true)
    end
  end

  def lastmonth
    user_badge_entry = UserBadge.find_or_create_by!(user_id: self.id, game_id: self.game.id, badge_id: Badge.find_by(badge_type: "lastmonth").id)
    if self.current_sign_in_at <= 1.month.ago
      user_badge_entry.update(achieved: true)
    end
  end

  def number_sign_ins
    user_badge_entry = UserBadge.find_or_create_by!(user_id: self.id, game_id: self.game.id, badge_id: Badge.find_by(badge_type: "signinl1").id)
    user_badge_entry.update(achieved: true) if self.sign_in_count >= 10

    user_badge_entry = UserBadge.find_or_create_by!(user_id: self.id, game_id: self.game.id, badge_id: Badge.find_by(badge_type: "signinl2").id)
    user_badge_entry.update(achieved: true) if self.sign_in_count >= 20

    user_badge_entry = UserBadge.find_or_create_by!(user_id: self.id, game_id: self.game.id, badge_id: Badge.find_by(badge_type: "signinl3").id)
    user_badge_entry.update(achieved: true) if self.sign_in_count >= 30
  end

  def high_rules
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "highl1").id, achieved: true) if self.sign_in_count >= 10
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "highl2").id, achieved: true) if self.sign_in_count >= 20
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "highl3").id, achieved: true) if self.sign_in_count >= 30
  end

  def normal_rules
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "normall1").id, achieved: true) if self.sign_in_count >= 10
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "normall2").id, achieved: true) if self.sign_in_count >= 20
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "normall3").id, achieved: true) if self.sign_in_count >= 30
  end

  def low_rules
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "lowl1").id, achieved: true) if self.sign_in_count >= 10
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "lowl2").id, achieved: true) if self.sign_in_count >= 20
    @user_badge_entry.update(badge_id: Badge.find_by(badge_type: "lowl3").id, achieved: true) if self.sign_in_count >= 30
  end
    # if @user_badge_entry
    #   puts "Awarded Badge"
    # else
    #   puts "ERROR AWARD"
    # end
end
