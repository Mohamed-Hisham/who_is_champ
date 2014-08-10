class AddGameToUserRule < ActiveRecord::Migration
  def change
    add_column :user_rules, :game_id, :integer
  end
end
