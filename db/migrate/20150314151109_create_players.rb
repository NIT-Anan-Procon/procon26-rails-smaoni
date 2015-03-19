class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :user, index: true
      t.integer :x, :default => 0
      t.integer :y, :default => 0
      t.boolean :is_oni, :default => false
      t.boolean :is_invisible, :default => false
      t.datetime :invisible_end
      t.integer :score, :default => 0
      t.boolean :is_in_room, :default => false

      t.timestamps null: false
    end
    add_foreign_key :players, :users
  end
end
