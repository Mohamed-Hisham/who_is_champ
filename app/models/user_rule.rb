class UserRule < ActiveRecord::Base
  enum status: [ :normal, :pending, :complete ]

  # Associations
  belongs_to :user
  belongs_to :rule


  # Functions
  def update_status(new_status)
    self.update_attribute(:status, new_status)
  end

end
