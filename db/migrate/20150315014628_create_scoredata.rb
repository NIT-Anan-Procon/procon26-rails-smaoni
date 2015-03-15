class CreateScoredata < ActiveRecord::Migration
  def change
    create_table :scoredata do |t|
      t.string :email
      t.integer :score
      t.datetime :scored_at

      t.timestamps null: false
    end
  end
end
