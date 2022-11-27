class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.string :name, null: false, limit: 255
      t.string :address, null: false, limit: 255
      t.integer :phone, null: false

      t.timestamps
    end
    add_index :banks, :name, unique: true
  end
end
