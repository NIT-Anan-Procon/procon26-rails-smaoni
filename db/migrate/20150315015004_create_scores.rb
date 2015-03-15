class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :email
      t.integer :point
      t.datetime :scored_at

      t.timestamps null: false
    end
  end
end
