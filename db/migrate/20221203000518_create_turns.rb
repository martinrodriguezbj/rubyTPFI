class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.belongs_to :bank, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.date :day 
      t.string :hour
      t.string :reason, null: false
      t.string :state , default: "pending"
      t.string :result
      t.string :bank_staff

      t.timestamps
    end
  end
end
