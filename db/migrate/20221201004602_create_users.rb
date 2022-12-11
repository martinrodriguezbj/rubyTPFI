class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :roll, null: false
      t.integer :bank_id
      t.string :name, null: false
      t.string :surname, null: false
      t.string :phone
      t.string :address, null: false
      t.string :email, null: false

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
