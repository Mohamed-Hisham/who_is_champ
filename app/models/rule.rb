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

  # Functions
  def priority_points
    if self.priority == "normal"
      extra_priority_points = 1.25
    elsif self.priority == "high"
      extra_priority_points = 1.5
    elsif self.priority == "low"
      extra_priority_points = 1
    end
    return extra_priority_points
  end

end