class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :password
      t.string :hash
      t.string :name

      t.timestamps null: false
    end
  end
end
