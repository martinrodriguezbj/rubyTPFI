class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.belongs_to :bank, null: false, foreign_key: { on_delete: :cascade }
      t.string :day
      t.integer :startAttention
      t.integer :endAttention

      t.timestamps
    end
  end
end
