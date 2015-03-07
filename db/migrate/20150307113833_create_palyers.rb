class CreatePalyers < ActiveRecord::Migration
  def change
    create_table :palyers do |t|
      t.references :user, index: true
      t.references :room, index: true
      t.integer :x
      t.integer :y
      t.integer :status

      t.timestamps null: false
    end
    add_foreign_key :palyers, :users
    add_foreign_key :palyers, :rooms
  end
end
