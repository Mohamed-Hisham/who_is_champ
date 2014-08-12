class Game < ActiveRecord::Base

  # Validations
  validates :name, :description, :pts_per_rule, :expert_rank, :normal_rank, :starter_rank, presence: true
  validates :pts_per_rule, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than: 1000}

  # Relations
  belongs_to :creator
  has_many :users, dependent: :destroy
  has_many :rules, dependent: :destroy
  has_many :user_rules, dependent: :destroy
  has_many :user_badges, dependent: :destroy

  # Functions
end