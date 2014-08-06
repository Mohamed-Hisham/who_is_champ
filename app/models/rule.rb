class Rule < ActiveRecord::Base
  enum priority: [ :normal, :high, :low ]

  # Validations
  validates :description, :priority, presence: true
  validates :priority, inclusion: {in: %w(normal high low),
    message: "%{value} is not a valid rule priority" }

  # Associations
  belongs_to :game
  has_many :user_rules
  has_many :users, through: :user_rules

end