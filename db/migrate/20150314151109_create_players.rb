class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :user, index: true
      t.integer :x
      t.integer :y
      t.boolean :is_oni
      t.boolean :is_invisible
      t.datetime :invisible_end_at
      t.integer :score
      t.boolean :is_in_room

      t.timestamps null: false
    end
    add_foreign_key :players, :users
  end
end
