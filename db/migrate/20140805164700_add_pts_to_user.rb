class AddPtsToUser < ActiveRecord::Migration
  def change
    add_column :users, :pts, :integer, default: 0
  end
end
