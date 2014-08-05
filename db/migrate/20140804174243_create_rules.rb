class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :description
      t.integer :priority, default: 0
      t.integer :status, default: 0
      t.integer :game_id

      t.timestamps
    end
  end
end
