class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :pts_per_rule, null: false, default: 100
      t.string :expert_rank, null: false
      t.string :normal_rank, null: false
      t.string :starter_rank, null: false

      t.timestamps
    end
  end
end
