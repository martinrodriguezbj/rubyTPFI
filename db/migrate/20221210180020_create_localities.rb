class CreateLocalities < ActiveRecord::Migration[7.0]
  def change
    create_table :localities do |t|
      t.string :locality, null: false, limit: 255
      t.string :province, null: false, limit: 255

      t.timestamps
    end
  end
end
