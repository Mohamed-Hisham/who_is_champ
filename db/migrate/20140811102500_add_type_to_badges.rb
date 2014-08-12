class AddTypeToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :badge_type, :string
  end
end
